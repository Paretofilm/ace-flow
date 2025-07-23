---
layout: docs
title: Integration with Existing Projects
---

# Integration with Existing Projects

Learn how to safely integrate ACE-Flow with existing applications and migrate legacy systems to modern AWS Amplify Gen 2 architecture.

## Overview

ACE-Flow provides powerful tools for integrating with existing projects, whether you're adding new features to a legacy application or gradually migrating to a modern serverless architecture.

## Assessment and Planning

### Project Analysis

Before integration, ACE-Flow analyzes your existing codebase:

```bash
# Analyze existing project structure
/ace-adopt "existing Node.js app with MySQL database"

# Generate migration assessment report
/ace-assess-project --path=/path/to/existing/project

# Create integration plan
/ace-plan-integration --strategy=gradual
```

### Migration Strategies

#### 1. Gradual Migration (Recommended)

Migrate components incrementally while maintaining existing functionality:

```yaml
# .ace-flow/migration/gradual-plan.yml
strategy: "gradual"
phases:
  - name: "authentication"
    description: "Migrate to Cognito authentication"
    duration: "1-2 weeks"
    components:
      - user_login
      - user_registration
      - password_reset
    
  - name: "api_layer"
    description: "Replace REST API with GraphQL"
    duration: "2-3 weeks"
    components:
      - user_endpoints
      - data_endpoints
      - file_upload
    
  - name: "database"
    description: "Migrate to DynamoDB"
    duration: "3-4 weeks"
    components:
      - user_data
      - application_data
      - relationships
```

#### 2. Parallel Development

Build new features alongside existing system:

```yaml
strategy: "parallel"
approach: "feature_flag"
timeline: "3-6 months"

new_features:
  - real_time_notifications
  - advanced_analytics  
  - mobile_api
  
integration_points:
  - shared_authentication
  - data_synchronization
  - user_sessions
```

#### 3. Complete Replacement

Full system replacement with data migration:

```yaml
strategy: "replacement"
approach: "big_bang"
timeline: "6-12 months"

phases:
  - analysis_and_design
  - development_and_testing
  - data_migration
  - cutover_and_validation
```

## Database Migration

### From SQL to DynamoDB

#### Schema Mapping

```javascript
// .ace-flow/migration/schema-mapping.js
export const schemaMigration = {
  // MySQL Users table -> DynamoDB User model
  users: {
    source: {
      table: 'users',
      columns: ['id', 'email', 'password_hash', 'created_at', 'updated_at']
    },
    target: {
      model: 'User',
      fields: {
        id: 'id',
        email: 'email', 
        // password_hash handled by Cognito
        createdAt: 'created_at',
        updatedAt: 'updated_at'
      }
    },
    transformations: [
      {
        field: 'password_hash',
        action: 'migrate_to_cognito'
      }
    ]
  },

  // Posts table with foreign keys
  posts: {
    source: {
      table: 'posts',
      columns: ['id', 'user_id', 'title', 'content', 'status']
    },
    target: {
      model: 'Post',
      fields: {
        id: 'id',
        authorId: 'user_id',
        title: 'title',
        content: 'content',
        status: 'status'
      }
    },
    relationships: [
      {
        type: 'belongsTo',
        model: 'User',
        foreignKey: 'user_id'
      }
    ]
  }
};
```

#### Data Migration Scripts

