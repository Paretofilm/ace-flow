# Dashboard Analytics Architecture Pattern

**Comprehensive architecture pattern for building analytics dashboards, business intelligence platforms, and data visualization applications with AWS Amplify Gen 2 and Next.js.**

## 🎯 Pattern Overview

### What This Pattern Provides
The Dashboard Analytics pattern enables building scalable data visualization platforms with features like real-time metrics, interactive charts, custom reports, data filtering, and multi-tenant analytics. It's designed for applications that need to transform raw data into actionable insights through compelling visualizations.

### Core Characteristics
- **Data-Driven Design**: Everything revolves around collecting, processing, and visualizing data
- **Real-Time Updates**: Live data streaming and real-time dashboard updates
- **Interactive Visualizations**: Dynamic charts, graphs, and data exploration tools
- **Custom Reporting**: Flexible report generation and scheduled exports
- **Multi-Tenant Analytics**: Isolated data views for different organizations or users

## 🏗️ Architecture Components

### High-Level Architecture
```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Next.js App   │    │  Amplify Gen 2   │    │  AWS Services   │
│                 │    │                  │    │                 │
│ • Dashboards    │◄──►│ • GraphQL API    │◄──►│ • Cognito       │
│ • Charts/Graphs │    │ • Analytics API  │    │ • DynamoDB      │
│ • Reports       │    │ • Auth Rules     │    │ • Kinesis       │
│ • Data Filters  │    │ • Data Models    │    │ • Lambda        │
│ • Export Tools  │    │ • Subscriptions  │    │ • QuickSight    │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

### Key Components

#### 1. Metrics & Data Collection System
```typescript
// Core analytics interfaces
interface Metric {
  id: string;
  name: string;
  description?: string;
  type: 'count' | 'sum' | 'average' | 'percentage' | 'ratio';
  category: string;
  unit?: string;
  precision?: number;
  isActive: boolean;
  formula?: string;
  createdAt: Date;
  updatedAt: Date;
}

interface DataPoint {
  id: string;
  metricId: string;
  value: number;
  dimensions: Record<string, string>; // { region: 'us-east', product: 'premium' }
  timestamp: Date;
  source: string;
  metadata?: Record<string, any>;
}

interface Dashboard {
  id: string;
  name: string;
  description?: string;
  ownerId: string;
  organizationId?: string;
  layout: DashboardLayout[];
  filters: DashboardFilter[];
  refreshInterval: number; // seconds
  isPublic: boolean;
  shareToken?: string;
  createdAt: Date;
  updatedAt: Date;
}

interface DashboardLayout {
  widgetId: string;
  x: number;
  y: number;
  width: number;
  height: number;
  minWidth?: number;
  minHeight?: number;
}
```

#### 2. Widget & Visualization System
```typescript
// Dashboard widget interfaces
interface Widget {
  id: string;
  dashboardId: string;
  type: 'chart' | 'kpi' | 'table' | 'map' | 'text' | 'filter';
  title: string;
  description?: string;
  config: WidgetConfig;
  queries: WidgetQuery[];
  position: WidgetPosition;
  createdAt: Date;
  updatedAt: Date;
}

interface WidgetConfig {
  chartType?: 'line' | 'bar' | 'pie' | 'area' | 'scatter' | 'heatmap' | 'gauge';
  colorScheme?: string[];
  showLegend?: boolean;
  showAxisLabels?: boolean;
  showDataLabels?: boolean;
  aggregation?: 'sum' | 'avg' | 'count' | 'min' | 'max';
  timeRange?: TimeRange;
  refreshRate?: number;
  customOptions?: Record<string, any>;
}

interface WidgetQuery {
  id: string;
  metricIds: string[];
  filters: QueryFilter[];
  groupBy: string[];
  timeRange: TimeRange;
  limit?: number;
  sortBy?: string;
  sortOrder?: 'asc' | 'desc';
}

interface TimeRange {
  type: 'relative' | 'absolute';
  value: string; // e.g., '7d', '30d', 'yesterday', or ISO date range
  start?: Date;
  end?: Date;
}
```

#### 3. Real-Time Data Streaming
```typescript
// Real-time analytics interfaces
interface DataStream {
  id: string;
  name: string;
  source: 'api' | 'webhook' | 'kinesis' | 'lambda';
  endpoint?: string;
  schema: DataSchema;
  transformations: DataTransformation[];
  isActive: boolean;
  lastProcessed?: Date;
}

interface DataSchema {
  fields: SchemaField[];
  primaryKey: string;
  timestampField: string;
}

interface SchemaField {
  name: string;
  type: 'string' | 'number' | 'boolean' | 'date' | 'json';
  required: boolean;
  description?: string;
}

interface DataTransformation {
  type: 'filter' | 'map' | 'aggregate' | 'enrich';
  config: Record<string, any>;
  order: number;
}
```

## 📊 Data Modeling Strategy

### Core Analytics Models

#### Metrics & Data Points Schema
```typescript
// amplify/data/resource.ts
import { type ClientSchema, a } from '@aws-amplify/backend';

