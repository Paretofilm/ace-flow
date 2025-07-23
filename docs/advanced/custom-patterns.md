---
layout: docs
title: Custom Pattern Development
---

# Custom Pattern Development

Learn how to create your own architecture patterns and extend ACE-Flow's capabilities beyond the built-in patterns.

## Overview

ACE-Flow's architecture patterns are designed to be extensible. You can create custom patterns for specialized use cases, industry-specific requirements, or novel application architectures.

## Pattern Structure

### Pattern Definition File

Custom patterns are defined in YAML format:

```yaml
# .ace-flow/patterns/custom-analytics.yml
name: "custom_analytics"
display_name: "Custom Analytics Platform"
description: "Advanced analytics with ML and real-time processing"
category: "analytics"
complexity: "high"
estimated_time: "4-6 hours"

# Required AWS services
services:
  - dynamodb
  - lambda
  - s3
  - kinesis
  - sagemaker
  - opensearch

# Schema definition
schema:
  models:
    - name: "DataSource"
      fields:
        - name: "sourceType"
          type: "enum"
          values: ["api", "database", "stream", "file"]
        - name: "connectionString"
          type: "string"
          required: true
    
    - name: "Dataset"
      fields:
        - name: "name"
          type: "string"
          required: true
        - name: "schema"
          type: "json"
        - name: "dataSource"
          type: "belongsTo"
          model: "DataSource"

# Frontend components to generate
components:
  - name: "DataSourceConnector"
    type: "form"
    purpose: "Configure data source connections"
  
  - name: "AnalyticsDashboard"
    type: "dashboard"  
    purpose: "Real-time analytics visualization"

# Implementation templates
templates:
  backend: "templates/analytics-backend.ts"
  frontend: "templates/analytics-frontend.tsx"
  deployment: "templates/analytics-deploy.yml"
```

### Schema Templates

Create reusable schema templates:

```typescript
// .ace-flow/templates/analytics-backend.ts
import { a } from '@aws-amplify/backend';

export const schema = a.schema({
  DataSource: a.model({
    name: a.string().required(),
    sourceType: a.enum(['api', 'database', 'stream', 'file']),
    connectionString: a.string().required(),
    isActive: a.boolean().default(true),
    datasets: a.hasMany('Dataset', 'dataSourceId'),
    metadata: a.json()
  }).authorization(allow => [
    allow.owner(),
    allow.groups(['analysts']).to(['read'])
  ]),

  Dataset: a.model({
    name: a.string().required(),
    description: a.string(),
    schema: a.json().required(),
    dataSource: a.belongsTo('DataSource', 'dataSourceId'),
    records: a.hasMany('DataRecord', 'datasetId'),
    lastUpdated: a.datetime(),
    recordCount: a.integer().default(0)
  }).secondaryIndexes(index => [
    index('dataSourceId').sortKeys(['lastUpdated']).name('byDataSource')
  ]),

  DataRecord: a.model({
    dataset: a.belongsTo('Dataset', 'datasetId'),
    data: a.json().required(),
    timestamp: a.datetime().required(),
    processingStatus: a.enum(['raw', 'processed', 'error']).default('raw')
  })
});
```

### Component Templates

Generate custom React components:

```tsx
// .ace-flow/templates/analytics-frontend.tsx
import React, { useState, useEffect } from 'react';
import { generateClient } from 'aws-amplify/api';
import type { Schema } from '../amplify/data/resource';

const client = generateClient<Schema>();

export const AnalyticsDashboard: React.FC = () => {
  const [dataSources, setDataSources] = useState([]);
  const [datasets, setDatasets] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      const [dataSourcesResult, datasetsResult] = await Promise.all([
        client.models.DataSource.list(),
        client.models.Dataset.list()
      ]);
      
      setDataSources(dataSourcesResult.data);
      setDatasets(datasetsResult.data);
    } catch (error) {
      console.error('Error fetching data:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) return <div>Loading analytics dashboard...</div>;

  return (
    <div className="analytics-dashboard">
      <h1>Analytics Dashboard</h1>
      
      <div className="dashboard-grid">
        <DataSourcePanel dataSources={dataSources} />
        <DatasetPanel datasets={datasets} />
        <MetricsPanel />
        <VisualizationPanel />
      </div>
    </div>
  );
};

const DataSourcePanel: React.FC<{ dataSources: any[] }> = ({ dataSources }) => (
  <div className="panel">
    <h3>Data Sources</h3>
    {dataSources.map(source => (
      <div key={source.id} className="data-source-item">
        <span className={`status ${source.isActive ? 'active' : 'inactive'}`} />
        <span>{source.name}</span>
        <span className="type">{source.sourceType}</span>
      </div>
    ))}
  </div>
);
```

## Pattern Registration

### Register Custom Pattern

```bash
# Register a new pattern
/ace-register-pattern custom-analytics.yml

# List registered patterns
/ace-list-patterns

# Validate pattern definition
/ace-validate-pattern custom-analytics.yml
```

### Pattern Inheritance

Extend existing patterns:

```yaml
# Extend e-commerce pattern with analytics
name: "ecommerce_analytics"
extends: "e_commerce"
display_name: "E-commerce with Analytics"

# Additional models
additional_models:
  - name: "ProductAnalytics"
    fields:
      - name: "product"
        type: "belongsTo"
        model: "Product"
      - name: "views"
        type: "integer"
        default: 0
      - name: "conversions"
        type: "integer"
        default: 0

# Additional components
additional_components:
  - name: "ProductAnalyticsDashboard"
    type: "dashboard"
    purpose: "Track product performance"
```

## Advanced Features

### Custom Hooks

Add pattern-specific hooks:

