import { useState, useRef } from 'react';
import { uploadData } from 'aws-amplify/storage';
import { useAuth } from '../../hooks/useAuth';
import { validateFileUpload } from '../../utils/validation';

interface RecipePhotoUploadProps {
  onUploadSuccess: (path: string) => void;
  disabled?: boolean;
}

export default function RecipePhotoUpload({ onUploadSuccess, disabled }: RecipePhotoUploadProps) {
  const { user } = useAuth();
  const fileInputRef = useRef<HTMLInputElement>(null);
  const [uploading, setUploading] = useState(false);
  const [progress, setProgress] = useState(0);
  const [error, setError] = useState<string | null>(null);
  const [preview, setPreview] = useState<string | null>(null);

  const handleFileSelect = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    // Reset states
    setError(null);
    setProgress(0);

    // Validate file
    const validation = validateFileUpload(file);
    if (!validation.valid) {
      setError(validation.error!);
      return;
    }

    // Show preview
    const reader = new FileReader();
    reader.onload = (e) => {
      setPreview(e.target?.result as string);
    };
    reader.readAsDataURL(file);

    // Upload file
    uploadFile(file);
  };

  const uploadFile = async (file: File) => {
    if (!user) {
      setError('You must be logged in to upload photos');
      return;
    }

    setUploading(true);
    
    try {
      const timestamp = Date.now();
      const sanitizedFileName = file.name.replace(/[^a-zA-Z0-9.-]/g, '_');
      const path = `recipe-photos/${user.userId}/${timestamp}-${sanitizedFileName}`;

      const result = await uploadData({
        path,
        data: file,
        options: {
          contentType: file.type,
          onProgress: ({ loaded, total }) => {
            const percentage = Math.round((loaded / total) * 100);
            setProgress(percentage);
          },
        },
      }).result;

      onUploadSuccess(result.path);
    } catch (error) {
      console.error('Upload failed:', error);
      setError('Failed to upload photo. Please try again.');
    } finally {
      setUploading(false);
    }
  };

  const removePhoto = () => {
    setPreview(null);
    setProgress(0);
    setError(null);
    if (fileInputRef.current) {
      fileInputRef.current.value = '';
    }
  };

  return (
    <div className="photo-upload">
      {!preview && (
        <div className="upload-area" onClick={() => fileInputRef.current?.click()}>
          <input
            ref={fileInputRef}
            type="file"
            accept="image/jpeg,image/jpg,image/png"
            onChange={handleFileSelect}
            disabled={disabled || uploading}
            className="file-input"
          />
          <p className="upload-hint">
            Click to select a photo (JPG or PNG, max 5MB)
          </p>
        </div>
      )}

      {preview && (
        <div className="preview-container">
          <img src={preview} alt="Recipe preview" className="preview-image" />
          {!uploading && (
            <button
              type="button"
              onClick={removePhoto}
              className="remove-photo"
              disabled={disabled}
            >
              Remove
            </button>
          )}
        </div>
      )}

      {uploading && (
        <div className="upload-progress">
          <div className="progress-bar">
            <div 
              className="progress-fill" 
              style={{ width: `${progress}%` }}
            />
          </div>
          <span className="progress-text">{progress}%</span>
        </div>
      )}

      {error && <p className="error">{error}</p>}
    </div>
  );
}