const schema = a.schema({
  Metric: a
    .model({
      name: a.string().required(),
      displayName: a.string(),
      description: a.string(),
      type: a.enum(['count', 'sum', 'average', 'percentage', 'ratio']).required(),
      category: a.string().required(),
      unit: a.string(),
      precision: a.integer().default(2),
      isActive: a.boolean().default(true),
      formula: a.string(),
      organizationId: a.id(),
      createdById: a.id().required(),
      
      // Relations
      organization: a.belongsTo('Organization', 'organizationId'),
      createdBy: a.belongsTo('User', 'createdById'),
      dataPoints: a.hasMany('DataPoint', 'metricId'),
      widgets: a.hasMany('Widget', 'metricId'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update', 'delete']),
      allow.groups(['admin', 'analyst']).to(['create', 'read', 'update']),
      allow.authenticated().to(['read']),
    ])
    .secondaryIndexes(index => [
      index('organizationId').sortKeys(['category', 'name']).name('byOrganization'),
      index('category').sortKeys(['name']).name('byCategory'),
      index('isActive').sortKeys(['createdAt']).name('byActive'),
    ]),

  DataPoint: a
    .model({
      metricId: a.id().required(),
      value: a.float().required(),
      dimensions: a.json(), // { region: 'us-east', product: 'premium' }
      timestamp: a.datetime().required(),
      source: a.string().required(),
      metadata: a.json(),
      organizationId: a.id(),
      
      // Relations
      metric: a.belongsTo('Metric', 'metricId'),
      organization: a.belongsTo('Organization', 'organizationId'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read']),
      allow.groups(['admin', 'analyst']).to(['create', 'read']),
      allow.authenticated().to(['read']),
    ])
    .secondaryIndexes(index => [
      index('metricId').sortKeys(['timestamp']).name('byMetricAndTime'),
      index('organizationId').sortKeys(['timestamp']).name('byOrgAndTime'),
      index('timestamp').name('byTimestamp'),
      index('source').sortKeys(['timestamp']).name('bySource'),
    ]),

  Dashboard: a
    .model({
      name: a.string().required(),
      description: a.string(),
      ownerId: a.id().required(),
      organizationId: a.id(),
      layout: a.json(), // Array of widget positions
      filters: a.json(), // Global dashboard filters
      refreshInterval: a.integer().default(300), // 5 minutes
      isPublic: a.boolean().default(false),
      shareToken: a.string(),
      tags: a.string().array(),
      
      // Relations
      owner: a.belongsTo('User', 'ownerId'),
      organization: a.belongsTo('Organization', 'organizationId'),
      widgets: a.hasMany('Widget', 'dashboardId'),
      reports: a.hasMany('Report', 'dashboardId'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update', 'delete']),
      allow.groups(['admin']).to(['read', 'update']),
      allow.authenticated().to(['read']).where(dashboard => dashboard.isPublic),
    ])
    .secondaryIndexes(index => [
      index('ownerId').sortKeys(['updatedAt']).name('byOwner'),
      index('organizationId').sortKeys(['updatedAt']).name('byOrganization'),
      index('isPublic').sortKeys(['createdAt']).name('byPublic'),
    ]),

  Widget: a
    .model({
      dashboardId: a.id().required(),
      metricId: a.id(),
      type: a.enum(['chart', 'kpi', 'table', 'map', 'text', 'filter']).required(),
      title: a.string().required(),
      description: a.string(),
      config: a.json().required(), // Widget configuration
      queries: a.json(), // Array of widget queries
      position: a.json(), // { x, y, width, height }
      
      // Relations
      dashboard: a.belongsTo('Dashboard', 'dashboardId'),
      metric: a.belongsTo('Metric', 'metricId'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update', 'delete']),
      allow.groups(['admin', 'analyst']).to(['read', 'update']),
    ]),
});
```

#### User & Organization Schema
```typescript
// User management for analytics
const userSchema = a.schema({
  Organization: a
    .model({
      name: a.string().required(),
      domain: a.string(),
      settings: a.json(),
      subscription: a.enum(['free', 'basic', 'pro', 'enterprise']).default('free'),
      dataRetentionDays: a.integer().default(90),
      maxDashboards: a.integer().default(5),
      maxUsers: a.integer().default(10),
      
      // Relations
      users: a.hasMany('User', 'organizationId'),
      dashboards: a.hasMany('Dashboard', 'organizationId'),
      metrics: a.hasMany('Metric', 'organizationId'),
      dataStreams: a.hasMany('DataStream', 'organizationId'),
    })
    .authorization(allow => [
      allow.groups(['admin']).to(['create', 'read', 'update', 'delete']),
    ]),

  User: a
    .model({
      email: a.email().required(),
      firstName: a.string().required(),
      lastName: a.string().required(),
      role: a.enum(['viewer', 'analyst', 'admin', 'owner']).default('viewer'),
      organizationId: a.id(),
      preferences: a.json(),
      lastLoginAt: a.datetime(),
      
      // Relations
      organization: a.belongsTo('Organization', 'organizationId'),
      dashboards: a.hasMany('Dashboard', 'ownerId'),
      reports: a.hasMany('Report', 'createdById'),
      metrics: a.hasMany('Metric', 'createdById'),
    })
    .authorization(allow => [
      allow.owner().to(['read', 'update']),
      allow.groups(['admin']).to(['read', 'update']),
    ]),

  DataStream: a
    .model({
      name: a.string().required(),
      source: a.enum(['api', 'webhook', 'kinesis', 'lambda']).required(),
      endpoint: a.string(),
      schema: a.json().required(),
      transformations: a.json(),
      isActive: a.boolean().default(true),
      lastProcessed: a.datetime(),
      organizationId: a.id().required(),
      
      // Relations
      organization: a.belongsTo('Organization', 'organizationId'),
    })
    .authorization(allow => [
      allow.groups(['admin', 'analyst']).to(['create', 'read', 'update', 'delete']),
    ]),

  Report: a
    .model({
      name: a.string().required(),
      description: a.string(),
      dashboardId: a.id(),
      config: a.json().required(),
      schedule: a.json(), // Cron-like schedule
      format: a.enum(['pdf', 'excel', 'csv']).default('pdf'),
      recipients: a.email().array(),
      isActive: a.boolean().default(true),
      lastGenerated: a.datetime(),
      createdById: a.id().required(),
      
      // Relations
      dashboard: a.belongsTo('Dashboard', 'dashboardId'),
      createdBy: a.belongsTo('User', 'createdById'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update', 'delete']),
      allow.groups(['admin', 'analyst']).to(['read', 'update']),
    ]),
});
```

## 🎨 UI Components Implementation

### Dashboard Components

#### Dashboard Grid Component
```typescript
// components/DashboardGrid.tsx
'use client';

import { useState, useEffect, useMemo } from 'react';
import { Responsive, WidthProvider } from 'react-grid-layout';
import { generateClient } from 'aws-amplify/data';
import { Widget } from './Widget';
import { DashboardFilters } from './DashboardFilters';
import type { Schema } from '@/amplify/data/resource';

const ResponsiveGridLayout = WidthProvider(Responsive);
const client = generateClient<Schema>();

interface DashboardGridProps {
  dashboardId: string;
  isEditable?: boolean;
  onLayoutChange?: (layout: any[]) => void;
}

export function DashboardGrid({ 
  dashboardId, 
  isEditable = false,
  onLayoutChange 
}: DashboardGridProps) {
  const [dashboard, setDashboard] = useState<Schema['Dashboard']['type'] | null>(null);
  const [widgets, setWidgets] = useState<Schema['Widget']['type'][]>([]);
  const [filters, setFilters] = useState<Record<string, any>>({});
  const [loading, setLoading] = useState(true);

  // Real-time subscriptions for dashboard updates
  useEffect(() => {
    const fetchDashboard = async () => {
      try {
        const result = await client.models.Dashboard.get(
          { id: dashboardId },
          { include: { widgets: true } }
        );
        
        if (result.data) {
          setDashboard(result.data);
          setWidgets(result.data.widgets || []);
        }
      } catch (error) {
        console.error('Error fetching dashboard:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchDashboard();

    // Subscribe to real-time updates
    const subscription = client.models.Dashboard.observeQuery({
      filter: { id: { eq: dashboardId } }
    }).subscribe({
      next: ({ items }) => {
        if (items.length > 0) {
          setDashboard(items[0]);
        }
      },
    });

    return () => subscription.unsubscribe();
  }, [dashboardId]);

  // Auto-refresh based on dashboard settings
  useEffect(() => {
    if (!dashboard?.refreshInterval) return;

    const interval = setInterval(() => {
      // Refresh all widgets
      setWidgets(prev => [...prev]); // Trigger re-render
    }, dashboard.refreshInterval * 1000);

    return () => clearInterval(interval);
  }, [dashboard?.refreshInterval]);

  const layout = useMemo(() => {
    if (!dashboard?.layout) return [];
    
    return dashboard.layout.map((item: any) => ({
      i: item.widgetId,
      x: item.x,
      y: item.y,
      w: item.width,
      h: item.height,
      minW: item.minWidth || 2,
      minH: item.minHeight || 2,
    }));
  }, [dashboard?.layout]);

  const handleLayoutChange = async (newLayout: any[]) => {
    if (!isEditable || !dashboard) return;

    const updatedLayout = newLayout.map(item => ({
      widgetId: item.i,
      x: item.x,
      y: item.y,
      width: item.w,
      height: item.h,
      minWidth: item.minW,
      minHeight: item.minH,
    }));

    try {
      await client.models.Dashboard.update({
        id: dashboard.id,
        layout: updatedLayout,
      });
    } catch (error) {
      console.error('Error updating layout:', error);
    }

    onLayoutChange?.(newLayout);
  };

  const handleFilterChange = (filterName: string, value: any) => {
    setFilters(prev => ({
      ...prev,
      [filterName]: value
    }));
  };

  if (loading) return <DashboardSkeleton />;
  if (!dashboard) return <div>Dashboard not found</div>;

  return (
    <div className="dashboard-container">
      <div className="dashboard-header">
        <div className="dashboard-info">
          <h1>{dashboard.name}</h1>
          {dashboard.description && (
            <p className="dashboard-description">{dashboard.description}</p>
          )}
        </div>
        
        <div className="dashboard-actions">
          <div className="refresh-indicator">
            <span>Auto-refresh: {dashboard.refreshInterval}s</span>
          </div>
          
          {isEditable && (
            <button className="btn-secondary">
              Add Widget
            </button>
          )}
        </div>
      </div>

      {dashboard.filters && dashboard.filters.length > 0 && (
        <DashboardFilters
          filters={dashboard.filters}
          values={filters}
          onChange={handleFilterChange}
        />
      )}

      <div className="dashboard-grid">
        <ResponsiveGridLayout
          className="layout"
          layouts={{ lg: layout }}
          breakpoints={{ lg: 1200, md: 996, sm: 768, xs: 480, xxs: 0 }}
          cols={{ lg: 12, md: 10, sm: 6, xs: 4, xxs: 2 }}
          rowHeight={60}
          isDraggable={isEditable}
          isResizable={isEditable}
          onLayoutChange={handleLayoutChange}
          margin={[16, 16]}
          containerPadding={[0, 0]}
        >
          {widgets.map((widget) => (
            <div key={widget.id} className="widget-container">
              <Widget
                widget={widget}
                filters={filters}
                isEditable={isEditable}
              />
            </div>
          ))}
        </ResponsiveGridLayout>
      </div>
    </div>
  );
}
```

#### Widget Component
```typescript
// components/Widget.tsx
'use client';

import { useState, useEffect, useMemo } from 'react';
import { LineChart, BarChart, PieChart, AreaChart } from 'recharts';
import { generateClient } from 'aws-amplify/data';
import { WidgetHeader } from './WidgetHeader';
import { WidgetLoader } from './WidgetLoader';
import { WidgetError } from './WidgetError';
import type { Schema } from '@/amplify/data/resource';

const client = generateClient<Schema>();

interface WidgetProps {
  widget: Schema['Widget']['type'];
  filters?: Record<string, any>;
  isEditable?: boolean;
}

export function Widget({ widget, filters = {}, isEditable = false }: WidgetProps) {
  const [data, setData] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Fetch widget data based on queries and filters
  useEffect(() => {
    fetchWidgetData();
  }, [widget.id, filters]);

  const fetchWidgetData = async () => {
    try {
      setLoading(true);
      setError(null);

      if (!widget.queries || !Array.isArray(widget.queries)) {
        setData([]);
        return;
      }

      const queryPromises = widget.queries.map(async (query: any) => {
        const timeRange = query.timeRange || { type: 'relative', value: '7d' };
        const { start, end } = getTimeRangeValues(timeRange);

        const result = await client.models.DataPoint.list({
          filter: {
            and: [
              { metricId: { eq: query.metricIds[0] } }, // Simplified for single metric
              { timestamp: { between: [start.toISOString(), end.toISOString()] } },
              ...buildQueryFilters(query.filters, filters),
            ]
          },
          sort: { field: 'timestamp', direction: 'desc' },
          limit: query.limit || 1000,
        });

        return processQueryResult(result.data, query, widget.config);
      });

      const results = await Promise.all(queryPromises);
      const processedData = combineQueryResults(results, widget.config);
      setData(processedData);
    } catch (err) {
      console.error('Error fetching widget data:', err);
      setError('Failed to load widget data');
    } finally {
      setLoading(false);
    }
  };

  const getTimeRangeValues = (timeRange: any) => {
    const now = new Date();
    let start: Date, end: Date;

    if (timeRange.type === 'relative') {
      const value = timeRange.value;
      if (value.endsWith('d')) {
        const days = parseInt(value);
        start = new Date(now.getTime() - days * 24 * 60 * 60 * 1000);
      } else if (value.endsWith('h')) {
        const hours = parseInt(value);
        start = new Date(now.getTime() - hours * 60 * 60 * 1000);
      } else {
        start = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000); // Default 7 days
      }
      end = now;
    } else {
      start = new Date(timeRange.start);
      end = new Date(timeRange.end);
    }

    return { start, end };
  };

  const buildQueryFilters = (queryFilters: any[] = [], globalFilters: Record<string, any>) => {
    const filters = [];

    // Add query-specific filters
    queryFilters.forEach(filter => {
      if (filter.field && filter.operator && filter.value !== undefined) {
        const filterCondition = buildFilterCondition(filter);
        if (filterCondition) filters.push(filterCondition);
      }
    });

    // Add global dashboard filters
    Object.entries(globalFilters).forEach(([key, value]) => {
      if (value !== undefined && value !== null && value !== '') {
        filters.push({
          [`dimensions.${key}`]: { eq: value }
        });
      }
    });

    return filters;
  };

  const buildFilterCondition = (filter: any) => {
    const { field, operator, value } = filter;
    const fieldPath = field.startsWith('dimensions.') ? field : `dimensions.${field}`;

    switch (operator) {
      case 'eq':
        return { [fieldPath]: { eq: value } };
      case 'ne':
        return { [fieldPath]: { ne: value } };
      case 'gt':
        return { [fieldPath]: { gt: value } };
      case 'gte':
        return { [fieldPath]: { gte: value } };
      case 'lt':
        return { [fieldPath]: { lt: value } };
      case 'lte':
        return { [fieldPath]: { lte: value } };
      case 'contains':
        return { [fieldPath]: { contains: value } };
      case 'in':
        return { [fieldPath]: { in: Array.isArray(value) ? value : [value] } };
      default:
        return null;
    }
  };

  const processQueryResult = (dataPoints: any[], query: any, config: any) => {
    if (!dataPoints.length) return [];

    // Group by time period and dimensions
    const groupedData = groupDataPoints(dataPoints, query.groupBy || [], config.aggregation || 'sum');
    
    // Sort and limit results
    const sortedData = sortData(groupedData, query.sortBy, query.sortOrder);
    
    return query.limit ? sortedData.slice(0, query.limit) : sortedData;
  };

  const groupDataPoints = (dataPoints: any[], groupBy: string[], aggregation: string) => {
    const groups = new Map();

    dataPoints.forEach(point => {
      // Create group key from groupBy fields
      let groupKey = '';
      if (groupBy.length > 0) {
        groupKey = groupBy.map(field => {
          if (field === 'timestamp') {
            return formatTimestamp(point.timestamp, 'day'); // Group by day
          }
          return point.dimensions?.[field] || 'unknown';
        }).join('|');
      } else {
        groupKey = formatTimestamp(point.timestamp, 'day');
      }

      if (!groups.has(groupKey)) {
        groups.set(groupKey, {
          key: groupKey,
          values: [],
          timestamp: point.timestamp,
          dimensions: point.dimensions || {},
        });
      }

      groups.get(groupKey).values.push(point.value);
    });

    // Apply aggregation
    return Array.from(groups.values()).map(group => ({
      ...group,
      value: applyAggregation(group.values, aggregation),
      count: group.values.length,
    }));
  };

  const applyAggregation = (values: number[], type: string) => {
    switch (type) {
      case 'sum':
        return values.reduce((a, b) => a + b, 0);
      case 'avg':
        return values.reduce((a, b) => a + b, 0) / values.length;
      case 'count':
        return values.length;
      case 'min':
        return Math.min(...values);
      case 'max':
        return Math.max(...values);
      default:
        return values.reduce((a, b) => a + b, 0);
    }
  };

  const formatTimestamp = (timestamp: string, period: string) => {
    const date = new Date(timestamp);
    switch (period) {
      case 'hour':
        return date.toISOString().slice(0, 13) + ':00:00.000Z';
      case 'day':
        return date.toISOString().slice(0, 10);
      case 'month':
        return date.toISOString().slice(0, 7);
      default:
        return date.toISOString().slice(0, 10);
    }
  };

  const sortData = (data: any[], sortBy?: string, sortOrder = 'desc') => {
    if (!sortBy) return data;

    return [...data].sort((a, b) => {
      let aVal = sortBy === 'value' ? a.value : a[sortBy];
      let bVal = sortBy === 'value' ? b.value : b[sortBy];

      if (typeof aVal === 'string') {
        aVal = aVal.toLowerCase();
        bVal = bVal.toLowerCase();
      }

      if (sortOrder === 'asc') {
        return aVal < bVal ? -1 : aVal > bVal ? 1 : 0;
      } else {
        return aVal > bVal ? -1 : aVal < bVal ? 1 : 0;
      }
    });
  };

  const combineQueryResults = (results: any[][], config: any) => {
    if (results.length === 1) return results[0];
    
    // Combine multiple query results based on widget type
    if (config.chartType === 'line' || config.chartType === 'area') {
      return combineTimeSeriesData(results);
    }
    
    return results[0] || [];
  };

  const combineTimeSeriesData = (results: any[][]) => {
    const combined = new Map();
    
    results.forEach((result, index) => {
      result.forEach(point => {
        const key = point.key;
        if (!combined.has(key)) {
          combined.set(key, { ...point, [`series${index}`]: point.value });
        } else {
          combined.get(key)[`series${index}`] = point.value;
        }
      });
    });
    
    return Array.from(combined.values());
  };

  const renderVisualization = () => {
    if (loading) return <WidgetLoader />;
    if (error) return <WidgetError message={error} onRetry={fetchWidgetData} />;
    if (!data.length) return <div className="no-data">No data available</div>;

    const config = widget.config;

    switch (widget.type) {
      case 'kpi':
        return (
          <div className="kpi-widget">
            <div className="kpi-value">
              {formatValue(data[0]?.value || 0, config)}
            </div>
            <div className="kpi-label">{widget.title}</div>
          </div>
        );

      case 'chart':
        return renderChart(config.chartType, data, config);

      case 'table':
        return renderTable(data, config);

      default:
        return <div>Unsupported widget type: {widget.type}</div>;
    }
  };

  const renderChart = (chartType: string, data: any[], config: any) => {
    const chartProps = {
      data,
      width: '100%',
      height: 200,
      margin: { top: 5, right: 30, left: 20, bottom: 5 },
    };

    switch (chartType) {
      case 'line':
        return (
          <LineChart {...chartProps}>
            {/* Chart components would go here */}
          </LineChart>
        );
      case 'bar':
        return (
          <BarChart {...chartProps}>
            {/* Chart components would go here */}
          </BarChart>
        );
      case 'pie':
        return (
          <PieChart {...chartProps}>
            {/* Chart components would go here */}
          </PieChart>
        );
      case 'area':
        return (
          <AreaChart {...chartProps}>
            {/* Chart components would go here */}
          </AreaChart>
        );
      default:
        return <div>Unsupported chart type: {chartType}</div>;
    }
  };

  const renderTable = (data: any[], config: any) => {
    const columns = config.columns || Object.keys(data[0] || {});
    
    return (
      <div className="table-widget">
        <table>
          <thead>
            <tr>
              {columns.map((col: string) => (
                <th key={col}>{col}</th>
              ))}
            </tr>
          </thead>
          <tbody>
            {data.map((row, index) => (
              <tr key={index}>
                {columns.map((col: string) => (
                  <td key={col}>{formatValue(row[col], config)}</td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    );
  };

  const formatValue = (value: any, config: any) => {
    if (typeof value === 'number') {
      const precision = config.precision || 0;
      return value.toLocaleString(undefined, {
        minimumFractionDigits: precision,
        maximumFractionDigits: precision,
      });
    }
    return value;
  };

  return (
    <div className={`widget widget-${widget.type}`}>
      <WidgetHeader
        title={widget.title}
        description={widget.description}
        isEditable={isEditable}
        onEdit={() => {/* Handle edit */}}
        onDelete={() => {/* Handle delete */}}
      />
      
      <div className="widget-content">
        {renderVisualization()}
      </div>
    </div>
  );
}
```

#### Analytics Chart Components
```typescript
// components/AnalyticsChart.tsx
'use client';

import { useMemo } from 'react';
import {
  LineChart, Line, AreaChart, Area, BarChart, Bar,
  PieChart, Pie, Cell, ScatterChart, Scatter,
  XAxis, YAxis, CartesianGrid, Tooltip, Legend,
  ResponsiveContainer
} from 'recharts';

interface AnalyticsChartProps {
  type: 'line' | 'area' | 'bar' | 'pie' | 'scatter';
  data: any[];
  config: {
    xKey?: string;
    yKey?: string;
    colorScheme?: string[];
    showLegend?: boolean;
    showGrid?: boolean;
    showTooltip?: boolean;
    height?: number;
  };
}

export function AnalyticsChart({ type, data, config }: AnalyticsChartProps) {
  const {
    xKey = 'key',
    yKey = 'value',
    colorScheme = ['#8884d8', '#82ca9d', '#ffc658', '#ff7300', '#00c49f'],
    showLegend = true,
    showGrid = true,
    showTooltip = true,
    height = 300
  } = config;

  const chartData = useMemo(() => {
    return data.map(item => ({
      ...item,
      [xKey]: item[xKey] || item.key,
      [yKey]: item[yKey] || item.value,
    }));
  }, [data, xKey, yKey]);

  const commonProps = {
    data: chartData,
    margin: { top: 20, right: 30, left: 20, bottom: 20 },
  };

  const renderChart = () => {
    switch (type) {
      case 'line':
        return (
          <LineChart {...commonProps}>
            {showGrid && <CartesianGrid strokeDasharray="3 3" />}
            <XAxis dataKey={xKey} />
            <YAxis />
            {showTooltip && <Tooltip />}
            {showLegend && <Legend />}
            <Line
              type="monotone"
              dataKey={yKey}
              stroke={colorScheme[0]}
              strokeWidth={2}
              dot={{ fill: colorScheme[0], strokeWidth: 2 }}
            />
          </LineChart>
        );

      case 'area':
        return (
          <AreaChart {...commonProps}>
            {showGrid && <CartesianGrid strokeDasharray="3 3" />}
            <XAxis dataKey={xKey} />
            <YAxis />
            {showTooltip && <Tooltip />}
            {showLegend && <Legend />}
            <Area
              type="monotone"
              dataKey={yKey}
              stroke={colorScheme[0]}
              fill={colorScheme[0]}
              fillOpacity={0.6}
            />
          </AreaChart>
        );

      case 'bar':
        return (
          <BarChart {...commonProps}>
            {showGrid && <CartesianGrid strokeDasharray="3 3" />}
            <XAxis dataKey={xKey} />
            <YAxis />
            {showTooltip && <Tooltip />}
            {showLegend && <Legend />}
            <Bar dataKey={yKey} fill={colorScheme[0]} />
          </BarChart>
        );

      case 'pie':
        return (
          <PieChart {...commonProps}>
            {showTooltip && <Tooltip />}
            {showLegend && <Legend />}
            <Pie
              dataKey={yKey}
              nameKey={xKey}
              cx="50%"
              cy="50%"
              outerRadius={80}
              fill={colorScheme[0]}
              label
            >
              {chartData.map((entry, index) => (
                <Cell key={`cell-${index}`} fill={colorScheme[index % colorScheme.length]} />
              ))}
            </Pie>
          </PieChart>
        );

      case 'scatter':
        return (
          <ScatterChart {...commonProps}>
            {showGrid && <CartesianGrid strokeDasharray="3 3" />}
            <XAxis dataKey={xKey} />
            <YAxis dataKey={yKey} />
            {showTooltip && <Tooltip />}
            {showLegend && <Legend />}
            <Scatter dataKey={yKey} fill={colorScheme[0]} />
          </ScatterChart>
        );

      default:
        return <div>Unsupported chart type: {type}</div>;
    }
  };

  return (
    <div className="analytics-chart">
      <ResponsiveContainer width="100%" height={height}>
        {renderChart()}
      </ResponsiveContainer>
    </div>
  );
}
```

### Real-Time Data Components

#### Real-Time Metrics Dashboard
```typescript
// components/RealTimeMetrics.tsx
'use client';

import { useState, useEffect } from 'react';
import { generateClient } from 'aws-amplify/data';
import { MetricCard } from './MetricCard';
import { TrendChart } from './TrendChart';
import type { Schema } from '@/amplify/data/resource';

const client = generateClient<Schema>();

interface RealTimeMetricsProps {
  organizationId: string;
  refreshInterval?: number;
}

export function RealTimeMetrics({ 
  organizationId, 
  refreshInterval = 5000 
}: RealTimeMetricsProps) {
  const [metrics, setMetrics] = useState<Schema['Metric']['type'][]>([]);
  const [liveData, setLiveData] = useState<Record<string, any>>({});
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchMetrics();
    
    // Set up real-time data subscription
    const subscription = client.models.DataPoint.observeQuery({
      filter: { organizationId: { eq: organizationId } }
    }).subscribe({
      next: ({ items }) => {
        updateLiveData(items);
      },
      error: (error) => {
        console.error('Real-time subscription error:', error);
      }
    });

    return () => subscription.unsubscribe();
  }, [organizationId]);

  // Auto-refresh data
  useEffect(() => {
    const interval = setInterval(() => {
      fetchLatestData();
    }, refreshInterval);

    return () => clearInterval(interval);
  }, [refreshInterval]);

  const fetchMetrics = async () => {
    try {
      const result = await client.models.Metric.list({
        filter: { 
          and: [
            { organizationId: { eq: organizationId } },
            { isActive: { eq: true } }
          ]
        }
      });
      
      setMetrics(result.data);
      await fetchLatestData();
    } catch (error) {
      console.error('Error fetching metrics:', error);
    } finally {
      setLoading(false);
    }
  };

  const fetchLatestData = async () => {
    const now = new Date();
    const oneHourAgo = new Date(now.getTime() - 60 * 60 * 1000);

    try {
      const dataPromises = metrics.map(async (metric) => {
        const result = await client.models.DataPoint.list({
          filter: {
            and: [
              { metricId: { eq: metric.id } },
              { timestamp: { between: [oneHourAgo.toISOString(), now.toISOString()] } }
            ]
          },
          sort: { field: 'timestamp', direction: 'desc' },
          limit: 100
        });

        return {
          metricId: metric.id,
          data: result.data
        };
      });

      const results = await Promise.all(dataPromises);
      const newLiveData = {};
      
      results.forEach(({ metricId, data }) => {
        newLiveData[metricId] = {
          current: data[0]?.value || 0,
          trend: calculateTrend(data),
          sparkline: data.slice(0, 20).reverse(), // Last 20 points for sparkline
        };
      });

      setLiveData(newLiveData);
    } catch (error) {
      console.error('Error fetching latest data:', error);
    }
  };

  const updateLiveData = (newDataPoints: Schema['DataPoint']['type'][]) => {
    const updates = {};
    
    newDataPoints.forEach(point => {
      if (!updates[point.metricId]) {
        updates[point.metricId] = [];
      }
      updates[point.metricId].push(point);
    });

    setLiveData(prev => {
      const updated = { ...prev };
      
      Object.entries(updates).forEach(([metricId, points]) => {
        const sortedPoints = points.sort((a, b) => 
          new Date(b.timestamp).getTime() - new Date(a.timestamp).getTime()
        );
        
        updated[metricId] = {
          current: sortedPoints[0].value,
          trend: calculateTrend(sortedPoints),
          sparkline: [...(prev[metricId]?.sparkline || []), ...sortedPoints].slice(-20),
        };
      });
      
      return updated;
    });
  };

  const calculateTrend = (dataPoints: any[]) => {
    if (dataPoints.length < 2) return 0;
    
    const latest = dataPoints[0]?.value || 0;
    const previous = dataPoints[1]?.value || 0;
    
    if (previous === 0) return 0;
    return ((latest - previous) / previous) * 100;
  };

  if (loading) return <div>Loading metrics...</div>;

  return (
    <div className="real-time-metrics">
      <div className="metrics-header">
        <h2>Real-Time Metrics</h2>
        <div className="refresh-indicator">
          <span className="live-dot"></span>
          Live
        </div>
      </div>

      <div className="metrics-grid">
        {metrics.map(metric => {
          const data = liveData[metric.id];
          
          return (
            <MetricCard
              key={metric.id}
              metric={metric}
              currentValue={data?.current || 0}
              trend={data?.trend || 0}
              sparklineData={data?.sparkline || []}
            />
          );
        })}
      </div>

      <div className="trends-section">
        <h3>Trend Analysis</h3>
        <div className="trends-grid">
          {metrics.slice(0, 4).map(metric => (
            <TrendChart
              key={metric.id}
              metric={metric}
              data={liveData[metric.id]?.sparkline || []}
            />
          ))}
        </div>
      </div>
    </div>
  );
}
```

## 🔐 Security & Data Privacy

### Data Access Control
```typescript
// Data security and access control
export class AnalyticsSecurityService {
  async validateDataAccess(userId: string, organizationId: string, metricId: string): Promise<boolean> {
    try {
      // Check user's role and permissions
      const user = await client.models.User.get({ id: userId });
      if (!user.data) return false;

      // Check organization membership
      if (user.data.organizationId !== organizationId) return false;

      // Check metric access based on role
      const metric = await client.models.Metric.get({ id: metricId });
      if (!metric.data || metric.data.organizationId !== organizationId) return false;

      // Role-based access control
      const userRole = user.data.role;
      switch (userRole) {
        case 'viewer':
          return true; // Can view all metrics
        case 'analyst':
          return true; // Can view and create metrics
        case 'admin':
        case 'owner':
          return true; // Full access
        default:
          return false;
      }
    } catch (error) {
      console.error('Error validating data access:', error);
      return false;
    }
  }

  async auditDataAccess(userId: string, action: string, resourceId: string): Promise<void> {
    try {
      await client.models.DataAccessLog.create({
        userId,
        action,
        resourceType: 'metric',
        resourceId,
        timestamp: new Date().toISOString(),
        ipAddress: this.getClientIP(),
        userAgent: navigator.userAgent,
      });
    } catch (error) {
      console.error('Error logging data access:', error);
    }
  }
}
```

## ⚡ Performance Optimization

### Data Aggregation & Caching
```typescript
// Performance optimization for analytics
export class AnalyticsPerformanceService {
  async aggregateDataPoints(metricId: string, timeRange: string, granularity: string): Promise<any[]> {
    // Pre-aggregate data for better query performance
    const cacheKey = `aggregated:${metricId}:${timeRange}:${granularity}`;
    
    // Check cache first
    const cached = await this.getFromCache(cacheKey);
    if (cached) return cached;

    // Compute aggregation
    const aggregated = await this.computeAggregation(metricId, timeRange, granularity);
    
    // Cache result
    await this.setCache(cacheKey, aggregated, 300); // 5 minutes
    
    return aggregated;
  }

  async optimizeQueries(queries: any[]): Promise<any[]> {
    // Batch multiple queries together when possible
    const batchedQueries = this.batchSimilarQueries(queries);
    
    // Execute queries in parallel
    const results = await Promise.all(
      batchedQueries.map(batch => this.executeBatchQuery(batch))
    );
    
    return this.flattenBatchResults(results);
  }

  private batchSimilarQueries(queries: any[]): any[][] {
    const batches = new Map();
    
    queries.forEach(query => {
      const key = `${query.metricId}:${query.timeRange}`;
      if (!batches.has(key)) {
        batches.set(key, []);
      }
      batches.get(key).push(query);
    });
    
    return Array.from(batches.values());
  }
}
```

---

*This Dashboard Analytics architecture pattern provides a comprehensive foundation for building scalable analytics platforms with AWS Amplify Gen 2 and Next.js, featuring real-time data visualization, interactive dashboards, custom reporting, and performance optimization.*

**Pattern Version**: 1.0  
**Complexity**: High  
**Estimated Implementation**: 8-12 weeks  
**Recommended Team Size**: 5-7 developers