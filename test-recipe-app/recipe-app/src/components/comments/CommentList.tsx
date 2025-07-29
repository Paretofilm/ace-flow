import { useState, useEffect } from 'react';
import { client } from '../../lib/amplify-client';
import type { Comment } from '../../types';
import CommentItem from './CommentItem';
import CommentForm from './CommentForm';

interface CommentListProps {
  recipeId: string;
}

export default function CommentList({ recipeId }: CommentListProps) {
  const [comments, setComments] = useState<Comment[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Load existing comments
    const loadComments = async () => {
      try {
        const { data, errors } = await client.models.Comment.list({
          filter: { recipeId: { eq: recipeId } },
        });
        
        if (!errors && data) {
          // Sort by creation date
          const sortedComments = [...data].sort((a, b) => {
            const dateA = new Date(a.createdAt || 0).getTime();
            const dateB = new Date(b.createdAt || 0).getTime();
            return dateA - dateB;
          });
          setComments(sortedComments);
        }
      } catch (error) {
        console.error('Failed to load comments:', error);
      } finally {
        setLoading(false);
      }
    };

    loadComments();

    // Subscribe to new comments
    const createSub = client.models.Comment.onCreate({
      filter: { recipeId: { eq: recipeId } },
    }).subscribe({
      next: (newComment) => {
        setComments(prev => [...prev, newComment]);
      },
      error: (error) => console.error('Comment subscription error:', error),
    });

    // Subscribe to comment deletions
    const deleteSub = client.models.Comment.onDelete({
      filter: { recipeId: { eq: recipeId } },
    }).subscribe({
      next: (deletedComment) => {
        setComments(prev => 
          prev.filter(comment => comment.id !== deletedComment.id)
        );
      },
      error: (error) => console.error('Delete subscription error:', error),
    });

    return () => {
      createSub.unsubscribe();
      deleteSub.unsubscribe();
    };
  }, [recipeId]);

  if (loading) {
    return <div className="loading">Loading comments...</div>;
  }

  return (
    <div className="comments-section">
      <h3>Comments ({comments.length})</h3>
      
      <CommentForm recipeId={recipeId} />
      
      <div className="comments-list">
        {comments.length === 0 ? (
          <p className="no-comments">No comments yet. Be the first to comment!</p>
        ) : (
          comments.map(comment => (
            <CommentItem key={comment.id} comment={comment} />
          ))
        )}
      </div>
    </div>
  );
}