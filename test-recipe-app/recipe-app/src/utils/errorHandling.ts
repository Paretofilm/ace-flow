export const handleError = (error: any, context: string): string => {
  console.error(`Error in ${context}:`, error);
  
  // User-friendly message mapping
  const userMessage = error.message.includes('Network')
    ? 'Connection error. Please check your internet and try again.'
    : error.message.includes('Unauthorized')
    ? 'You do not have permission to perform this action.'
    : error.message.includes('ValidationException')
    ? 'Please check your input and try again.'
    : 'An unexpected error occurred. Please try again.';
    
  return userMessage;
};