---
name: advanced-patterns
description: Advanced patterns for complex scenarios and optimizations
version: 1.0.0
inclusion: manual
---

# Advanced Patterns

This steering file contains advanced patterns for complex scenarios. Load with `#steering:advanced-patterns`.

## Real-Time Collaboration

### Implementing Conflict Resolution
For real-time collaborative features with conflict resolution:

```typescript
// Conflict-free replicated data type (CRDT) pattern
interface CollaborativeDocument {
  id: string;
  version: number;
  operations: Operation[];
  lastSyncedVersion: number;
}

interface Operation {
  id: string;
  userId: string;
  timestamp: number;
  type: 'insert' | 'delete' | 'format';
  position: number;
  content?: string;
}

// Operational transformation for concurrent edits
export function transformOperation(
  op1: Operation,
  op2: Operation
): Operation {
  // Transform op1 against op2
  if (op1.timestamp < op2.timestamp) {
    if (op1.position <= op2.position) {
      return op1;
    } else {
      return {
        ...op1,
        position: op1.position + (op2.type === 'insert' ? 1 : -1)
      };
    }
  }
  // Additional transformation logic...
}
```

## Performance Optimizations

### DynamoDB Query Optimization
For high-performance queries with large datasets:

```typescript
// Parallel scanning with pagination
export async function parallelScan(
  tableName: string,
  filterExpression?: string
) {
  const segments = 4; // Number of parallel segments
  const scanPromises = [];
  
  for (let i = 0; i < segments; i++) {
    scanPromises.push(
      scanSegment(tableName, i, segments, filterExpression)
    );
  }
  
  const results = await Promise.all(scanPromises);
  return results.flat();
}

// Single-table design pattern
interface SingleTableItem {
  PK: string;    // Partition key
  SK: string;    // Sort key
  TYPE: string;  // Entity type
  GSI1PK?: string; // Global secondary index
  GSI1SK?: string;
  // Entity-specific attributes
  [key: string]: any;
}
```

## Complex Authorization

### Multi-Tenant Data Isolation
```typescript
// Schema with tenant isolation
const schema = a.schema({
  TenantData: a.model({
    tenantId: a.string().required(),
    dataType: a.string().required(),
    content: a.json(),
    // Composite key for tenant isolation
    id: a.string().required(),
  })
  .identifier(['tenantId', 'id'])
  .authorization((allow) => [
    // Custom authorization rule
    allow.custom({
      provider: 'tenantIsolation',
      operations: ['read', 'update', 'delete']
    })
  ])
});

// Custom authorization handler
export const tenantIsolation = defineFunction({
  entry: './tenant-auth.ts',
  environment: {
    TENANT_TABLE: process.env.TENANT_TABLE
  }
});
```

## Event-Driven Architecture

### Complex Event Processing
```typescript
// Event sourcing pattern
interface DomainEvent {
  aggregateId: string;
  eventType: string;
  eventData: any;
  eventTime: string;
  version: number;
}

// CQRS command handler
export class OrderCommandHandler {
  async handle(command: Command): Promise<void> {
    switch (command.type) {
      case 'CreateOrder':
        await this.createOrder(command);
        break;
      case 'UpdateOrder':
        await this.updateOrder(command);
        break;
      // More command handlers...
    }
  }
  
  private async createOrder(command: CreateOrderCommand) {
    // Validate business rules
    // Create events
    // Save to event store
    // Publish to event bus
  }
}
```

## Batch Processing

### Efficient Bulk Operations
```typescript
// Batch write with error handling
export async function batchWriteWithRetry(
  items: any[],
  tableName: string,
  maxRetries = 3
) {
  const chunks = chunk(items, 25); // DynamoDB limit
  
  for (const chunk of chunks) {
    let retries = 0;
    let unprocessed = chunk;
    
    while (unprocessed.length > 0 && retries < maxRetries) {
      const result = await writeBatch(unprocessed, tableName);
      unprocessed = result.unprocessedItems || [];
      
      if (unprocessed.length > 0) {
        retries++;
        await exponentialBackoff(retries);
      }
    }
    
    if (unprocessed.length > 0) {
      throw new Error(`Failed to process ${unprocessed.length} items`);
    }
  }
}
```

## Cost Optimization

### Lambda Cost Reduction
```typescript
// Provisioned concurrency for predictable performance
export const apiHandler = defineFunction({
  entry: './api-handler.ts',
  runtime: 'nodejs18.x',
  memorySize: 1024,
  provisionedConcurrency: {
    minCapacity: 2,
    maxCapacity: 10,
    targetUtilization: 0.7
  }
});

// Connection pooling for RDS
let connection: Connection | null = null;

export async function handler(event: any) {
  if (!connection) {
    connection = await createConnection({
      // Connection config
    });
  }
  
  try {
    // Use connection
  } catch (error) {
    connection = null; // Reset on error
    throw error;
  }
}
```

## Advanced Caching

### Multi-Layer Caching Strategy
```typescript
// Cache hierarchy: Memory → DynamoDB → Source
export class CacheManager {
  private memoryCache = new Map();
  private ttl = 300; // 5 minutes
  
  async get(key: string): Promise<any> {
    // L1: Memory cache
    if (this.memoryCache.has(key)) {
      return this.memoryCache.get(key);
    }
    
    // L2: DynamoDB cache
    const cached = await this.getDynamoDBCache(key);
    if (cached && !this.isExpired(cached)) {
      this.memoryCache.set(key, cached.value);
      return cached.value;
    }
    
    // L3: Fetch from source
    const fresh = await this.fetchFromSource(key);
    await this.setCache(key, fresh);
    return fresh;
  }
}
```

## Migration Patterns

### Gradual Migration Strategy
```typescript
// Feature flag based migration
export async function getData(id: string) {
  const migrationFlag = await getFeatureFlag('use-new-data-model');
  
  if (migrationFlag.enabled) {
    return getDataFromNewModel(id);
  } else {
    const oldData = await getDataFromOldModel(id);
    return transformToNewFormat(oldData);
  }
}

// Dual-write pattern for zero-downtime migration
export async function saveData(data: any) {
  // Write to both old and new systems
  await Promise.all([
    saveToOldSystem(data),
    saveToNewSystem(transformData(data))
  ]);
}
```

---

These advanced patterns should only be used when simpler solutions don't meet requirements. Always consider maintenance complexity and team expertise before implementing.