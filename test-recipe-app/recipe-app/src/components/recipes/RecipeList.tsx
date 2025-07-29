import { useState, useEffect } from 'react';
import { client } from '../../lib/amplify-client';
import type { Recipe } from '../../types';
import RecipeCard from './RecipeCard';
import { handleError } from '../../utils/errorHandling';

interface RecipeListProps {
  onRecipeClick?: (recipeId: string) => void;
}

export default function RecipeList({ onRecipeClick }: RecipeListProps) {
  const [recipes, setRecipes] = useState<Recipe[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    // Subscribe to real-time updates
    const subscription = client.models.Recipe.observeQuery().subscribe({
      next: ({ items, isSynced }) => {
        if (isSynced) {
          setRecipes([...items]);
          setLoading(false);
        }
      },
      error: (error) => {
        const errorMessage = handleError(error, 'Recipe subscription');
        setError(errorMessage);
        setLoading(false);
      },
    });

    return () => subscription.unsubscribe();
  }, []);

  if (loading) {
    return <div className="loading">Loading recipes...</div>;
  }

  if (error) {
    return <div className="error">{error}</div>;
  }

  if (recipes.length === 0) {
    return (
      <div className="empty-state">
        <p>No recipes yet. Be the first to share one!</p>
      </div>
    );
  }

  return (
    <div className="recipe-list">
      <h2>All Recipes</h2>
      <div className="recipe-grid">
        {recipes.map((recipe) => (
          <RecipeCard 
            key={recipe.id} 
            recipe={recipe} 
            onClick={() => onRecipeClick?.(recipe.id)}
          />
        ))}
      </div>
    </div>
  );
}