import { useState } from 'react';
import { client } from '../../lib/amplify-client';
import { useAuth } from '../../hooks/useAuth';
import type { Comment } from '../../types';
import { handleError } from '../../utils/errorHandling';

interface CommentItemProps {
  comment: Comment;
}

export default function CommentItem({ comment }: CommentItemProps) {
  const { user } = useAuth();
  const [deleting, setDeleting] = useState(false);
  const isOwner = user?.userId === comment.owner;

  const handleDelete = async () => {
    if (!window.confirm('Are you sure you want to delete this comment?')) {
      return;
    }

    setDeleting(true);
    
    try {
      const { errors } = await client.models.Comment.delete({ 
        id: comment.id 
      });

      if (errors) {
        throw new Error('Failed to delete comment');
      }
    } catch (error) {
      const errorMessage = handleError(error, 'Comment deletion');
      alert(errorMessage);
    } finally {
      setDeleting(false);
    }
  };

  const formatDate = (dateString?: string | null) => {
    if (!dateString) return 'Unknown date';
    
    const date = new Date(dateString);
    return date.toLocaleString('en-US', {
      month: 'short',
      day: 'numeric',
      year: 'numeric',
      hour: 'numeric',
      minute: 'numeric',
      hour12: true,
    });
  };

  return (
    <div className="comment-item">
      <div className="comment-header">
        <strong className="comment-author">{comment.authorName}</strong>
        <time className="comment-time">{formatDate(comment.createdAt)}</time>
      </div>
      
      <p className="comment-content">{comment.content}</p>
      
      {isOwner && (
        <button
          onClick={handleDelete}
          disabled={deleting}
          className="delete-button"
        >
          {deleting ? 'Deleting...' : 'Delete'}
        </button>
      )}
    </div>
  );
}