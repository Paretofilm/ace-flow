# 🚀 Amplify Gen 2 Base Template

**Dynamic prototype generation template for custom AWS Amplify Gen 2 applications.**

## Template Variables System

### Project Configuration
```yaml
project_config:
  name: "{{project_name}}"
  description: "{{project_description}}"
  architecture_pattern: "{{architecture_pattern}}"
  complexity: "{{complexity_level}}"
  timeline: "{{target_timeline}}"
  
user_requirements:
  target_users: "{{target_users}}"
  core_problem: "{{core_problem}}"
  success_metrics: "{{success_metrics}}"
  
technical_config:
  auth_strategy: "{{auth_strategy}}"
  data_complexity: "{{data_complexity}}"
  real_time_needs: "{{real_time_features}}"
  integration_requirements: "{{integrations}}"
  ui_framework: "{{ui_framework}}"
```

## Core File Templates

### 1. Amplify Backend Configuration
```typescript
// amplify/backend.ts
import { defineBackend } from '@aws-amplify/backend';
import { auth } from './auth/resource';
import { data } from './data/resource';
{{#if storage_needed}}
import { storage } from './storage/resource';
{{/if}}
{{#if functions_needed}}
import { functions } from './functions/resource';
{{/if}}

export const backend = defineBackend({
  auth,
  data,
  {{#if storage_needed}}
  storage,
  {{/if}}
  {{#if functions_needed}}
  functions,
  {{/if}}
});

{{#if custom_outputs}}
// Custom outputs for {{architecture_pattern}}
backend.addOutput({
  custom: {
    {{custom_outputs}}
  }
});
{{/if}}
```

### 2. Dynamic Authentication Configuration
```typescript
// amplify/auth/resource.ts
import { defineAuth } from '@aws-amplify/backend';

export const auth = defineAuth({
  loginWith: {
    email: true,
    {{#if social_auth}}
    externalProviders: {
      {{#each social_providers}}
      {{this}}: {
        clientId: secret('{{uppercase this}}_CLIENT_ID'),
        clientSecret: secret('{{uppercase this}}_CLIENT_SECRET'),
      },
      {{/each}}
      callbackUrls: [
        'http://localhost:3000/auth/callback',
        'https://{{domain_name}}/auth/callback'
      ],
      logoutUrls: [
        'http://localhost:3000/',
        'https://{{domain_name}}/'
      ],
    },
    {{/if}}
  },
  {{#if user_groups}}
  groups: [
    {{#each user_roles}}
    '{{this}}',
    {{/each}}
  ],
  {{/if}}
  {{#if custom_attributes}}
  userAttributes: {
    {{#each custom_user_attributes}}
    {{name}}: {
      dataType: '{{dataType}}',
      required: {{required}},
      {{#if mutable}}
      mutable: true,
      {{/if}}
    },
    {{/each}}
  },
  {{/if}}
});
```

### 3. Dynamic Data Schema Generation
```typescript
// amplify/data/resource.ts
import { type ClientSchema, a, defineData } from '@aws-amplify/backend';

const schema = a.schema({
  {{#each data_models}}
  {{name}}: a
    .model({
      {{#each fields}}
      {{name}}: a.{{type}}(){{#if required}}.required(){{/if}}{{#if array}}.array(){{/if}},
      {{/each}}
      {{#if has_relationships}}
      // Relationships
      {{#each relationships}}
      {{name}}: a.belongsTo('{{target_model}}'),
      {{/each}}
      {{/if}}
    })
    {{#if auth_rules}}
    .authorization(allow => [
      {{#each auth_rules}}
      allow.{{type}}(){{#if operations}}.to([{{#each operations}}'{{this}}'{{#unless @last}}, {{/unless}}{{/each}}]){{/if}},
      {{/each}}
    ]),
    {{else}}
    .authorization(allow => [allow.guest(), allow.authenticated()]),
    {{/if}}
  
  {{/each}}
  
  {{#if real_time_subscriptions}}
  // Real-time subscriptions for {{architecture_pattern}}
  {{#each subscription_models}}
  {{name}}Subscription: a
    .model({
      event: a.string().required(),
      data: a.json(),
      userId: a.id(),
      timestamp: a.datetime().required(),
    })
    .authorization(allow => [
      allow.authenticated().to(['create', 'read']),
      allow.owner().to(['update', 'delete'])
    ]),
  {{/each}}
  {{/if}}
});

export type Schema = ClientSchema<typeof schema>;

export const data = defineData({
  schema,
  authorizationModes: {
    defaultAuthorizationMode: '{{default_auth_mode}}',
    {{#if api_key_auth}}
    apiKeyAuthorizationMode: {
      expiresInDays: 30,
    },
    {{/if}}
    {{#if iam_auth}}
    iamAuthorizationMode: {
      authenticatedUserRole: 'CUSTOM',
      unauthenticatedUserRole: 'CUSTOM',
    },
    {{/if}}
  },
});
```

