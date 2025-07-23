# Content Management Pattern

The Content Management pattern provides a complete foundation for building blogs, documentation sites, publishing platforms, and content-driven applications.

## When to Use

- Corporate blogs and news sites
- Documentation platforms
- Publishing and editorial platforms
- Knowledge bases and wikis
- Portfolio and showcase sites

## Core Features

### Content Creation
- **Rich Text Editor**: WYSIWYG editing with markdown support
- **Media Management**: Image/video upload and optimization
- **SEO Optimization**: Meta tags, structured data, sitemaps
- **Content Scheduling**: Publish dates and content calendar

### Editorial Workflow
- **Multi-author Support**: Author profiles and permissions
- **Content States**: Draft, review, published, archived
- **Editorial Review**: Comment and approval system
- **Version Control**: Content history and rollbacks

### Content Organization
- **Categories & Tags**: Flexible content taxonomy
- **Content Series**: Related content grouping
- **Featured Content**: Highlight important posts
- **Content Search**: Full-text search capabilities

### User Engagement
- **Comments System**: Moderated user comments
- **Social Sharing**: Share to social platforms
- **Newsletter**: Email subscription management
- **Analytics**: Content performance metrics

## Data Schema

```typescript
export const schema = a.schema({
  Author: a.model({
    name: a.string().required(),
    email: a.email().required(),
    bio: a.string(),
    avatar: a.string(), // S3 key
    socialLinks: a.json(), // Twitter, LinkedIn, etc.
    articles: a.hasMany('Article', 'authorId'),
    role: a.enum(['admin', 'editor', 'author']).default('author')
  }),

  Category: a.model({
    name: a.string().required(),
    slug: a.string().required(),
    description: a.string(),
    color: a.string(), // Hex color for UI theme
    articles: a.hasMany('Article', 'categoryId'),
    parent: a.belongsTo('Category', 'parentId'),
    children: a.hasMany('Category', 'parentId')
  }),

  Article: a.model({
    title: a.string().required(),
    slug: a.string().required(),
    excerpt: a.string(),
    content: a.string().required(), // Rich content JSON
    featuredImage: a.string(), // S3 key
    author: a.belongsTo('Author', 'authorId'),
    category: a.belongsTo('Category', 'categoryId'),
    tags: a.hasMany('ArticleTag', 'articleId'),
    comments: a.hasMany('Comment', 'articleId'),
    status: a.enum(['draft', 'review', 'published', 'archived']).default('draft'),
    publishedAt: a.datetime(),
    scheduledFor: a.datetime(),
    seoTitle: a.string(),
    seoDescription: a.string(),
    readingTime: a.integer(), // Estimated minutes
    viewCount: a.integer().default(0)
  }),

  Tag: a.model({
    name: a.string().required(),
    slug: a.string().required(),
    description: a.string(),
    articles: a.hasMany('ArticleTag', 'tagId')
  }),

  ArticleTag: a.model({
    article: a.belongsTo('Article', 'articleId'),
    tag: a.belongsTo('Tag', 'tagId')
  }),

  Comment: a.model({
    content: a.string().required(),
    author: a.string().required(), // Can be anonymous
    email: a.email(),
    website: a.string(),
    article: a.belongsTo('Article', 'articleId'),
    parent: a.belongsTo('Comment', 'parentId'),
    replies: a.hasMany('Comment', 'parentId'),
    status: a.enum(['pending', 'approved', 'spam']).default('pending'),
    ipAddress: a.string(),
    userAgent: a.string()
  }),

  Media: a.model({
    filename: a.string().required(),
    originalName: a.string().required(),
    mimeType: a.string().required(),
    size: a.integer().required(),
    s3Key: a.string().required(),
    alt: a.string(),
    caption: a.string(),
    uploadedBy: a.belongsTo('Author', 'authorId')
  })
});
```

## Rich Content Editor

{% raw %}
```typescript
// Rich text editor with image upload
import { Editor } from '@tinymce/tinymce-react';
import { uploadToS3 } from '../storage/s3-upload';

const ContentEditor = ({ content, onChange }) => {
  const handleImageUpload = async (file) => {
    try {
      const s3Key = await uploadToS3(file, 'content-images/');
      const imageUrl = `https://your-bucket.s3.amazonaws.com/${s3Key}`;
      return imageUrl;
    } catch (error) {
      console.error('Image upload failed:', error);
    }
  };

  return (
    <Editor
      value={content}
      onEditorChange={onChange}
      init={{
        height: 500,
        menubar: false,
        plugins: [
          'advlist', 'autolink', 'lists', 'link', 'image', 'charmap',
          'anchor', 'searchreplace', 'visualblocks', 'code', 'fullscreen',
          'insertdatetime', 'media', 'table', 'preview', 'help', 'wordcount'
        ],
        toolbar: 'undo redo | blocks | bold italic forecolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | removeformat | help',
        images_upload_handler: handleImageUpload
      }}
    />
  );
};
```
{% endraw %}

## SEO Integration

{% raw %}
```typescript
// Auto-generate SEO metadata
const generateSEOMetadata = (article) => {
  return {
    title: article.seoTitle || article.title,
    description: article.seoDescription || article.excerpt,
    canonical: `https://yoursite.com/articles/${article.slug}`,
    openGraph: {
      title: article.title,
      description: article.excerpt,
      image: article.featuredImage,
      type: 'article',
      publishedTime: article.publishedAt,
      author: article.author.name
    },
    structuredData: {
      '@type': 'Article',
      headline: article.title,
      author: {
        '@type': 'Person',
        name: article.author.name
      },
      datePublished: article.publishedAt,
      image: article.featuredImage
    }
  };
};
```
{% endraw %}

## Editorial Workflow

```typescript
// Content approval workflow
const submitForReview = async (articleId) => {
  await client.models.Article.update({
    id: articleId,
    status: 'review'
  });
  
  // Notify editors
  await sendNotification({
    type: 'article_review',
    articleId,
    recipients: await getEditors()
  });
};

