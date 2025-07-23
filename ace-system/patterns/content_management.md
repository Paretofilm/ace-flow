# 📝 Content Management Pattern

**Publishing platform with rich content editing, workflows, and SEO optimization**

## Pattern Overview

This content management pattern implements a comprehensive publishing solution with:
- Rich content creation and editing
- Editorial workflow management
- Multi-author collaboration
- SEO optimization
- Content versioning
- Media management

## Architecture

```typescript
// amplify/data/resource.ts
import { type ClientSchema, a, defineData } from '@aws-amplify/gen2/data';

const schema = a.schema({
  // Core entities
  Author: a
    .model({
      name: a.string().required(),
      email: a.email().required(),
      bio: a.string(),
      avatarUrl: a.string(),
      role: a.enum(['writer', 'editor', 'admin']),
      articles: a.hasMany('Article', 'authorId'),
    })
    .authorization(allow => [allow.authenticated()]),

  Category: a
    .model({
      name: a.string().required(),
      slug: a.string().required(),
      description: a.string(),
      parentId: a.id(),
      parent: a.belongsTo('Category', 'parentId'),
      children: a.hasMany('Category', 'parentId'),
      articles: a.hasMany('Article', 'categoryId'),
    })
    .authorization(allow => [allow.authenticated()]),

  Article: a
    .model({
      title: a.string().required(),
      slug: a.string().required(),
      content: a.string().required(),
      excerpt: a.string(),
      status: a.enum(['draft', 'review', 'published', 'archived']),
      publishedAt: a.datetime(),
      featuredImage: a.string(),
      seoTitle: a.string(),
      seoDescription: a.string(),
      tags: a.string().array(),
      authorId: a.id().required(),
      categoryId: a.id(),
      author: a.belongsTo('Author', 'authorId'),
      category: a.belongsTo('Category', 'categoryId'),
      comments: a.hasMany('Comment', 'articleId'),
    })
    .authorization(allow => [
      allow.authenticated().to(['create', 'read']),
      allow.owner().to(['update', 'delete'])
    ]),

  Comment: a
    .model({
      content: a.string().required(),
      authorName: a.string().required(),
      authorEmail: a.email().required(),
      isApproved: a.boolean().default(false),
      articleId: a.id().required(),
      article: a.belongsTo('Article', 'articleId'),
    })
    .authorization(allow => [allow.authenticated()]),

  Media: a
    .model({
      filename: a.string().required(),
      url: a.string().required(),
      fileType: a.string().required(),
      fileSize: a.integer(),
      altText: a.string(),
      caption: a.string(),
      uploadedBy: a.id().required(),
    })
    .authorization(allow => [allow.authenticated()]),
});

export type Schema = ClientSchema<typeof schema>;

export const data = defineData({
  schema,
  authorizationModes: {
    defaultAuthorizationMode: 'userPool',
  },
});
```

## Key Implementation Components

### Content Creation
- Rich text editor integration
- Draft auto-saving
- Media embedding
- SEO metadata management
- Content scheduling

### Editorial Workflow
- Multi-stage approval process
- Author-editor collaboration
- Content versioning
- Publication scheduling

### Content Organization
- Hierarchical categories
- Tag-based classification
- Search and filtering
- Content relationships

## Best Practices

1. **Content Security**: Implement proper content validation and sanitization
2. **Performance**: Optimize for fast content loading and search
3. **SEO**: Built-in SEO optimization features
4. **Workflow**: Streamlined editorial processes
5. **Media Management**: Efficient asset organization and delivery

## Steering Integration

This pattern integrates with ACE-Flow steering files:
- **architecture-decisions.md**: CMS design and technology choices
- **domain-expertise.md**: Publishing workflow knowledge
- **quality-standards.md**: Content quality and security standards

For detailed implementation, see the existing [social_platform.md](./social_platform.md) pattern as a reference.