### 4. Storage Configuration (Conditional)
```typescript
// amplify/storage/resource.ts (generated if storage_needed = true)
import { defineStorage } from '@aws-amplify/backend';

export const storage = defineStorage({
  name: '{{project_name_snake_case}}Storage',
  access: (allow) => ({
    {{#if public_uploads}}
    'public/*': [
      allow.guest.to(['read']),
      allow.authenticated.to(['read', 'write', 'delete'])
    ],
    {{/if}}
    {{#if private_uploads}}
    'private/{entity_id}/*': [
      allow.entity('identity').to(['read', 'write', 'delete'])
    ],
    {{/if}}
    {{#if protected_uploads}}
    'protected/{entity_id}/*': [
      allow.entity('identity').to(['read', 'write', 'delete']),
      allow.authenticated.to(['read'])
    ],
    {{/if}}
    {{#each custom_storage_paths}}
    '{{path}}': [
      {{#each permissions}}
      allow.{{role}}.to([{{#each operations}}'{{this}}'{{#unless @last}}, {{/unless}}{{/each}}]),
      {{/each}}
    ],
    {{/each}}
  })
});
```

### 5. Frontend Package Configuration
```json
// package.json
{
  "name": "{{project_name_kebab_case}}",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    {{#if has_tests}}
    "test": "jest",
    "test:watch": "jest --watch",
    {{/if}}
    "amplify:dev": "npx amplify sandbox",
    "amplify:deploy": "npx amplify pipeline-deploy --branch main"
  },
  "dependencies": {
    "next": "14.2.0",
    "react": "18.2.0",
    "react-dom": "18.2.0",
    "aws-amplify": "^6.0.0",
    "@aws-amplify/ui-react": "^6.0.0",
    {{#if ui_framework_tailwind}}
    "tailwindcss": "^3.4.0",
    "@tailwindcss/forms": "^0.5.7",
    "@tailwindcss/typography": "^0.5.10",
    {{/if}}
    {{#if charts_needed}}
    "recharts": "^2.8.0",
    "chart.js": "^4.4.0",
    "react-chartjs-2": "^5.2.0",
    {{/if}}
    {{#if forms_complex}}
    "react-hook-form": "^7.48.0",
    "@hookform/resolvers": "^3.3.0",
    "zod": "^3.22.0",
    {{/if}}
    {{#if date_handling}}
    "date-fns": "^2.30.0",
    {{/if}}
    {{#if icons_needed}}
    "lucide-react": "^0.294.0",
    {{/if}}
    {{#each additional_dependencies}}
    "{{name}}": "{{version}}",
    {{/each}}
  },
  "devDependencies": {
    "@types/node": "20.8.0",
    "@types/react": "18.2.0",
    "@types/react-dom": "18.2.0",
    "typescript": "5.2.0",
    "eslint": "8.51.0",
    "eslint-config-next": "14.2.0",
    {{#if ui_framework_tailwind}}
    "autoprefixer": "^10.4.16",
    "postcss": "^8.4.31",
    {{/if}}
    {{#if has_tests}}
    "jest": "^29.7.0",
    "@testing-library/react": "^13.4.0",
    "@testing-library/jest-dom": "^6.1.0",
    "jest-environment-jsdom": "^29.7.0",
    {{/if}}
    {{#each additional_dev_dependencies}}
    "{{name}}": "{{version}}",
    {{/each}}
  }
}
```

### 6. Next.js Configuration
```javascript
// next.config.js
/** @type {import('next').NextConfig} */
const nextConfig = {
  transpilePackages: ['@aws-amplify/ui-react'],
  {{#if images_optimized}}
  images: {
    domains: [
      '{{s3_domain}}',
      'cloudfront.net',
      {{#each external_image_domains}}
      '{{this}}',
      {{/each}}
    ],
    {{#if responsive_images}}
    deviceSizes: [640, 768, 1024, 1280, 1600],
    imageSizes: [16, 32, 48, 64, 96, 128, 256, 384],
    {{/if}}
  },
  {{/if}}
  {{#if env_variables}}
  env: {
    {{#each custom_env_vars}}
    {{name}}: process.env.{{name}},
    {{/each}}
  },
  {{/if}}
  {{#if redirects}}
  async redirects() {
    return [
      {{#each custom_redirects}}
      {
        source: '{{source}}',
        destination: '{{destination}}',
        permanent: {{permanent}},
      },
      {{/each}}
    ];
  },
  {{/if}}
}

module.exports = nextConfig
```

