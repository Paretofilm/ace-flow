import { useState } from 'react';
import { client } from '../../lib/amplify-client';
import { useAuth } from '../../hooks/useAuth';
import { sanitizeInput } from '../../utils/validation';
import { handleError } from '../../utils/errorHandling';

interface CommentFormProps {
  recipeId: string;
}

export default function CommentForm({ recipeId }: CommentFormProps) {
  const { user } = useAuth();
  const [content, setContent] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!content.trim()) {
      setError('Comment cannot be empty');
      return;
    }

    if (content.length > 500) {
      setError('Comment cannot exceed 500 characters');
      return;
    }

    if (!user) {
      setError('You must be logged in to comment');
      return;
    }

    setLoading(true);
    setError(null);

    try {
      const { errors } = await client.models.Comment.create({
        content: sanitizeInput(content),
        recipeId,
        authorName: user.username,
      });

      if (errors) {
        throw new Error('Failed to post comment');
      }

      // Clear form
      setContent('');
    } catch (error) {
      const errorMessage = handleError(error, 'Comment creation');
      setError(errorMessage);
    } finally {
      setLoading(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="comment-form">
      <textarea
        value={content}
        onChange={(e) => setContent(e.target.value)}
        placeholder="Add a comment..."
        disabled={loading}
        rows={3}
        maxLength={500}
      />
      
      <div className="form-footer">
        <span className="char-count">
          {content.length}/500
        </span>
        
        <button 
          type="submit" 
          disabled={loading || !content.trim()}
          className="submit-button"
        >
          {loading ? 'Posting...' : 'Post Comment'}
        </button>
      </div>
      
      {error && <p className="error">{error}</p>}
    </form>
  );
}