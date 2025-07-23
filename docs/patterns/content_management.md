# Content Management Architecture Pattern

**Comprehensive architecture pattern for building content management systems, blogs, documentation sites, and publishing platforms with AWS Amplify Gen 2 and Next.js.**

## 🎯 Pattern Overview

### What This Pattern Provides
The Content Management pattern enables building scalable content platforms with features like rich text editing, content publishing workflows, version control, media management, and multi-author collaboration. It's designed for applications that focus on content creation, curation, and distribution.

### Core Characteristics
- **Content-First Design**: Everything revolves around creating, editing, and publishing content
- **Editorial Workflows**: Draft, review, approve, and publish content with role-based permissions
- **Rich Media Support**: Image, video, and document management with processing pipelines
- **SEO Optimization**: Built-in SEO features and meta tag management
- **Multi-Author Collaboration**: Team-based content creation with attribution and roles

## 🏗️ Architecture Components

### High-Level Architecture
```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Next.js App   │    │  Amplify Gen 2   │    │  AWS Services   │
│                 │    │                  │    │                 │
│ • Rich Editor   │◄──►│ • GraphQL API    │◄──►│ • Cognito       │
│ • Content Views │    │ • Content API    │    │ • S3 + CloudFront│
│ • Admin Panel   │    │ • Auth Rules     │    │ • DynamoDB      │
│ • Media Library │    │ • Data Models    │    │ • Lambda        │
│ • SEO Tools     │    │ • File Storage   │    │ • Elasticsearch │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

### Key Components

#### 1. Content Management System
```typescript
// Core content interfaces
interface Article {
  id: string;
  title: string;
  slug: string;
  content: string;
  excerpt?: string;
  authorId: string;
  categoryId?: string;
  tags: string[];
  status: 'draft' | 'pending' | 'published' | 'archived';
  visibility: 'public' | 'private' | 'password' | 'members';
  password?: string;
  featuredImage?: string;
  publishedAt?: Date;
  scheduledAt?: Date;
  seo: SEOMetadata;
  readingTime: number;
  wordCount: number;
  views: number;
  likes: number;
  createdAt: Date;
  updatedAt: Date;
}

interface SEOMetadata {
  metaTitle?: string;
  metaDescription?: string;
  canonicalUrl?: string;
  ogTitle?: string;
  ogDescription?: string;
  ogImage?: string;
  twitterCard?: 'summary' | 'summary_large_image';
  keywords?: string[];
  schema?: Record<string, any>;
}

interface ContentRevision {
  id: string;
  articleId: string;
  title: string;
  content: string;
  authorId: string;
  changeNote?: string;
  version: number;
  createdAt: Date;
}
```

#### 2. Editorial Workflow System
```typescript
// Editorial workflow interfaces
interface EditorialWorkflow {
  id: string;
  name: string;
  steps: WorkflowStep[];
  isDefault: boolean;
  createdAt: Date;
  updatedAt: Date;
}

interface WorkflowStep {
  id: string;
  name: string;
  description?: string;
  requiredRole: 'author' | 'editor' | 'admin';
  autoAdvance: boolean;
  emailNotification: boolean;
  position: number;
}

interface WorkflowAssignment {
  id: string;
  articleId: string;
  workflowId: string;
  currentStepId: string;
  assignedToId?: string;
  status: 'pending' | 'approved' | 'rejected' | 'completed';
  notes?: string;
  dueDate?: Date;
  createdAt: Date;
  updatedAt: Date;
}

interface Comment {
  id: string;
  articleId: string;
  authorId: string;
  parentId?: string;
  content: string;
  isInternal: boolean; // Editorial comments vs public comments
  createdAt: Date;
  updatedAt: Date;
}
```

#### 3. Media Management System
```typescript
// Media and asset management
interface MediaAsset {
  id: string;
  filename: string;
  originalName: string;
  mimeType: string;
  size: number;
  width?: number;
  height?: number;
  duration?: number; // for videos
  url: string;
  thumbnailUrl?: string;
  altText?: string;
  caption?: string;
  uploadedById: string;
  folder?: string;
  tags: string[];
  isPublic: boolean;
  createdAt: Date;
  updatedAt: Date;
}

interface MediaFolder {
  id: string;
  name: string;
  parentId?: string;
  description?: string;
  createdById: string;
  createdAt: Date;
}
```

## 📊 Data Modeling Strategy

### Core Content Models

#### Article & Content Schema
```typescript
// amplify/data/resource.ts
import { type ClientSchema, a } from '@aws-amplify/backend';

