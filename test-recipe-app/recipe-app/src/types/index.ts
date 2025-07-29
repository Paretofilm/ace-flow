import type { Schema } from '../../amplify/data/resource';

// Extract model types from the schema
export type Recipe = Schema['Recipe']['type'];
export type Comment = Schema['Comment']['type'];

// Input types for creating/updating models
export type RecipeInput = {
  title: string;
  description: string;
  ingredients: string[];
  instructions: string;
  imageKey?: string;
  cookingTime?: number;
  servings?: number;
  authorName?: string;
};

export type CommentInput = {
  content: string;
  recipeId: string;
  authorName: string;
};

// Authentication types
export type AuthUser = {
  userId: string;
  username: string;
  email: string;
};