const approveArticle = async (articleId, publishDate) => {
  await client.models.Article.update({
    id: articleId,
    status: 'published',
    publishedAt: publishDate || new Date()
  });
  
  // Update sitemap and clear cache
  await updateSitemap();
  await clearContentCache(articleId);
};
```

## Frontend Components

### Content Components
- `<ArticleEditor />` - Rich content creation interface
- `<ArticleList />` - Paginated article listing
- `<ArticleCard />` - Article preview with metadata
- `<ArticleReader />` - Optimized reading experience
- `<TableOfContents />` - Auto-generated article navigation

### Editorial Components
- `<EditorialDashboard />` - Content management interface
- `<WorkflowStatus />` - Article status and progress
- `<CommentModeration />` - Comment approval system
- `<ContentCalendar />` - Publishing schedule view
- `<SEOPreview />` - Search result preview

### Reader Components
- `<CommentSection />` - Threaded comment display
- `<SocialShare />` - Social media sharing
- `<RelatedArticles />` - Content recommendations
- `<NewsletterSignup />` - Email subscription form
- `<SearchResults />` - Content search interface

## Example Implementation

```bash
# Create company blog platform
/ace-genesis "company blog with multiple authors and content approval workflow"

# ACE-Flow will:
# 1. Interview about editorial workflow and author roles
# 2. Research content management best practices
# 3. Generate schema with editorial workflow states
# 4. Create rich text editor with media upload
# 5. Set up comment moderation system
# 6. Configure SEO optimization features
# 7. Deploy complete CMS to AWS
```

## Advanced Features

### Content Versioning
```typescript
const saveContentVersion = async (articleId, content) => {
  // Save version history
  await client.models.ArticleVersion.create({
    articleId,
    content,
    version: await getNextVersionNumber(articleId),
    createdBy: getCurrentUser().id
  });
};

const rollbackToVersion = async (articleId, versionNumber) => {
  const version = await client.models.ArticleVersion.get({
    articleId,
    version: versionNumber
  });
  
  await client.models.Article.update({
    id: articleId,
    content: version.content
  });
};
```

### Full-Text Search
```typescript
// OpenSearch integration for content search
const searchContent = async (query, filters = {}) => {
  const searchParams = {
    index: 'articles',
    body: {
      query: {
        bool: {
          must: [
            {
              multi_match: {
                query,
                fields: ['title^3', 'content', 'excerpt^2']
              }
            }
          ],
          filter: [
            { term: { status: 'published' } },
            ...Object.entries(filters).map(([key, value]) => ({ term: { [key]: value } }))
          ]
        }
      },
      highlight: {
        fields: {
          title: {},
          content: { fragment_size: 150 }
        }
      }
    }
  };
  
  return await opensearch.search(searchParams);
};
```

## Performance Optimizations

### Content Caching
{% raw %}
```typescript
// Multi-layer caching strategy
const getCachedArticle = async (slug) => {
  // 1. Check memory cache
  let article = memoryCache.get(`article:${slug}`);
  if (article) return article;
  
  // 2. Check Redis cache
  article = await redisCache.get(`article:${slug}`);
  if (article) {
    memoryCache.set(`article:${slug}`, article, 300); // 5 min
    return JSON.parse(article);
  }
  
  // 3. Fetch from database
  article = await client.models.Article.get({ slug });
  
  // Cache at both levels
  await redisCache.set(`article:${slug}`, JSON.stringify(article), 3600); // 1 hour
  memoryCache.set(`article:${slug}`, article, 300);
  
  return article;
};
```
{% endraw %}

### Static Site Generation
```typescript
// Pre-build static pages for better performance
const generateStaticPages = async () => {
  const articles = await client.models.Article.list({
    filter: { status: { eq: 'published' } }
  });
  
  for (const article of articles.data) {
    await generateStaticPage(article);
  }
  
  // Generate sitemap
  await generateSitemap(articles.data);
};
```

## Cost Estimates

For a content site with 10,000 monthly readers:

- **DynamoDB**: ~$10-20/month
- **S3 Storage**: ~$5-15/month (images and assets)
- **Lambda Functions**: ~$5-15/month
- **CloudFront CDN**: ~$5-10/month
- **OpenSearch**: ~$15-30/month (if using search)

**Total estimated cost**: $40-90/month

## Security Features

- **Content Sanitization**: XSS prevention in rich text
- **Comment Moderation**: Spam detection and filtering
- **Access Control**: Role-based content permissions
- **Audit Logging**: Track all content changes
- **Backup Strategy**: Regular content backups

## Multi-language Support

```typescript
// Extend schema for internationalization
ArticleTranslation: a.model({
  article: a.belongsTo('Article', 'articleId'),
  language: a.string().required(), // 'en', 'es', 'fr', etc.
  title: a.string().required(),
  content: a.string().required(),
  excerpt: a.string(),
  seoTitle: a.string(),
  seoDescription: a.string()
});
```

## Getting Started

1. Run `/ace-genesis` with your content platform idea
2. Specify author roles and editorial workflow needs
3. Choose content types and organization structure
4. Review generated CMS architecture
5. Deploy and start publishing!

---

[← E-commerce Pattern](e-commerce.md) | [Dashboard Analytics →](dashboard-analytics.md)