const schema = a.schema({
  Article: a
    .model({
      title: a.string().required(),
      slug: a.string().required(),
      content: a.string().required(),
      excerpt: a.string(),
      authorId: a.id().required(),
      categoryId: a.id(),
      tags: a.string().array(),
      status: a.enum(['draft', 'pending', 'published', 'archived']).default('draft'),
      visibility: a.enum(['public', 'private', 'password', 'members']).default('public'),
      password: a.string(),
      featuredImage: a.string(),
      publishedAt: a.datetime(),
      scheduledAt: a.datetime(),
      
      // SEO fields
      metaTitle: a.string(),
      metaDescription: a.string(),
      canonicalUrl: a.string(),
      ogTitle: a.string(),
      ogDescription: a.string(),
      ogImage: a.string(),
      keywords: a.string().array(),
      
      // Analytics
      readingTime: a.integer().default(0),
      wordCount: a.integer().default(0),
      views: a.integer().default(0),
      likes: a.integer().default(0),
      
      // Relations
      author: a.belongsTo('Author', 'authorId'),
      category: a.belongsTo('Category', 'categoryId'),
      revisions: a.hasMany('ContentRevision', 'articleId'),
      comments: a.hasMany('Comment', 'articleId'),
      workflowAssignments: a.hasMany('WorkflowAssignment', 'articleId'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update', 'delete']),
      allow.groups(['editor', 'admin']).to(['read', 'update']),
      allow.authenticated().to(['read']).where(article => 
        article.status === 'published' && article.visibility === 'public'
      ),
      allow.guest().to(['read']).where(article => 
        article.status === 'published' && article.visibility === 'public'
      ),
    ])
    .secondaryIndexes(index => [
      index('authorId').sortKeys(['publishedAt']).name('byAuthor'),
      index('categoryId').sortKeys(['publishedAt']).name('byCategory'),
      index('status').sortKeys(['publishedAt']).name('byStatus'),
      index('slug').name('bySlug'),
    ]),

  ContentRevision: a
    .model({
      articleId: a.id().required(),
      title: a.string().required(),
      content: a.string().required(),
      authorId: a.id().required(),
      changeNote: a.string(),
      version: a.integer().required(),
      
      // Relations
      article: a.belongsTo('Article', 'articleId'),
      author: a.belongsTo('Author', 'authorId'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read']),
      allow.groups(['editor', 'admin']).to(['read']),
    ]),

  Category: a
    .model({
      name: a.string().required(),
      slug: a.string().required(),
      description: a.string(),
      color: a.string(),
      icon: a.string(),
      parentId: a.id(),
      position: a.integer().default(0),
      isActive: a.boolean().default(true),
      
      // SEO
      metaTitle: a.string(),
      metaDescription: a.string(),
      
      // Relations
      parent: a.belongsTo('Category', 'parentId'),
      children: a.hasMany('Category', 'parentId'),
      articles: a.hasMany('Article', 'categoryId'),
    })
    .authorization(allow => [
      allow.authenticated().to(['read']),
      allow.groups(['editor', 'admin']).to(['create', 'update', 'delete']),
    ]),

  Tag: a
    .model({
      name: a.string().required(),
      slug: a.string().required(),
      description: a.string(),
      color: a.string(),
      usage_count: a.integer().default(0),
      
      // SEO
      metaTitle: a.string(),
      metaDescription: a.string(),
    })
    .authorization(allow => [
      allow.authenticated().to(['read']),
      allow.groups(['editor', 'admin']).to(['create', 'update', 'delete']),
    ]),
});
```

#### Editorial Workflow Schema
```typescript
// Editorial workflow models
const workflowSchema = a.schema({
  EditorialWorkflow: a
    .model({
      name: a.string().required(),
      description: a.string(),
      isDefault: a.boolean().default(false),
      isActive: a.boolean().default(true),
      
      // Relations
      steps: a.hasMany('WorkflowStep', 'workflowId'),
      assignments: a.hasMany('WorkflowAssignment', 'workflowId'),
    })
    .authorization(allow => [
      allow.groups(['editor', 'admin']).to(['create', 'read', 'update', 'delete']),
    ]),

  WorkflowStep: a
    .model({
      workflowId: a.id().required(),
      name: a.string().required(),
      description: a.string(),
      requiredRole: a.enum(['author', 'editor', 'admin']).required(),
      autoAdvance: a.boolean().default(false),
      emailNotification: a.boolean().default(true),
      position: a.integer().required(),
      
      // Relations
      workflow: a.belongsTo('EditorialWorkflow', 'workflowId'),
    })
    .authorization(allow => [
      allow.groups(['editor', 'admin']).to(['create', 'read', 'update', 'delete']),
    ]),

  WorkflowAssignment: a
    .model({
      articleId: a.id().required(),
      workflowId: a.id().required(),
      currentStepId: a.id().required(),
      assignedToId: a.id(),
      status: a.enum(['pending', 'approved', 'rejected', 'completed']).default('pending'),
      notes: a.string(),
      dueDate: a.datetime(),
      
      // Relations
      article: a.belongsTo('Article', 'articleId'),
      workflow: a.belongsTo('EditorialWorkflow', 'workflowId'),
      assignedTo: a.belongsTo('Author', 'assignedToId'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update']),
      allow.groups(['editor', 'admin']).to(['read', 'update']),
    ]),

  Comment: a
    .model({
      articleId: a.id().required(),
      authorId: a.id().required(),
      parentId: a.id(),
      content: a.string().required(),
      isInternal: a.boolean().default(false),
      isApproved: a.boolean().default(false),
      
      // Relations
      article: a.belongsTo('Article', 'articleId'),
      author: a.belongsTo('Author', 'authorId'),
      parent: a.belongsTo('Comment', 'parentId'),
      replies: a.hasMany('Comment', 'parentId'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update', 'delete']),
      allow.groups(['editor', 'admin']).to(['read', 'update', 'delete']),
      allow.authenticated().to(['read']).where(comment => comment.isApproved),
    ]),
});
```

#### Media Management Schema
```typescript
// Media and asset models
const mediaSchema = a.schema({
  MediaAsset: a
    .model({
      filename: a.string().required(),
      originalName: a.string().required(),
      mimeType: a.string().required(),
      size: a.integer().required(),
      width: a.integer(),
      height: a.integer(),
      duration: a.integer(), // for videos in seconds
      url: a.string().required(),
      thumbnailUrl: a.string(),
      altText: a.string(),
      caption: a.string(),
      uploadedById: a.id().required(),
      folderId: a.id(),
      tags: a.string().array(),
      isPublic: a.boolean().default(true),
      
      // Relations
      uploadedBy: a.belongsTo('Author', 'uploadedById'),
      folder: a.belongsTo('MediaFolder', 'folderId'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update', 'delete']),
      allow.groups(['editor', 'admin']).to(['read', 'update', 'delete']),
      allow.authenticated().to(['read']).where(asset => asset.isPublic),
    ])
    .secondaryIndexes(index => [
      index('uploadedById').sortKeys(['createdAt']).name('byUploader'),
      index('folderId').sortKeys(['createdAt']).name('byFolder'),
      index('mimeType').sortKeys(['createdAt']).name('byType'),
    ]),

  MediaFolder: a
    .model({
      name: a.string().required(),
      parentId: a.id(),
      description: a.string(),
      createdById: a.id().required(),
      
      // Relations
      parent: a.belongsTo('MediaFolder', 'parentId'),
      children: a.hasMany('MediaFolder', 'parentId'),
      assets: a.hasMany('MediaAsset', 'folderId'),
      createdBy: a.belongsTo('Author', 'createdById'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update', 'delete']),
      allow.groups(['editor', 'admin']).to(['read', 'update', 'delete']),
    ]),

  Author: a
    .model({
      email: a.email().required(),
      firstName: a.string().required(),
      lastName: a.string().required(),
      displayName: a.string(),
      bio: a.string(),
      avatar: a.string(),
      website: a.string(),
      socialLinks: a.json(),
      role: a.enum(['author', 'editor', 'admin']).default('author'),
      isActive: a.boolean().default(true),
      
      // Relations
      articles: a.hasMany('Article', 'authorId'),
      mediaAssets: a.hasMany('MediaAsset', 'uploadedById'),
      comments: a.hasMany('Comment', 'authorId'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update']),
      allow.groups(['admin']).to(['read', 'update', 'delete']),
      allow.authenticated().to(['read']),
    ]),
});
```

## 🎨 UI Components Implementation

### Content Editor Components

#### Rich Text Editor Component  
```typescript
// components/RichTextEditor.tsx
'use client';

import { useState, useEffect, useCallback } from 'react';
import { Editor } from '@tinymce/tinymce-react';
import { useMediaLibrary } from '@/hooks/useMediaLibrary';
import { useDraft } from '@/hooks/useDraft';

interface RichTextEditorProps {
  initialContent?: string;
  onChange: (content: string) => void;
  articleId?: string;
  placeholder?: string;
}

export function RichTextEditor({
  initialContent = '',
  onChange,
  articleId,
  placeholder = 'Start writing...'
}: RichTextEditorProps) {
  const [content, setContent] = useState(initialContent);
  const { openMediaLibrary } = useMediaLibrary();
  const { saveDraft, loadDraft } = useDraft();

  // Auto-save draft every 30 seconds
  useEffect(() => {
    if (!articleId) return;

    const interval = setInterval(() => {
      if (content !== initialContent) {
        saveDraft(articleId, content);
      }
    }, 30000);

    return () => clearInterval(interval);
  }, [content, articleId, initialContent, saveDraft]);

  // Load draft on mount
  useEffect(() => {
    if (articleId) {
      loadDraft(articleId).then(draftContent => {
        if (draftContent && draftContent !== initialContent) {
          setContent(draftContent);
          onChange(draftContent);
        }
      });
    }
  }, [articleId, initialContent, loadDraft, onChange]);

  const handleEditorChange = useCallback((newContent: string) => {
    setContent(newContent);
    onChange(newContent);
  }, [onChange]);

  const handleImageUpload = useCallback(async () => {
    const selectedMedia = await openMediaLibrary({
      multiple: false,
      filter: 'images'
    });

    if (selectedMedia && selectedMedia.length > 0) {
      const media = selectedMedia[0];
      return {
        src: media.url,
        alt: media.altText || media.originalName,
        title: media.caption || media.originalName
      };
    }
    return null;
  }, [openMediaLibrary]);

  const editorConfig = {
    height: 500,
    menubar: false,
    plugins: [
      'advlist', 'autolink', 'lists', 'link', 'image', 'charmap', 'preview',
      'anchor', 'searchreplace', 'visualblocks', 'code', 'fullscreen',
      'insertdatetime', 'media', 'table', 'help', 'wordcount'
    ],
    toolbar: [
      'undo redo | blocks | bold italic forecolor | alignleft aligncenter alignright alignjustify',
      'bullist numlist outdent indent | removeformat | image media link | code fullscreen help'
    ].join(' | '),
    content_style: `
      body { 
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; 
        font-size: 16px; 
        line-height: 1.6;
      }
    `,
    placeholder,
    automatic_uploads: true,
    file_picker_callback: async (callback, value, meta) => {
      if (meta.filetype === 'image') {
        const imageData = await handleImageUpload();
        if (imageData) {
          callback(imageData.src, { alt: imageData.alt, title: imageData.title });
        }
      }
    },
    setup: (editor) => {
      editor.on('init', () => {
        editor.setContent(content);
      });
    }
  };

  return (
    <div className="rich-text-editor">
      <Editor
        apiKey={process.env.NEXT_PUBLIC_TINYMCE_API_KEY}
        value={content}
        init={editorConfig}
        onEditorChange={handleEditorChange}
      />
      
      <div className="editor-footer">
        <div className="word-count">
          Word count: {content.replace(/<[^>]*>/g, '').split(/\s+/).filter(word => word.length > 0).length}
        </div>
        
        <div className="auto-save-status">
          {articleId && <AutoSaveIndicator articleId={articleId} />}
        </div>
      </div>
    </div>
  );
}
```

#### Article Form Component
```typescript
// components/ArticleForm.tsx
'use client';

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { generateClient } from 'aws-amplify/data';
import { RichTextEditor } from './RichTextEditor';
import { MediaPicker } from './MediaPicker';
import { CategorySelector } from './CategorySelector';
import { TagInput } from './TagInput';
import { SEOEditor } from './SEOEditor';
import type { Schema } from '@/amplify/data/resource';

const client = generateClient<Schema>();

interface ArticleFormProps {
  articleId?: string;
  mode?: 'create' | 'edit';
}

export function ArticleForm({ articleId, mode = 'create' }: ArticleFormProps) {
  const router = useRouter();
  const [article, setArticle] = useState<Partial<Schema['Article']['type']>>({
    title: '',
    content: '',
    excerpt: '',
    categoryId: undefined,
    tags: [],
    status: 'draft',
    visibility: 'public',
    featuredImage: undefined,
    metaTitle: '',
    metaDescription: '',
    keywords: [],
  });
  const [loading, setLoading] = useState(false);
  const [errors, setErrors] = useState<Record<string, string>>({});

  useEffect(() => {
    if (mode === 'edit' && articleId) {
      fetchArticle();
    }
  }, [mode, articleId]);

  const fetchArticle = async () => {
    try {
      const result = await client.models.Article.get({ id: articleId! });
      if (result.data) {
        setArticle(result.data);
      }
    } catch (error) {
      console.error('Error fetching article:', error);
    }
  };

  const generateSlug = (title: string): string => {
    return title
      .toLowerCase()
      .replace(/[^a-z0-9 -]/g, '')
      .replace(/\s+/g, '-')
      .replace(/-+/g, '-')
      .trim('-');
  };

  const calculateReadingTime = (content: string): number => {
    const wordsPerMinute = 200;
    const wordCount = content.replace(/<[^>]*>/g, '').split(/\s+/).length;
    return Math.ceil(wordCount / wordsPerMinute);
  };

  const validateForm = (): boolean => {
    const newErrors: Record<string, string> = {};

    if (!article.title?.trim()) {
      newErrors.title = 'Title is required';
    }

    if (!article.content?.trim()) {
      newErrors.content = 'Content is required';
    }

    if (article.status === 'published' && !article.excerpt?.trim()) {
      newErrors.excerpt = 'Excerpt is required for published articles';
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (status: 'draft' | 'pending' | 'published') => {
    const updatedArticle = {
      ...article,
      status,
      slug: generateSlug(article.title || ''),
      readingTime: calculateReadingTime(article.content || ''),
      wordCount: (article.content || '').replace(/<[^>]*>/g, '').split(/\s+/).length,
    };

    setArticle(updatedArticle);

    if (!validateForm()) return;

    setLoading(true);
    try {
      if (mode === 'create') {
        const result = await client.models.Article.create({
          ...updatedArticle,
          publishedAt: status === 'published' ? new Date().toISOString() : undefined,
        });
        router.push(`/admin/articles/${result.data?.id}`);
      } else {
        await client.models.Article.update({
          id: articleId!,
          ...updatedArticle,
          publishedAt: status === 'published' && !article.publishedAt 
            ? new Date().toISOString() 
            : article.publishedAt,
        });
        router.push(`/admin/articles/${articleId}`);
      }
    } catch (error) {
      console.error('Error saving article:', error);
      setErrors({ submit: 'Failed to save article. Please try again.' });
    } finally {
      setLoading(false);
    }
  };

  const handleSchedule = async (scheduledDate: Date) => {
    await handleSubmit('pending');
    // Additional scheduling logic would go here
  };

  return (
    <div className="article-form">
      <div className="article-form-header">
        <h1>{mode === 'create' ? 'Create New Article' : 'Edit Article'}</h1>
        
        <div className="form-actions">
          <button
            type="button"
            onClick={() => handleSubmit('draft')}
            disabled={loading}
            className="btn-secondary"
          >
            Save Draft
          </button>
          
          <button
            type="button"
            onClick={() => handleSubmit('pending')}
            disabled={loading}
            className="btn-warning"
          >
            Submit for Review
          </button>
          
          <button
            type="button"
            onClick={() => handleSubmit('published')}
            disabled={loading}
            className="btn-primary"
          >
            {loading ? 'Publishing...' : 'Publish'}
          </button>
        </div>
      </div>

      <div className="article-form-content">
        <div className="main-content">
          <div className="form-group">
            <label htmlFor="title">Title *</label>
            <input
              id="title"
              type="text"
              value={article.title || ''}
              onChange={(e) => setArticle(prev => ({ ...prev, title: e.target.value }))}
              className={errors.title ? 'error' : ''}
              placeholder="Enter article title..."
            />
            {errors.title && <span className="error-message">{errors.title}</span>}
          </div>

          <div className="form-group">
            <label htmlFor="excerpt">Excerpt</label>
            <textarea
              id="excerpt"
              value={article.excerpt || ''}
              onChange={(e) => setArticle(prev => ({ ...prev, excerpt: e.target.value }))}
              className={errors.excerpt ? 'error' : ''}
              placeholder="Brief description of the article..."
              rows={3}
            />
            {errors.excerpt && <span className="error-message">{errors.excerpt}</span>}
          </div>

          <div className="form-group">
            <label>Content *</label>
            <RichTextEditor
              initialContent={article.content || ''}
              onChange={(content) => setArticle(prev => ({ ...prev, content }))}
              articleId={articleId}
            />
            {errors.content && <span className="error-message">{errors.content}</span>}
          </div>
        </div>

        <div className="sidebar-content">
          <div className="form-section">
            <h3>Publishing</h3>
            
            <div className="form-group">
              <label>Status</label>
              <select
                value={article.status || 'draft'}
                onChange={(e) => setArticle(prev => ({ 
                  ...prev, 
                  status: e.target.value as any 
                }))}
              >
                <option value="draft">Draft</option>
                <option value="pending">Pending Review</option>
                <option value="published">Published</option>
                <option value="archived">Archived</option>
              </select>
            </div>

            <div className="form-group">
              <label>Visibility</label>
              <select
                value={article.visibility || 'public'}
                onChange={(e) => setArticle(prev => ({ 
                  ...prev, 
                  visibility: e.target.value as any 
                }))}
              >
                <option value="public">Public</option>
                <option value="private">Private</option>
                <option value="password">Password Protected</option>
                <option value="members">Members Only</option>
              </select>
            </div>

            {article.visibility === 'password' && (
              <div className="form-group">
                <label>Password</label>
                <input
                  type="password"
                  value={article.password || ''}
                  onChange={(e) => setArticle(prev => ({ ...prev, password: e.target.value }))}
                  placeholder="Enter password..."
                />
              </div>
            )}
          </div>

          <div className="form-section">
            <h3>Featured Image</h3>
            <MediaPicker
              value={article.featuredImage}
              onChange={(url) => setArticle(prev => ({ ...prev, featuredImage: url }))}
              filter="images"
            />
          </div>

          <div className="form-section">
            <h3>Categories & Tags</h3>
            
            <CategorySelector
              value={article.categoryId}
              onChange={(categoryId) => setArticle(prev => ({ ...prev, categoryId }))}
            />
            
            <TagInput
              value={article.tags || []}
              onChange={(tags) => setArticle(prev => ({ ...prev, tags }))}
            />
          </div>

          <div className="form-section">
            <h3>SEO</h3>
            <SEOEditor
              title={article.metaTitle}
              description={article.metaDescription}
              keywords={article.keywords}
              onChange={(seo) => setArticle(prev => ({ 
                ...prev, 
                metaTitle: seo.title,
                metaDescription: seo.description,
                keywords: seo.keywords
              }))}
            />
          </div>
        </div>
      </div>

      {errors.submit && (
        <div className="error-message submit-error">{errors.submit}</div>
      )}
    </div>
  );
}
```

#### Content List Component
```typescript
// components/ContentList.tsx
'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';
import Image from 'next/image';
import { generateClient } from 'aws-amplify/data';
import { formatDistanceToNow } from 'date-fns';
import type { Schema } from '@/amplify/data/resource';

const client = generateClient<Schema>();

interface ContentListProps {
  authorId?: string;
  categoryId?: string;
  status?: 'draft' | 'pending' | 'published' | 'archived';
  limit?: number;
  showActions?: boolean;
}

export function ContentList({
  authorId,
  categoryId,
  status,
  limit = 20,
  showActions = false
}: ContentListProps) {
  const [articles, setArticles] = useState<Schema['Article']['type'][]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedItems, setSelectedItems] = useState<Set<string>>(new Set());

  useEffect(() => {
    fetchArticles();
  }, [authorId, categoryId, status]);

  const fetchArticles = async () => {
    try {
      setLoading(true);
      
      const filters: any = { and: [] };

      if (authorId) {
        filters.and.push({ authorId: { eq: authorId } });
      }

      if (categoryId) {
        filters.and.push({ categoryId: { eq: categoryId } });
      }

      if (status) {
        filters.and.push({ status: { eq: status } });
      }

      const result = await client.models.Article.list({
        filter: filters.and.length > 0 ? filters : undefined,
        sort: { field: 'updatedAt', direction: 'desc' },
        limit,
        include: { author: true, category: true }
      });

      setArticles(result.data);
    } catch (error) {
      console.error('Error fetching articles:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleBulkAction = async (action: 'publish' | 'archive' | 'delete') => {
    if (selectedItems.size === 0) return;

    try {
      const promises = Array.from(selectedItems).map(async (id) => {
        switch (action) {
          case 'publish':
            return client.models.Article.update({
              id,
              status: 'published',
              publishedAt: new Date().toISOString(),
            });
          case 'archive':
            return client.models.Article.update({ id, status: 'archived' });
          case 'delete':
            return client.models.Article.delete({ id });
        }
      });

      await Promise.all(promises);
      setSelectedItems(new Set());
      await fetchArticles();
    } catch (error) {
      console.error('Error performing bulk action:', error);
    }
  };

  const getStatusBadge = (status: string) => {
    const statusClasses = {
      draft: 'status-draft',
      pending: 'status-pending',
      published: 'status-published',
      archived: 'status-archived',
    };

    return (
      <span className={`status-badge ${statusClasses[status] || ''}`}>
        {status.charAt(0).toUpperCase() + status.slice(1)}
      </span>
    );
  };

  const formatDate = (dateString: string) => {
    return formatDistanceToNow(new Date(dateString), { addSuffix: true });
  };

  if (loading) return <ContentListSkeleton />;

  return (
    <div className="content-list">
      {showActions && selectedItems.size > 0 && (
        <div className="bulk-actions">
          <span>{selectedItems.size} items selected</span>
          <div className="action-buttons">
            <button onClick={() => handleBulkAction('publish')}>
              Publish
            </button>
            <button onClick={() => handleBulkAction('archive')}>
              Archive
            </button>
            <button onClick={() => handleBulkAction('delete')}>
              Delete
            </button>
          </div>
        </div>
      )}

      <div className="articles-grid">
        {articles.map((article) => (
          <div key={article.id} className="article-card">
            {showActions && (
              <div className="article-checkbox">
                <input
                  type="checkbox"
                  checked={selectedItems.has(article.id)}
                  onChange={(e) => {
                    const newSelected = new Set(selectedItems);
                    if (e.target.checked) {
                      newSelected.add(article.id);
                    } else {
                      newSelected.delete(article.id);
                    }
                    setSelectedItems(newSelected);
                  }}
                />
              </div>
            )}

            {article.featuredImage && (
              <div className="article-image">
                <Image
                  src={article.featuredImage}
                  alt={article.title}
                  width={300}
                  height={200}
                  className="featured-image"
                />
              </div>
            )}

            <div className="article-content">
              <div className="article-header">
                <div className="article-meta">
                  {getStatusBadge(article.status)}
                  {article.category && (
                    <span className="category">{article.category.name}</span>
                  )}
                </div>
                
                <h3 className="article-title">
                  <Link href={`/admin/articles/${article.id}`}>
                    {article.title}
                  </Link>
                </h3>

                {article.excerpt && (
                  <p className="article-excerpt">{article.excerpt}</p>
                )}
              </div>

              <div className="article-footer">
                <div className="author-info">
                  <span className="author-name">
                    {article.author?.displayName || 
                     `${article.author?.firstName} ${article.author?.lastName}`}
                  </span>
                  <span className="date">
                    {article.status === 'published' && article.publishedAt
                      ? formatDate(article.publishedAt)
                      : formatDate(article.updatedAt)
                    }
                  </span>
                </div>

                <div className="article-stats">
                  <span className="views">{article.views} views</span>
                  <span className="likes">{article.likes} likes</span>
                  <span className="reading-time">{article.readingTime} min read</span>
                </div>

                {showActions && (
                  <div className="article-actions">
                    <Link href={`/admin/articles/${article.id}/edit`}>
                      Edit
                    </Link>
                    {article.status === 'published' && (
                      <Link href={`/articles/${article.slug}`} target="_blank">
                        View
                      </Link>
                    )}
                  </div>
                )}
              </div>
            </div>
          </div>
        ))}
      </div>

      {articles.length === 0 && !loading && (
        <div className="empty-state">
          <h3>No articles found</h3>
          <p>Start by creating your first article!</p>
          <Link href="/admin/articles/new" className="btn-primary">
            Create Article
          </Link>
        </div>
      )}
    </div>
  );
}
```

### Media Management Components

#### Media Library Component
```typescript
// components/MediaLibrary.tsx
'use client';

import { useState, useEffect } from 'react';
import { uploadData } from 'aws-amplify/storage';
import { generateClient } from 'aws-amplify/data';
import { MediaGrid } from './MediaGrid';
import { MediaUploader } from './MediaUploader';
import type { Schema } from '@/amplify/data/resource';

const client = generateClient<Schema>();

interface MediaLibraryProps {
  onSelect?: (media: Schema['MediaAsset']['type'][]) => void;
  multiSelect?: boolean;
  filter?: 'all' | 'images' | 'videos' | 'documents';
}

export function MediaLibrary({
  onSelect,
  multiSelect = true,
  filter = 'all'
}: MediaLibraryProps) {
  const [mediaAssets, setMediaAssets] = useState<Schema['MediaAsset']['type'][]>([]);
  const [selectedMedia, setSelectedMedia] = useState<Set<string>>(new Set());
  const [loading, setLoading] = useState(true);
  const [uploadProgress, setUploadProgress] = useState<Record<string, number>>({});

  useEffect(() => {
    fetchMediaAssets();
  }, [filter]);

  const fetchMediaAssets = async () => {
    try {
      setLoading(true);
      
      const filters: any = filter !== 'all' ? {
        mimeType: { beginsWith: filter === 'images' ? 'image/' : filter === 'videos' ? 'video/' : 'application/' }
      } : undefined;

      const result = await client.models.MediaAsset.list({
        filter: filters,
        sort: { field: 'createdAt', direction: 'desc' },
        limit: 100,
      });

      setMediaAssets(result.data);
    } catch (error) {
      console.error('Error fetching media assets:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleFileUpload = async (files: FileList) => {
    const uploadPromises = Array.from(files).map(async (file) => {
      const key = `media/${Date.now()}-${file.name}`;
      
      try {
        // Upload to S3
        const result = await uploadData({
          key,
          data: file,
          options: {
            onProgress: ({ transferredBytes, totalBytes }) => {
              const progress = Math.round((transferredBytes / totalBytes) * 100);
              setUploadProgress(prev => ({ ...prev, [file.name]: progress }));
            }
          }
        }).result;

        // Create media asset record
        const mediaAsset = await client.models.MediaAsset.create({
          filename: key,
          originalName: file.name,
          mimeType: file.type,
          size: file.size,
          url: result.key,
          isPublic: true,
        });

        // Remove from progress tracking
        setUploadProgress(prev => {
          const newProgress = { ...prev };
          delete newProgress[file.name];
          return newProgress;
        });

        return mediaAsset.data;
      } catch (error) {
        console.error('Upload failed for', file.name, error);
        setUploadProgress(prev => {
          const newProgress = { ...prev };
          delete newProgress[file.name];
          return newProgress;
        });
        return null;
      }
    });

    const uploadedAssets = await Promise.all(uploadPromises);
    const successfulUploads = uploadedAssets.filter(asset => asset !== null);
    
    if (successfulUploads.length > 0) {
      setMediaAssets(prev => [...successfulUploads, ...prev]);
    }
  };

  const handleMediaSelect = (mediaId: string) => {
    if (multiSelect) {
      setSelectedMedia(prev => {
        const newSelected = new Set(prev);
        if (newSelected.has(mediaId)) {
          newSelected.delete(mediaId);
        } else {
          newSelected.add(mediaId);
        }
        return newSelected;
      });
    } else {
      setSelectedMedia(new Set([mediaId]));
    }
  };

  const handleConfirmSelection = () => {
    if (onSelect) {
      const selected = mediaAssets.filter(asset => selectedMedia.has(asset.id));
      onSelect(selected);
    }
  };

  return (
    <div className="media-library">
      <div className="media-library-header">
        <h2>Media Library</h2>
        
        <div className="media-actions">
          {selectedMedia.size > 0 && (
            <button onClick={handleConfirmSelection} className="btn-primary">
              Select {selectedMedia.size} item{selectedMedia.size > 1 ? 's' : ''}
            </button>
          )}
        </div>
      </div>

      <MediaUploader
        onUpload={handleFileUpload}
        uploadProgress={uploadProgress}
        acceptedTypes={filter}
      />

      <MediaGrid
        mediaAssets={mediaAssets}
        selectedMedia={selectedMedia}
        onMediaSelect={handleMediaSelect}
        loading={loading}
      />
    </div>
  );
}
```

## 🔐 Security & Access Control

### Content Security
```typescript
// Content security and moderation
export class ContentSecurityService {
  async moderateContent(content: string): Promise<ModerationResult> {
    // Integration with AWS Comprehend or similar service
    const moderationResult = await this.checkContentToxicity(content);
    
    if (moderationResult.toxicity > 0.8) {
      return {
        approved: false,
        reason: 'Content contains potentially harmful language',
        suggestions: ['Review and edit content', 'Remove inappropriate language']
      };
    }

    const piiDetection = await this.detectPII(content);
    if (piiDetection.found) {
      return {
        approved: false,
        reason: 'Content contains personally identifiable information',
        suggestions: ['Remove or redact personal information']
      };
    }

    return { approved: true };
  }

  async validateMediaContent(file: File): Promise<ValidationResult> {
    // Check file type and size
    const allowedTypes = ['image/jpeg', 'image/png', 'image/gif', 'video/mp4'];
    if (!allowedTypes.includes(file.type)) {
      return { valid: false, error: 'Unsupported file type' };
    }

    if (file.size > 50 * 1024 * 1024) { // 50MB limit
      return { valid: false, error: 'File size exceeds limit' };
    }

    // Scan for malware
    const scanResult = await this.scanFileForMalware(file);
    if (!scanResult.clean) {
      return { valid: false, error: 'File failed security scan' };
    }

    return { valid: true };
  }
}
```

## ⚡ Performance Optimization

### Content Caching & CDN
```typescript
// Content caching and performance optimization
export class ContentCacheService {
  async cacheArticle(articleId: string): Promise<void> {
    const article = await client.models.Article.get({ id: articleId });
    if (!article.data) return;

    // Cache rendered HTML
    const renderedContent = await this.renderArticleHTML(article.data);
    await this.setCacheItem(`article:${articleId}`, renderedContent, 3600); // 1 hour

    // Cache metadata for listing pages
    const metadata = {
      id: article.data.id,
      title: article.data.title,
      excerpt: article.data.excerpt,
      featuredImage: article.data.featuredImage,
      publishedAt: article.data.publishedAt,
      author: article.data.author,
      category: article.data.category,
    };
    await this.setCacheItem(`article:meta:${articleId}`, metadata, 1800); // 30 minutes
  }

  async generateStaticSitemap(): Promise<void> {
    const publishedArticles = await client.models.Article.list({
      filter: { 
        and: [
          { status: { eq: 'published' } },
          { visibility: { eq: 'public' } }
        ]
      }
    });

    const sitemap = this.generateSitemapXML(publishedArticles.data);
    await this.uploadToS3('sitemap.xml', sitemap);
  }
}
```

---

*This Content Management architecture pattern provides a comprehensive foundation for building scalable content platforms with AWS Amplify Gen 2 and Next.js, featuring rich content editing, editorial workflows, media management, and SEO optimization.*

**Pattern Version**: 1.0  
**Complexity**: Medium-High  
**Estimated Implementation**: 5-8 weeks  
**Recommended Team Size**: 3-5 developers