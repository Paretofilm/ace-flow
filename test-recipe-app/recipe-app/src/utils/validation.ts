export const sanitizeInput = (input: string): string => {
  return input
    .trim()
    .replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, '')
    .replace(/[<>]/g, '');
};

export const validateRecipeInput = (recipe: any): { valid: boolean; errors: string[] } => {
  const errors: string[] = [];

  if (!recipe.title || recipe.title.trim().length === 0) {
    errors.push('Title is required');
  }

  if (!recipe.description || recipe.description.trim().length === 0) {
    errors.push('Description is required');
  }

  if (!recipe.ingredients || recipe.ingredients.length === 0) {
    errors.push('At least one ingredient is required');
  }

  if (!recipe.instructions || recipe.instructions.trim().length === 0) {
    errors.push('Instructions are required');
  }

  if (recipe.cookingTime && recipe.cookingTime < 0) {
    errors.push('Cooking time must be positive');
  }

  if (recipe.servings && recipe.servings < 1) {
    errors.push('Servings must be at least 1');
  }

  return {
    valid: errors.length === 0,
    errors,
  };
};

export const validateFileUpload = (file: File): { valid: boolean; error?: string } => {
  const validTypes = ['image/jpeg', 'image/jpg', 'image/png'];
  const maxSize = 5 * 1024 * 1024; // 5MB

  if (!validTypes.includes(file.type)) {
    return { valid: false, error: 'Invalid file type. Only JPG and PNG are allowed.' };
  }

  if (file.size > maxSize) {
    return { valid: false, error: 'File too large. Maximum size is 5MB.' };
  }

  return { valid: true };
};