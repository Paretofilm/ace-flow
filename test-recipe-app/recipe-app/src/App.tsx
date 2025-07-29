import { useState } from 'react';
import AuthWrapper from './components/auth/AuthWrapper';
import RecipeList from './components/recipes/RecipeList';
import RecipeDetail from './components/recipes/RecipeDetail';
import RecipeForm from './components/recipes/RecipeForm';
import ConnectionStatus from './components/common/ConnectionStatus';
import './App.css';

type ViewState = 
  | { type: 'list' }
  | { type: 'detail'; recipeId: string }
  | { type: 'create' }
  | { type: 'edit'; recipeId: string };

function App() {
  const [viewState, setViewState] = useState<ViewState>({ type: 'list' });

  const renderContent = () => {
    switch (viewState.type) {
      case 'list':
        return (
          <>
            <div className="app-actions">
              <button 
                onClick={() => setViewState({ type: 'create' })}
                className="create-button"
              >
                Create New Recipe
              </button>
            </div>
            <RecipeList onRecipeClick={(recipeId) => setViewState({ type: 'detail', recipeId })} />
          </>
        );
      
      case 'detail':
        return (
          <RecipeDetail
            recipeId={viewState.recipeId}
            onEdit={() => setViewState({ type: 'edit', recipeId: viewState.recipeId })}
            onDelete={() => setViewState({ type: 'list' })}
            onBack={() => setViewState({ type: 'list' })}
          />
        );
      
      case 'create':
        return (
          <RecipeForm
            onSuccess={() => setViewState({ type: 'list' })}
            onCancel={() => setViewState({ type: 'list' })}
          />
        );
      
      case 'edit':
        // For now, just show the detail view
        // TODO: Implement edit functionality
        return (
          <RecipeDetail
            recipeId={viewState.recipeId}
            onEdit={() => {}} // No-op for now
            onDelete={() => setViewState({ type: 'list' })}
            onBack={() => setViewState({ type: 'list' })}
          />
        );
    }
  };

  return (
    <AuthWrapper>
      <ConnectionStatus />
      <div className="app-container">
        {renderContent()}
      </div>
    </AuthWrapper>
  );
}

export default App;
