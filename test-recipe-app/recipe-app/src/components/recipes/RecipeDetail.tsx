import { useState, useEffect } from 'react';
import { getUrl } from 'aws-amplify/storage';
import { client } from '../../lib/amplify-client';
import { useAuth } from '../../hooks/useAuth';
import CommentList from '../comments/CommentList';
import type { Recipe } from '../../types';
import { handleError } from '../../utils/errorHandling';

interface RecipeDetailProps {
  recipeId: string;
  onEdit?: () => void;
  onDelete?: () => void;
  onBack?: () => void;
}

export default function RecipeDetail({ recipeId, onEdit, onDelete, onBack }: RecipeDetailProps) {
  const { user } = useAuth();
  const [recipe, setRecipe] = useState<Recipe | null>(null);
  const [imageUrl, setImageUrl] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [deleting, setDeleting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const isOwner = user?.userId === recipe?.owner;

  useEffect(() => {
    loadRecipe();
  }, [recipeId]);

  useEffect(() => {
    if (recipe?.imageKey) {
      loadImage(recipe.imageKey);
    }
  }, [recipe?.imageKey]);

  const loadRecipe = async () => {
    try {
      const { data, errors } = await client.models.Recipe.get({ id: recipeId });
      
      if (errors || !data) {
        throw new Error('Recipe not found');
      }

      setRecipe(data);
    } catch (error) {
      const errorMessage = handleError(error, 'Recipe loading');
      setError(errorMessage);
    } finally {
      setLoading(false);
    }
  };

  const loadImage = async (imageKey: string) => {
    try {
      const { url } = await getUrl({
        path: imageKey,
        options: {
          expiresIn: 3600, // 1 hour
        },
      });
      setImageUrl(url.toString());
    } catch (error) {
      console.error('Failed to load recipe image:', error);
    }
  };

  const handleDelete = async () => {
    if (!window.confirm('Are you sure you want to delete this recipe? This action cannot be undone.')) {
      return;
    }

    setDeleting(true);

    try {
      // Delete associated comments first
      const { data: comments } = await client.models.Comment.list({
        filter: { recipeId: { eq: recipeId } },
      });

      // Delete all comments
      await Promise.all(
        comments.map(comment => 
          client.models.Comment.delete({ id: comment.id })
        )
      );

      // Delete the recipe
      const { errors } = await client.models.Recipe.delete({ id: recipeId });

      if (errors) {
        throw new Error('Failed to delete recipe');
      }

      onDelete?.();
    } catch (error) {
      const errorMessage = handleError(error, 'Recipe deletion');
      alert(errorMessage);
    } finally {
      setDeleting(false);
    }
  };

  if (loading) {
    return <div className="loading">Loading recipe...</div>;
  }

  if (error || !recipe) {
    return (
      <div className="error-state">
        <p>{error || 'Recipe not found'}</p>
        <button onClick={onBack}>Back to Recipes</button>
      </div>
    );
  }

  return (
    <div className="recipe-detail">
      <div className="recipe-header">
        <button onClick={onBack} className="back-button">
          ← Back to Recipes
        </button>
        
        {isOwner && (
          <div className="recipe-actions">
            <button onClick={onEdit} className="edit-button">
              Edit Recipe
            </button>
            <button 
              onClick={handleDelete} 
              disabled={deleting}
              className="delete-button"
            >
              {deleting ? 'Deleting...' : 'Delete Recipe'}
            </button>
          </div>
        )}
      </div>

      {imageUrl && (
        <div className="recipe-hero-image">
          <img src={imageUrl} alt={recipe.title} />
        </div>
      )}

      <div className="recipe-content">
        <h1>{recipe.title}</h1>
        
        <div className="recipe-meta">
          <span className="author">By {recipe.authorName || 'Anonymous'}</span>
          {recipe.cookingTime && (
            <span className="cooking-time">⏱️ {recipe.cookingTime} minutes</span>
          )}
          {recipe.servings && (
            <span className="servings">🍽️ {recipe.servings} servings</span>
          )}
        </div>

        <div className="recipe-description">
          <h2>Description</h2>
          <p>{recipe.description}</p>
        </div>

        <div className="recipe-ingredients">
          <h2>Ingredients</h2>
          <ul>
            {recipe.ingredients?.map((ingredient, index) => (
              <li key={index}>{ingredient}</li>
            ))}
          </ul>
        </div>

        <div className="recipe-instructions">
          <h2>Instructions</h2>
          <p className="instructions-text">{recipe.instructions}</p>
        </div>
      </div>

      <CommentList recipeId={recipeId} />
    </div>
  );
}