```javascript
// .ace-flow/migration/migrate-data.js
import { generateClient } from 'aws-amplify/api';
import mysql from 'mysql2/promise';

const amplifyClient = generateClient();
const mysqlConnection = mysql.createConnection({
  host: process.env.MYSQL_HOST,
  user: process.env.MYSQL_USER,
  password: process.env.MYSQL_PASSWORD,
  database: process.env.MYSQL_DATABASE
});

export const migrateUsers = async () => {
  console.log('Starting user migration...');
  
  // Fetch users from MySQL
  const [rows] = await mysqlConnection.execute('SELECT * FROM users');
  
  for (const user of rows) {
    try {
      // Create user in Cognito
      const cognitoUser = await createCognitoUser({
        email: user.email,
        temporaryPassword: generateTempPassword()
      });

      // Create user record in DynamoDB
      await amplifyClient.models.User.create({
        id: cognitoUser.sub,
        email: user.email,
        legacyId: user.id, // Keep reference to old ID
        migratedAt: new Date()
      });

      console.log(`Migrated user: ${user.email}`);
    } catch (error) {
      console.error(`Failed to migrate user ${user.email}:`, error);
    }
  }
};

export const migratePosts = async () => {
  console.log('Starting posts migration...');
  
  const [posts] = await mysqlConnection.execute(`
    SELECT p.*, u.email as author_email 
    FROM posts p 
    JOIN users u ON p.user_id = u.id
  `);

  for (const post of posts) {
    try {
      // Find migrated user
      const user = await amplifyClient.models.User.list({
        filter: { email: { eq: post.author_email } }
      });

      if (user.data.length === 0) {
        console.warn(`User not found for post ${post.id}`);
        continue;
      }

      // Create post in DynamoDB
      await amplifyClient.models.Post.create({
        title: post.title,
        content: post.content,
        status: post.status,
        authorId: user.data[0].id,
        legacyId: post.id,
        migratedAt: new Date()
      });

      console.log(`Migrated post: ${post.title}`);
    } catch (error) {
      console.error(`Failed to migrate post ${post.id}:`, error);
    }
  }
};
```

### Migration Execution

```bash
# Run migration in stages
/ace-migrate --phase=users --dry-run
/ace-migrate --phase=users --execute

/ace-migrate --phase=posts --dry-run  
/ace-migrate --phase=posts --execute

# Validate migration
/ace-validate-migration --compare-counts
/ace-validate-migration --spot-check=100
```

## API Integration

### Proxy Pattern

Route existing API calls through new GraphQL endpoints:

```javascript
// .ace-flow/integration/api-proxy.js
export const createAPIProxy = (existingAPI, graphqlAPI) => {
  return {
    // Proxy GET /users/:id -> GraphQL User query
    '/users/:id': async (req, res) => {
      try {
        const result = await graphqlAPI.query({
          query: `
            query GetUser($id: ID!) {
              getUser(id: $id) {
                id
                email
                profile {
                  name
                  avatar
                }
              }
            }
          `,
          variables: { id: req.params.id }
        });

        // Transform to match old API format
        const user = transformUserResponse(result.data.getUser);
        res.json(user);
      } catch (error) {
        // Fallback to existing API
        return existingAPI.getUser(req, res);
      }
    },

    // Proxy POST /posts -> GraphQL createPost mutation
    '/posts': async (req, res) => {
      try {
        const result = await graphqlAPI.mutate({
          mutation: `
            mutation CreatePost($input: CreatePostInput!) {
              createPost(input: $input) {
                id
                title
                content
                createdAt
              }
            }
          `,
          variables: { input: req.body }
        });

        res.json(result.data.createPost);
      } catch (error) {
        return existingAPI.createPost(req, res);
      }
    }
  };
};
```

### Dual-Write Pattern

Write to both old and new systems during transition:

```javascript
// .ace-flow/integration/dual-write.js
export const dualWriteMiddleware = (legacyDB, amplifyClient) => {
  return async (req, res, next) => {
    const operation = req.method;
    const resource = req.route.path;

    try {
      // Write to new system first
      const amplifyResult = await writeToAmplify(req.body, amplifyClient);
      
      // Then write to legacy system
      const legacyResult = await writeToLegacy(req.body, legacyDB);
      
      // Use Amplify result as source of truth
      req.result = amplifyResult;
      next();
    } catch (amplifyError) {
      console.warn('Amplify write failed, falling back to legacy:', amplifyError);
      
      // Fallback to legacy system only
      const legacyResult = await writeToLegacy(req.body, legacyDB);
      req.result = legacyResult;
      next();
    }
  };
};
```

## Authentication Migration