### 7. Dynamic Component Generation
```typescript
// src/components/{{component_name}}.tsx
'use client';

import { useState, useEffect } from 'react';
import { generateClient } from 'aws-amplify/data';
import type { Schema } from '../../amplify/data/resource';
{{#if ui_components}}
import { 
  {{#each amplify_ui_components}}
  {{this}},
  {{/each}}
} from '@aws-amplify/ui-react';
{{/if}}
{{#if custom_icons}}
import { 
  {{#each icon_imports}}
  {{this}},
  {{/each}}
} from 'lucide-react';
{{/if}}

const client = generateClient<Schema>();

interface {{component_name}}Props {
  {{#each component_props}}
  {{name}}: {{type}};
  {{/each}}
}

export default function {{component_name}}({{#if component_props}}{ {{#each component_props}}{{name}}{{#unless @last}}, {{/unless}}{{/each}} }: {{component_name}}Props{{/if}}) {
  {{#each state_variables}}
  const [{{name}}, set{{pascalcase name}}] = useState<{{type}}>({{default_value}});
  {{/each}}

  {{#if has_data_fetching}}
  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      const result = await client.models.{{primary_model}}.list();
      set{{pascalcase primary_model_state}}(result.data);
    } catch (error) {
      console.error('Error fetching data:', error);
    }
  };
  {{/if}}

  {{#each component_functions}}
  const {{name}} = async ({{#each params}}{{name}}: {{type}}{{#unless @last}}, {{/unless}}{{/each}}) => {
    try {
      {{function_body}}
    } catch (error) {
      console.error('Error in {{name}}:', error);
    }
  };
  {{/each}}

  return (
    <div className="{{container_classes}}">
      {{component_jsx}}
    </div>
  );
}
```

## Template Processing Engine

### Variable Replacement System
```python
class TemplateProcessor:
    def __init__(self, conversation_data: dict, architecture_decision: dict):
        self.conversation = conversation_data
        self.architecture = architecture_decision
        self.variables = self.extract_template_variables()
    
    def extract_template_variables(self) -> dict:
        """
        Extract all template variables from conversation and architecture data
        """
        return {
            # Project basics
            "project_name": self.generate_project_name(),
            "project_name_kebab_case": self.to_kebab_case(self.architecture["project_name"]),
            "project_name_snake_case": self.to_snake_case(self.architecture["project_name"]),
            "project_description": self.conversation["vision"]["core_problem"],
            
            # Architecture configuration
            "architecture_pattern": self.architecture["architecture_type"]["name"],
            "complexity_level": self.architecture["architecture_type"]["complexity"],
            
            # Authentication
            "auth_strategy": self.architecture["auth_strategy"],
            "social_auth": self.requires_social_auth(),
            "social_providers": self.get_social_providers(),
            "user_groups": self.requires_user_groups(),
            "user_roles": self.get_user_roles(),
            
            # Data models
            "data_models": self.generate_data_models(),
            "real_time_subscriptions": self.requires_real_time(),
            "default_auth_mode": self.get_default_auth_mode(),
            
            # Storage
            "storage_needed": self.requires_storage(),
            "public_uploads": self.allows_public_uploads(),
            "private_uploads": self.allows_private_uploads(),
            
            # UI Framework
            "ui_framework_tailwind": self.uses_tailwind(),
            "charts_needed": self.requires_charts(),
            "forms_complex": self.requires_complex_forms(),
            
            # Features
            "has_tests": True,  # Always include tests
            "has_real_time": self.architecture["real_time"]["enabled"],
            "integrations": self.architecture["integrations"],
        }
    
    def generate_data_models(self) -> list:
        """
        Generate data models based on architecture pattern and requirements
        """
        pattern = self.architecture["architecture_type"]["name"]
        
        models = {
            "social_platform": self.generate_social_models(),
            "e_commerce": self.generate_commerce_models(),
            "content_management": self.generate_content_models(),
            "dashboard_analytics": self.generate_analytics_models(),
            "simple_crud": self.generate_crud_models()
        }
        
        return models.get(pattern, self.generate_crud_models())
    
    def process_all_templates(self) -> dict:
        """
        Process all template files and return complete project structure
        """
        return {
            "amplify/backend.ts": self.process_template("amplify_backend"),
            "amplify/auth/resource.ts": self.process_template("auth_resource"),
            "amplify/data/resource.ts": self.process_template("data_resource"),
            "package.json": self.process_template("package_json"),
            "next.config.js": self.process_template("next_config"),
            "src/": self.generate_frontend_structure(),
            "tests/": self.generate_test_structure()
        }
```

---

*This template system enables ACE-Flow to generate completely custom Amplify Gen 2 applications tailored to any project requirements.*