```javascript
// .ace-flow/patterns/hooks/analytics-hooks.js
export const analyticsHooks = {
  preGeneration: async (context) => {
    console.log('Setting up analytics infrastructure...');
    // Custom pre-generation logic
  },

  postGeneration: async (context) => {
    console.log('Configuring analytics pipelines...');
    // Set up Kinesis streams, SageMaker endpoints, etc.
  },

  preDeployment: async (context) => {
    // Validate analytics configuration
    await validateAnalyticsSetup(context);
  }
};

const validateAnalyticsSetup = async (context) => {
  // Custom validation logic
  const requiredServices = ['kinesis', 'opensearch', 'sagemaker'];
  
  for (const service of requiredServices) {
    if (!context.services.includes(service)) {
      throw new Error(`Missing required service: ${service}`);
    }
  }
};
```

### Dynamic Schema Generation

Generate schemas programmatically:

```javascript
// .ace-flow/patterns/generators/schema-generator.js
export const generateAnalyticsSchema = (config) => {
  const models = [];
  
  // Generate models based on data sources
  config.dataSources.forEach(source => {
    models.push({
      name: `${source.name}Data`,
      fields: generateFieldsFromSchema(source.schema),
      indexes: generateOptimalIndexes(source.queryPatterns)
    });
  });

  return {
    models,
    relationships: generateRelationships(models),
    authorization: generateAuthRules(config.userRoles)
  };
};
```

## Testing Custom Patterns

### Pattern Testing Framework

```javascript
// .ace-flow/patterns/tests/custom-analytics.test.js
import { testPattern } from '@ace-flow/testing';

describe('Custom Analytics Pattern', () => {
  test('generates valid schema', async () => {
    const result = await testPattern('custom-analytics', {
      dataSources: [
        { name: 'sales', type: 'database' },
        { name: 'events', type: 'stream' }
      ]
    });

    expect(result.schema.models).toHaveLength(3);
    expect(result.schema.models.map(m => m.name)).toContain('DataSource');
  });

  test('creates required AWS resources', async () => {
    const deployment = await testPattern.deploy('custom-analytics');
    
    expect(deployment.resources).toContain('AWS::DynamoDB::Table');
    expect(deployment.resources).toContain('AWS::Kinesis::Stream');
  });
});
```

### Integration Testing

```bash
# Test pattern in sandbox environment
/ace-test-pattern custom-analytics --env=sandbox

# Run comprehensive tests
/ace-test-pattern custom-analytics --full-test

# Performance testing
/ace-test-pattern custom-analytics --performance
```

## Pattern Distribution

### Publishing Patterns

```bash
# Prepare pattern for distribution
/ace-package-pattern custom-analytics

# Publish to ACE-Flow registry
/ace-publish-pattern custom-analytics --registry=community

# Install community patterns
/ace-install-pattern community/financial-analytics
```

### Pattern Marketplace

Submit patterns to the community:

1. **Package** your pattern with documentation
2. **Test** thoroughly across different scenarios
3. **Submit** to the ACE-Flow pattern marketplace
4. **Maintain** and update based on feedback

## Best Practices

### Pattern Design

1. **Keep patterns focused** - Each pattern should solve one primary use case
2. **Design for reusability** - Make patterns configurable and extensible
3. **Include comprehensive documentation** - Document all configuration options
4. **Provide examples** - Include real-world usage examples
5. **Test thoroughly** - Ensure patterns work across different environments

### Performance Considerations

1. **Optimize database schemas** - Include appropriate indexes
2. **Consider scalability** - Design for growth from day one
3. **Minimize API calls** - Batch operations where possible
4. **Cache effectively** - Implement appropriate caching strategies
5. **Monitor resource usage** - Include observability from the start

### Security Guidelines

1. **Follow least privilege** - Grant minimal necessary permissions
2. **Encrypt sensitive data** - Use AWS KMS for encryption keys
3. **Implement proper authorization** - Use Cognito groups and IAM roles
4. **Validate inputs** - Include client and server-side validation
5. **Audit access** - Log all data access and modifications

## Examples

### Machine Learning Pattern

```yaml
name: "ml_platform"
display_name: "Machine Learning Platform"
services:
  - sagemaker
  - s3
  - lambda
  - dynamodb

models:
  - name: "MLModel"
    fields:
      - name: "name"
        type: "string"
        required: true
      - name: "algorithm"
        type: "enum"
        values: ["linear_regression", "random_forest", "neural_network"]
      - name: "trainingData"
        type: "json"
      - name: "modelArn"
        type: "string"
      - name: "status"
        type: "enum"
        values: ["training", "ready", "failed"]
```

### IoT Data Platform

```yaml
name: "iot_platform"
display_name: "IoT Data Collection Platform"
services:
  - iot-core
  - kinesis
  - timestream
  - lambda

models:
  - name: "Device"
    fields:
      - name: "deviceId"
        type: "string"
        required: true
      - name: "deviceType" 
        type: "enum"
        values: ["sensor", "actuator", "gateway"]
      - name: "location"
        type: "json"
      - name: "lastSeen"
        type: "datetime"
```

## Getting Help

- **Documentation**: Check the [Pattern Development Guide](https://docs.ace-flow.dev/patterns)
- **Community**: Join the [Discord server](https://discord.gg/ace-flow) for help
- **Examples**: Browse [community patterns](https://github.com/ace-flow/community-patterns)
- **Issues**: Report bugs on [GitHub](https://github.com/ace-flow/ace-flow/issues)

---

*Ready to build your own patterns? Start with our [Pattern Generator Tool](https://tools.ace-flow.dev/pattern-generator) for guided pattern creation.*