### Cognito User Pool Integration

Migrate existing users to Cognito:

```javascript
// .ace-flow/integration/auth-migration.js
import { CognitoIdentityServiceProvider } from 'aws-sdk';

const cognito = new CognitoIdentityServiceProvider();

export const migrateAuthSystem = async (existingUsers) => {
  for (const user of existingUsers) {
    try {
      // Create user in Cognito User Pool
      await cognito.adminCreateUser({
        UserPoolId: process.env.COGNITO_USER_POOL_ID,
        Username: user.email,
        UserAttributes: [
          { Name: 'email', Value: user.email },
          { Name: 'email_verified', Value: 'true' },
          { Name: 'custom:legacy_id', Value: user.id.toString() }
        ],
        MessageAction: 'SUPPRESS', // Don't send welcome email
        TemporaryPassword: generateSecurePassword()
      });

      // Set permanent password if user had one
      if (user.password_hash) {
        await cognito.adminSetUserPassword({
          UserPoolId: process.env.COGNITO_USER_POOL_ID,
          Username: user.email,
          Password: user.temporaryPassword,
          Permanent: false // User must change on first login
        });
      }

      console.log(`Migrated user: ${user.email}`);
    } catch (error) {
      console.error(`Failed to migrate user ${user.email}:`, error);
    }
  }
};
```

### Session Bridge

Maintain sessions across old and new systems:

```javascript
// .ace-flow/integration/session-bridge.js
export const createSessionBridge = (legacySessionStore, cognitoTokens) => {
  return {
    async validateSession(req, res, next) {
      const legacySession = req.session;
      const cognitoToken = req.headers.authorization;

      // Check if user has both sessions
      if (legacySession && cognitoToken) {
        // Validate both and ensure they match
        const isValid = await validateSessionMatch(legacySession, cognitoToken);
        if (isValid) {
          req.user = await getUserFromToken(cognitoToken);
          return next();
        }
      }

      // Fall back to legacy session validation
      if (legacySession) {
        req.user = await getUserFromLegacySession(legacySession);
        return next();
      }

      // No valid session found
      return res.status(401).json({ error: 'Unauthorized' });
    }
  };
};
```

## File Storage Migration

### S3 Integration

Migrate files from local storage to S3:

```javascript
// .ace-flow/integration/file-migration.js
import { S3Client, PutObjectCommand } from '@aws-sdk/client-s3';
import fs from 'fs';
import path from 'path';

const s3Client = new S3Client({ region: process.env.AWS_REGION });

export const migrateFiles = async (localFilePath, s3BucketName) => {
  const files = await fs.promises.readdir(localFilePath, { recursive: true });
  
  for (const file of files) {
    const fullPath = path.join(localFilePath, file);
    const stats = await fs.promises.stat(fullPath);
    
    if (stats.isFile()) {
      try {
        const fileContent = await fs.promises.readFile(fullPath);
        const s3Key = `migrated/${file}`;
        
        await s3Client.send(new PutObjectCommand({
          Bucket: s3BucketName,
          Key: s3Key,
          Body: fileContent,
          ContentType: getMimeType(file)
        }));

        // Update database references
        await updateFileReferences(file, s3Key);
        
        console.log(`Migrated file: ${file} -> s3://${s3BucketName}/${s3Key}`);
      } catch (error) {
        console.error(`Failed to migrate file ${file}:`, error);
      }
    }
  }
};
```

## Testing Integration

### Integration Test Suite

```javascript
// .ace-flow/integration/tests/integration.test.js
import { testIntegration } from '@ace-flow/testing';

