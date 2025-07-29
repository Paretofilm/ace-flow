import { useState, useEffect } from 'react';
import { getUrl } from 'aws-amplify/storage';
import type { Recipe } from '../../types';

interface RecipeCardProps {
  recipe: Recipe;
  onClick?: () => void;
}

export default function RecipeCard({ recipe, onClick }: RecipeCardProps) {
  const [imageUrl, setImageUrl] = useState<string | null>(null);

  useEffect(() => {
    const loadImage = async () => {
      if (recipe.imageKey) {
        try {
          const { url } = await getUrl({
            path: recipe.imageKey,
            options: {
              expiresIn: 3600, // 1 hour
            },
          });
          setImageUrl(url.toString());
        } catch (error) {
          console.error('Failed to load recipe image:', error);
        }
      }
    };

    loadImage();
  }, [recipe.imageKey]);

  return (
    <div className="recipe-card" onClick={onClick}>
      {imageUrl && (
        <div className="recipe-image">
          <img src={imageUrl} alt={recipe.title} />
        </div>
      )}
      <div className="recipe-content">
        <h3>{recipe.title}</h3>
        <p className="recipe-description">{recipe.description}</p>
        <div className="recipe-meta">
          {recipe.cookingTime && (
            <span className="cooking-time">⏱️ {recipe.cookingTime} min</span>
          )}
          {recipe.servings && (
            <span className="servings">🍽️ {recipe.servings} servings</span>
          )}
        </div>
        <div className="recipe-author">
          By {recipe.authorName || 'Anonymous'}
        </div>
      </div>
    </div>
  );
}