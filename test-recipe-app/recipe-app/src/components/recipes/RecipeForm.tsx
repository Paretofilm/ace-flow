import { useState } from 'react';
import { client } from '../../lib/amplify-client';
import { useAuth } from '../../hooks/useAuth';
import RecipePhotoUpload from './RecipePhotoUpload';
import { validateRecipeInput, sanitizeInput } from '../../utils/validation';
import { handleError } from '../../utils/errorHandling';
import type { RecipeInput } from '../../types';

interface RecipeFormProps {
  onSuccess?: () => void;
  onCancel?: () => void;
}

export default function RecipeForm({ onSuccess, onCancel }: RecipeFormProps) {
  const { user } = useAuth();
  const [loading, setLoading] = useState(false);
  const [errors, setErrors] = useState<string[]>([]);
  const [imageKey, setImageKey] = useState<string>('');
  
  const [formData, setFormData] = useState<RecipeInput>({
    title: '',
    description: '',
    ingredients: [''],
    instructions: '',
    cookingTime: undefined,
    servings: undefined,
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    // Validate input
    const validation = validateRecipeInput(formData);
    if (!validation.valid) {
      setErrors(validation.errors);
      return;
    }

    setLoading(true);
    setErrors([]);

    try {
      // Sanitize inputs
      const sanitizedData = {
        ...formData,
        title: sanitizeInput(formData.title),
        description: sanitizeInput(formData.description),
        instructions: sanitizeInput(formData.instructions),
        ingredients: formData.ingredients
          .filter(ing => ing.trim().length > 0)
          .map(ing => sanitizeInput(ing)),
        authorName: user?.username || 'Anonymous',
        imageKey: imageKey || undefined,
      };

      const { errors } = await client.models.Recipe.create(sanitizedData);
      
      if (errors) {
        throw new Error('Failed to create recipe');
      }

      // Clear form
      setFormData({
        title: '',
        description: '',
        ingredients: [''],
        instructions: '',
        cookingTime: undefined,
        servings: undefined,
      });
      setImageKey('');
      
      onSuccess?.();
    } catch (error) {
      const errorMessage = handleError(error, 'Recipe creation');
      setErrors([errorMessage]);
    } finally {
      setLoading(false);
    }
  };

  const handleIngredientChange = (index: number, value: string) => {
    const newIngredients = [...formData.ingredients];
    newIngredients[index] = value;
    setFormData({ ...formData, ingredients: newIngredients });
  };

  const addIngredient = () => {
    setFormData({ ...formData, ingredients: [...formData.ingredients, ''] });
  };

  const removeIngredient = (index: number) => {
    const newIngredients = formData.ingredients.filter((_, i) => i !== index);
    setFormData({ ...formData, ingredients: newIngredients });
  };

  return (
    <form onSubmit={handleSubmit} className="recipe-form">
      <h2>Create New Recipe</h2>
      
      {errors.length > 0 && (
        <div className="error-messages">
          {errors.map((error, index) => (
            <p key={index} className="error">{error}</p>
          ))}
        </div>
      )}

      <div className="form-group">
        <label htmlFor="title">Title *</label>
        <input
          id="title"
          type="text"
          value={formData.title}
          onChange={(e) => setFormData({ ...formData, title: e.target.value })}
          required
          disabled={loading}
        />
      </div>

      <div className="form-group">
        <label htmlFor="description">Description *</label>
        <textarea
          id="description"
          value={formData.description}
          onChange={(e) => setFormData({ ...formData, description: e.target.value })}
          required
          disabled={loading}
          rows={3}
        />
      </div>

      <div className="form-group">
        <label>Ingredients *</label>
        {formData.ingredients.map((ingredient, index) => (
          <div key={index} className="ingredient-input">
            <input
              type="text"
              value={ingredient}
              onChange={(e) => handleIngredientChange(index, e.target.value)}
              placeholder={`Ingredient ${index + 1}`}
              disabled={loading}
            />
            {formData.ingredients.length > 1 && (
              <button
                type="button"
                onClick={() => removeIngredient(index)}
                disabled={loading}
                className="remove-button"
              >
                Remove
              </button>
            )}
          </div>
        ))}
        <button
          type="button"
          onClick={addIngredient}
          disabled={loading}
          className="add-button"
        >
          Add Ingredient
        </button>
      </div>

      <div className="form-group">
        <label htmlFor="instructions">Instructions *</label>
        <textarea
          id="instructions"
          value={formData.instructions}
          onChange={(e) => setFormData({ ...formData, instructions: e.target.value })}
          required
          disabled={loading}
          rows={5}
        />
      </div>

      <div className="form-row">
        <div className="form-group">
          <label htmlFor="cookingTime">Cooking Time (minutes)</label>
          <input
            id="cookingTime"
            type="number"
            value={formData.cookingTime || ''}
            onChange={(e) => setFormData({ ...formData, cookingTime: parseInt(e.target.value) || undefined })}
            min="0"
            disabled={loading}
          />
        </div>

        <div className="form-group">
          <label htmlFor="servings">Servings</label>
          <input
            id="servings"
            type="number"
            value={formData.servings || ''}
            onChange={(e) => setFormData({ ...formData, servings: parseInt(e.target.value) || undefined })}
            min="1"
            disabled={loading}
          />
        </div>
      </div>

      <div className="form-group">
        <label>Recipe Photo</label>
        <RecipePhotoUpload
          onUploadSuccess={(path) => setImageKey(path)}
          disabled={loading}
        />
      </div>

      <div className="form-actions">
        <button type="submit" disabled={loading} className="submit-button">
          {loading ? 'Creating...' : 'Create Recipe'}
        </button>
        {onCancel && (
          <button
            type="button"
            onClick={onCancel}
            disabled={loading}
            className="cancel-button"
          >
            Cancel
          </button>
        )}
      </div>
    </form>
  );
}