describe('Legacy System Integration', () => {
  test('API proxy forwards requests correctly', async () => {
    const response = await fetch('/api/users/123');
    const user = await response.json();
    
    expect(user).toHaveProperty('id', '123');
    expect(user).toHaveProperty('email');
  });

  test('dual-write maintains data consistency', async () => {
    const postData = { title: 'Test Post', content: 'Test content' };
    
    await fetch('/api/posts', {
      method: 'POST',
      body: JSON.stringify(postData),
      headers: { 'Content-Type': 'application/json' }
    });

    // Verify data exists in both systems
    const legacyPost = await legacyDB.query('SELECT * FROM posts WHERE title = ?', [postData.title]);
    const amplifyPost = await amplifyClient.models.Post.list({
      filter: { title: { eq: postData.title } }
    });

    expect(legacyPost).toHaveLength(1);
    expect(amplifyPost.data).toHaveLength(1);
  });
});
```

## Monitoring Integration

### Health Checks

Monitor both systems during integration:

```javascript
// .ace-flow/integration/health-checks.js
export const createHealthChecks = (legacySystem, amplifySystem) => {
  return {
    async checkSystemHealth() {
      const results = await Promise.allSettled([
        checkLegacySystem(legacySystem),
        checkAmplifySystem(amplifySystem),
        checkDataConsistency()
      ]);

      return {
        legacy: results[0].status === 'fulfilled' ? 'healthy' : 'unhealthy',
        amplify: results[1].status === 'fulfilled' ? 'healthy' : 'unhealthy',
        consistency: results[2].status === 'fulfilled' ? 'consistent' : 'inconsistent'
      };
    },

    async checkDataConsistency() {
      // Compare record counts between systems
      const legacyCount = await legacySystem.query('SELECT COUNT(*) FROM users');
      const amplifyCount = await amplifySystem.models.User.list();
      
      const diff = Math.abs(legacyCount[0].count - amplifyCount.data.length);
      const threshold = legacyCount[0].count * 0.05; // 5% tolerance
      
      return diff <= threshold;
    }
  };
};
```

## Best Practices

### Planning Phase

1. **Thorough Assessment** - Understand all dependencies and integrations
2. **Risk Mitigation** - Plan for rollback scenarios
3. **Timeline Realism** - Allow extra time for unexpected issues
4. **Stakeholder Alignment** - Keep all teams informed of changes

### Implementation Phase

1. **Feature Flags** - Use flags to control rollout pace
2. **Gradual Rollout** - Migrate users in batches
3. **Monitoring** - Watch system health continuously  
4. **Data Validation** - Regular consistency checks

### Post-Migration

1. **Performance Monitoring** - Ensure new system performs well
2. **User Feedback** - Collect and address user concerns
3. **Legacy Cleanup** - Remove old systems when safe
4. **Documentation** - Update all system documentation

## Common Pitfalls

### Data Inconsistency

**Problem**: Data gets out of sync between systems
**Solution**: Implement proper dual-write patterns and regular reconciliation

### Performance Degradation  

**Problem**: New system is slower than legacy
**Solution**: Optimize queries, add caching, consider gradual migration

### Authentication Issues

**Problem**: Users can't log in after migration
**Solution**: Maintain legacy auth as fallback during transition

### Breaking Changes

**Problem**: API changes break existing clients
**Solution**: Use versioned APIs and deprecation notices

## Migration Checklist

- [ ] Complete system assessment
- [ ] Create detailed migration plan
- [ ] Set up development/staging environments
- [ ] Implement data migration scripts
- [ ] Create API integration layer
- [ ] Set up monitoring and alerts
- [ ] Test thoroughly in staging
- [ ] Plan rollback procedures
- [ ] Execute gradual rollout
- [ ] Monitor system health
- [ ] Gather user feedback
- [ ] Complete legacy system cleanup

## Getting Help

Need assistance with your integration project?

- **Assessment Service**: Free project analysis - [Schedule consultation](https://ace-flow.dev/consultation)
- **Migration Support**: Expert guidance - [Contact support](mailto:support@ace-flow.dev)
- **Community**: Join our [Discord](https://discord.gg/ace-flow) for peer help
- **Documentation**: [Integration guides](https://docs.ace-flow.dev/integration)

---

*Ready to integrate ACE-Flow with your existing project? Start with our [Project Assessment Tool](https://tools.ace-flow.dev/assess) for personalized recommendations.*