---
layout: docs
title: Monitoring and Analytics
---

# Monitoring and Analytics

Monitor and analyze your ACE-Flow applications with comprehensive observability, performance tracking, and business intelligence.

## Overview

Effective monitoring in ACE-Flow encompasses:
- Application performance monitoring (APM)
- Error tracking and alerting
- Usage analytics and insights
- Custom metrics and KPIs
- Real-time dashboards
- Automated anomaly detection

## Application Performance Monitoring

### Core Performance Metrics

```typescript
// utils/performance-tracker.ts
export class PerformanceTracker {
  private metrics = new Map<string, PerformanceMetric[]>();
  
  async trackOperation(
    operationName: string, 
    operation: () => Promise<any>,
    metadata?: any
  ): Promise<any> {
    const startTime = performance.now();
    const startMemory = process.memoryUsage();
    
    try {
      const result = await operation();
      
      const endTime = performance.now();
      const endMemory = process.memoryUsage();
      
      const metric: PerformanceMetric = {
        operation: operationName,
        duration: endTime - startTime,
        memoryDelta: endMemory.heapUsed - startMemory.heapUsed,
        timestamp: new Date(),
        success: true,
        metadata
      };
      
      await this.recordMetric(metric);
      
      return result;
      
    } catch (error) {
      const endTime = performance.now();
      
      const metric: PerformanceMetric = {
        operation: operationName,
        duration: endTime - startTime,
        timestamp: new Date(),
        success: false,
        error: error.message,
        metadata
      };
      
      await this.recordMetric(metric);
      
      throw error;
    }
  }
  
  private async recordMetric(metric: PerformanceMetric) {
    // Store in local buffer
    if (!this.metrics.has(metric.operation)) {
      this.metrics.set(metric.operation, []);
    }
    
    this.metrics.get(metric.operation)!.push(metric);
    
    // Send to monitoring service
    await this.sendToMonitoring(metric);
    
    // Log slow operations
    if (metric.duration > 1000) {
      console.warn(`Slow operation detected: ${metric.operation} took ${metric.duration}ms`);
    }
  }
  
  async getOperationStats(operationName: string, timeRange: TimeRange) {
    const metrics = await this.getMetricsForOperation(operationName, timeRange);
    
    if (metrics.length === 0) {
      return null;
    }
    
    const durations = metrics.map(m => m.duration);
    const successRate = metrics.filter(m => m.success).length / metrics.length;
    
    return {
      operationName,
      totalCalls: metrics.length,
      successRate,
      averageDuration: durations.reduce((a, b) => a + b, 0) / durations.length,
      p50Duration: this.percentile(durations, 0.5),
      p95Duration: this.percentile(durations, 0.95),
      p99Duration: this.percentile(durations, 0.99),
      maxDuration: Math.max(...durations),
      minDuration: Math.min(...durations)
    };
  }
}

interface PerformanceMetric {
  operation: string;
  duration: number;
  memoryDelta?: number;
  timestamp: Date;
  success: boolean;
  error?: string;
  metadata?: any;
}
```

### Database Query Monitoring

```typescript
// utils/database-monitor.ts
export class DatabaseMonitor {
  private queryTracker = new Map<string, QueryMetrics>();
  
  async monitorQuery<T>(
    queryName: string,
    query: string,
    params: any[],
    executor: () => Promise<T>
  ): Promise<T> {
    const startTime = performance.now();
    
    try {
      const result = await executor();
      const duration = performance.now() - startTime;
      
      await this.recordQueryMetric({
        queryName,
        query: this.sanitizeQuery(query),
        duration,
        success: true,
        rowCount: Array.isArray(result) ? result.length : 1,
        timestamp: new Date()
      });
      
      return result;
      
    } catch (error) {
      const duration = performance.now() - startTime;
      
      await this.recordQueryMetric({
        queryName,
        query: this.sanitizeQuery(query),
        duration,
        success: false,
        error: error.message,
        timestamp: new Date()
      });
      
      throw error;
    }
  }
  
  private sanitizeQuery(query: string): string {
    // Remove sensitive data from query for logging
    return query
      .replace(/\$\d+/g, '?') // Replace parameter placeholders
      .replace(/\s+/g, ' ')   // Normalize whitespace
      .trim();
  }
  
  async getSlowQueries(threshold: number = 1000): Promise<QueryMetrics[]> {
    const allMetrics = Array.from(this.queryTracker.values());
    
    return allMetrics
      .filter(metric => metric.duration > threshold)
      .sort((a, b) => b.duration - a.duration)
      .slice(0, 50); // Top 50 slow queries
  }
  
  async analyzeQueryPerformance(): Promise<QueryAnalysis> {
    const metrics = Array.from(this.queryTracker.values());
    
    const analysis = {
      totalQueries: metrics.length,
      averageDuration: metrics.reduce((sum, m) => sum + m.duration, 0) / metrics.length,
      slowQueries: metrics.filter(m => m.duration > 1000).length,
      failedQueries: metrics.filter(m => !m.success).length,
      mostFrequent: this.getMostFrequentQueries(metrics),
      slowestOperations: this.getSlowestOperations(metrics)
    };
    
    return analysis;
  }
}

interface QueryMetrics {
  queryName: string;
  query: string;
  duration: number;
  success: boolean;
  rowCount?: number;
  error?: string;
  timestamp: Date;
}
```

## Error Tracking and Alerting

### Comprehensive Error Tracking

```typescript
// utils/error-tracker.ts
export class ErrorTracker {
  private errorBuffer: ErrorEvent[] = [];
  private errorCounts = new Map<string, number>();
  
  async trackError(error: Error, context?: any) {
    const errorEvent: ErrorEvent = {
      id: this.generateErrorId(),
      message: error.message,
      stack: error.stack,
      name: error.name,
      context,
      timestamp: new Date(),
      fingerprint: this.generateFingerprint(error),
      severity: this.determineSeverity(error, context),
      userId: context?.userId,
      requestId: context?.requestId,
      environment: process.env.NODE_ENV || 'development'
    };
    
    // Update error counts
    const key = errorEvent.fingerprint;
    this.errorCounts.set(key, (this.errorCounts.get(key) || 0) + 1);
    
    // Add to buffer
    this.errorBuffer.push(errorEvent);
    
    // Send to error tracking service
    await this.sendToErrorService(errorEvent);
    
    // Check for alert conditions
    await this.checkAlertConditions(errorEvent);
    
    // Clean up old errors from buffer
    this.cleanupBuffer();
  }
  
  private generateFingerprint(error: Error): string {
    const crypto = require('crypto');
    const input = `${error.name}:${error.message}:${this.getStackFingerprint(error.stack)}`;
    return crypto.createHash('sha256').update(input).digest('hex').substring(0, 16);
  }
  
  private determineSeverity(error: Error, context?: any): 'low' | 'medium' | 'high' | 'critical' {
    // Critical errors that affect core functionality
    if (error.name === 'DatabaseConnectionError' || 
        error.name === 'AuthenticationError' ||
        context?.isPaymentRelated) {
      return 'critical';
    }
    
    // High severity for user-facing errors
    if (error.name === 'ValidationError' || 
        error.name === 'NotFoundError' ||
        context?.affectsUserExperience) {
      return 'high';
    }
    
    // Medium for business logic errors
    if (error.name === 'BusinessLogicError' ||
        context?.isBusinessCritical) {
      return 'medium';
    }
    
    return 'low';
  }
  
  private async checkAlertConditions(errorEvent: ErrorEvent) {
    const fingerprint = errorEvent.fingerprint;
    const count = this.errorCounts.get(fingerprint) || 0;
    
    // Alert on error spikes
    if (count >= 10) {
      await this.sendAlert({
        type: 'error_spike',
        message: `Error spike detected: ${errorEvent.message}`,
        count,
        severity: errorEvent.severity,
        fingerprint
      });
    }
    
    // Alert on critical errors immediately
    if (errorEvent.severity === 'critical') {
      await this.sendAlert({
        type: 'critical_error',
        message: `Critical error: ${errorEvent.message}`,
        severity: 'critical',
        errorEvent
      });
    }
  }
  
  async getErrorSummary(timeRange: TimeRange): Promise<ErrorSummary> {
    const errors = this.getErrorsInRange(timeRange);
    
    const summary = {
      totalErrors: errors.length,
      uniqueErrors: new Set(errors.map(e => e.fingerprint)).size,
      errorsBySeverity: this.groupBySeverity(errors),
      topErrors: this.getTopErrors(errors),
      errorTrends: this.calculateErrorTrends(errors),
      affectedUsers: new Set(errors.map(e => e.userId).filter(Boolean)).size
    };
    
    return summary;
  }
}

interface ErrorEvent {
  id: string;
  message: string;
  stack?: string;
  name: string;
  context?: any;
  timestamp: Date;
  fingerprint: string;
  severity: 'low' | 'medium' | 'high' | 'critical';
  userId?: string;
  requestId?: string;
  environment: string;
}
```

### Smart Alerting System

```typescript
// utils/smart-alerting.ts
export class SmartAlertingSystem {
  private alertRules: AlertRule[] = [];
  private alertHistory = new Map<string, AlertEvent[]>();
  
  constructor() {
    this.setupDefaultRules();
  }
  
  private setupDefaultRules() {
    this.alertRules = [
      {
        id: 'high_error_rate',
        name: 'High Error Rate',
        condition: (metrics: any) => metrics.errorRate > 0.05, // 5%
        severity: 'high',
        cooldown: 300000, // 5 minutes
        escalation: {
          duration: 900000, // 15 minutes
          action: 'escalate_to_oncall'
        }
      },
      {
        id: 'slow_response_time',
        name: 'Slow Response Time',
        condition: (metrics: any) => metrics.p95ResponseTime > 2000, // 2 seconds
        severity: 'medium',
        cooldown: 600000, // 10 minutes
      },
      {
        id: 'database_connection_issues',
        name: 'Database Connection Issues',
        condition: (metrics: any) => metrics.dbConnectionErrors > 5,
        severity: 'critical',
        cooldown: 60000, // 1 minute
        immediateEscalation: true
      },
      {
        id: 'memory_leak_detection',
        name: 'Memory Leak Detection',
        condition: (metrics: any) => 
          metrics.memoryUsage > 0.85 && metrics.memoryTrend === 'increasing',
        severity: 'high',
        cooldown: 1800000, // 30 minutes
      }
    ];
  }
  
  async evaluateAlerts(metrics: SystemMetrics) {
    for (const rule of this.alertRules) {
      if (await this.shouldEvaluateRule(rule)) {
        if (rule.condition(metrics)) {
          await this.triggerAlert(rule, metrics);
        }
      }
    }
  }
  
  private async shouldEvaluateRule(rule: AlertRule): Promise<boolean> {
    const history = this.alertHistory.get(rule.id) || [];
    const lastAlert = history[history.length - 1];
    
    if (!lastAlert) return true;
    
    const timeSinceLastAlert = Date.now() - lastAlert.timestamp.getTime();
    return timeSinceLastAlert > rule.cooldown;
  }
  
  private async triggerAlert(rule: AlertRule, metrics: SystemMetrics) {
    const alertEvent: AlertEvent = {
      id: this.generateAlertId(),
      ruleId: rule.id,
      ruleName: rule.name,
      severity: rule.severity,
      timestamp: new Date(),
      metrics,
      status: 'triggered'
    };
    
    // Record alert
    if (!this.alertHistory.has(rule.id)) {
      this.alertHistory.set(rule.id, []);
    }
    this.alertHistory.get(rule.id)!.push(alertEvent);
    
    // Send alert
    await this.sendAlert(alertEvent);
    
    // Setup escalation if configured
    if (rule.escalation && !rule.immediateEscalation) {
      setTimeout(async () => {
        if (await this.isAlertStillActive(alertEvent)) {
          await this.escalateAlert(alertEvent, rule.escalation!);
        }
      }, rule.escalation.duration);
    } else if (rule.immediateEscalation) {
      await this.escalateAlert(alertEvent, { action: 'immediate_escalation' });
    }
  }
  
  private async sendAlert(alertEvent: AlertEvent) {
    const channels = this.getAlertChannels(alertEvent.severity);
    
    for (const channel of channels) {
      await this.sendToChannel(channel, alertEvent);
    }
  }
  
  private getAlertChannels(severity: AlertSeverity): string[] {
    switch (severity) {
      case 'critical':
        return ['pagerduty', 'slack-critical', 'email-oncall', 'sms-oncall'];
      case 'high':
        return ['slack-alerts', 'email-dev-team'];
      case 'medium':
        return ['slack-monitoring'];
      case 'low':
        return ['slack-monitoring'];
      default:
        return ['slack-monitoring'];
    }
  }
}

interface AlertRule {
  id: string;
  name: string;
  condition: (metrics: any) => boolean;
  severity: AlertSeverity;
  cooldown: number;
  escalation?: {
    duration: number;
    action: string;
  };
  immediateEscalation?: boolean;
}

type AlertSeverity = 'low' | 'medium' | 'high' | 'critical';
```

## Usage Analytics and Insights

### User Behavior Analytics

```typescript
// utils/analytics-tracker.ts
export class AnalyticsTracker {
  private events: AnalyticsEvent[] = [];
  private sessionData = new Map<string, UserSession>();
  
  async trackEvent(
    eventName: string,
    properties: any = {},
    userId?: string,
    sessionId?: string
  ) {
    const event: AnalyticsEvent = {
      id: this.generateEventId(),
      name: eventName,
      properties,
      userId,
      sessionId,
      timestamp: new Date(),
      userAgent: properties.userAgent,
      ipAddress: properties.ipAddress,
      referrer: properties.referrer
    };
    
    this.events.push(event);
    
    // Update session data
    if (sessionId) {
      await this.updateSession(sessionId, event);
    }
    
    // Send to analytics service
    await this.sendToAnalytics(event);
    
    // Check for interesting patterns
    await this.analyzeEventPatterns(event);
  }
  
  async trackPageView(
    path: string,
    userId?: string,
    sessionId?: string,
    properties: any = {}
  ) {
    await this.trackEvent('page_view', {
      path,
      ...properties
    }, userId, sessionId);
  }
  
  async trackUserAction(
    action: string,
    target: string,
    userId?: string,
    sessionId?: string,
    properties: any = {}
  ) {
    await this.trackEvent('user_action', {
      action,
      target,
      ...properties
    }, userId, sessionId);
  }
  
  async getUserJourney(userId: string, timeRange: TimeRange): Promise<UserJourney> {
    const userEvents = this.events.filter(e => 
      e.userId === userId &&
      e.timestamp >= timeRange.start &&
      e.timestamp <= timeRange.end
    ).sort((a, b) => a.timestamp.getTime() - b.timestamp.getTime());
    
    const sessions = this.groupEventsBySessions(userEvents);
    
    return {
      userId,
      timeRange,
      totalSessions: sessions.length,
      totalEvents: userEvents.length,
      sessions: sessions.map(events => this.analyzeSession(events)),
      conversionFunnel: await this.analyzeConversionFunnel(userEvents),
      engagementScore: this.calculateEngagementScore(userEvents)
    };
  }
  
  async getFeatureUsage(timeRange: TimeRange): Promise<FeatureUsageReport> {
    const events = this.getEventsInRange(timeRange);
    const featureEvents = events.filter(e => e.name === 'feature_used');
    
    const usage = featureEvents.reduce((acc, event) => {
      const feature = event.properties.feature;
      if (!acc[feature]) {
        acc[feature] = {
          feature,
          totalUses: 0,
          uniqueUsers: new Set(),
          averageSessionUsage: 0
        };
      }
      
      acc[feature].totalUses++;
      if (event.userId) {
        acc[feature].uniqueUsers.add(event.userId);
      }
      
      return acc;
    }, {} as any);
    
    // Convert Set to size for serialization
    Object.values(usage).forEach((feature: any) => {
      feature.uniqueUsers = feature.uniqueUsers.size;
    });
    
    return {
      timeRange,
      features: Object.values(usage),
      totalFeatureUses: featureEvents.length,
      mostUsedFeatures: Object.values(usage)
        .sort((a: any, b: any) => b.totalUses - a.totalUses)
        .slice(0, 10)
    };
  }
  
  private async analyzeEventPatterns(event: AnalyticsEvent) {
    // Detect unusual patterns
    const recentEvents = this.getRecentEvents(300000); // Last 5 minutes
    
    // Check for rapid successive events (potential bot or error)
    const sameEventCount = recentEvents.filter(e => 
      e.name === event.name && 
      e.userId === event.userId
    ).length;
    
    if (sameEventCount > 20) {
      await this.flagAnomalousActivity({
        type: 'rapid_events',
        userId: event.userId,
        eventName: event.name,
        count: sameEventCount
      });
    }
    
    // Check for conversion events
    if (this.isConversionEvent(event)) {
      await this.recordConversion(event);
    }
  }
}

interface AnalyticsEvent {
  id: string;
  name: string;
  properties: any;
  userId?: string;
  sessionId?: string;
  timestamp: Date;
  userAgent?: string;
  ipAddress?: string;
  referrer?: string;
}
```

### Business Intelligence Dashboard

```typescript
// utils/business-intelligence.ts
export class BusinessIntelligence {
  async generateBusinessReport(timeRange: TimeRange): Promise<BusinessReport> {
    const [
      userMetrics,
      revenueMetrics,
      featureMetrics,
      performanceMetrics
    ] = await Promise.all([
      this.getUserMetrics(timeRange),
      this.getRevenueMetrics(timeRange),
      this.getFeatureMetrics(timeRange),
      this.getPerformanceMetrics(timeRange)
    ]);
    
    return {
      timeRange,
      summary: this.generateSummary({
        userMetrics,
        revenueMetrics,
        featureMetrics,
        performanceMetrics
      }),
      userMetrics,
      revenueMetrics,
      featureMetrics,
      performanceMetrics,
      insights: await this.generateInsights({
        userMetrics,
        revenueMetrics,
        featureMetrics,
        performanceMetrics
      }),
      recommendations: await this.generateRecommendations({
        userMetrics,
        revenueMetrics,
        featureMetrics,
        performanceMetrics
      })
    };
  }
  
  private async getUserMetrics(timeRange: TimeRange): Promise<UserMetrics> {
    return {
      totalUsers: await this.getTotalUsers(timeRange),
      newUsers: await this.getNewUsers(timeRange),
      activeUsers: await this.getActiveUsers(timeRange),
      churnRate: await this.getChurnRate(timeRange),
      retentionRate: await this.getRetentionRate(timeRange),
      userGrowthRate: await this.getUserGrowthRate(timeRange),
      averageSessionDuration: await this.getAverageSessionDuration(timeRange),
      userSegments: await this.getUserSegments(timeRange)
    };
  }
  
  private async generateInsights(data: any): Promise<BusinessInsight[]> {
    const insights: BusinessInsight[] = [];
    
    // User growth insights
    if (data.userMetrics.userGrowthRate > 0.1) {
      insights.push({
        type: 'positive',
        category: 'user_growth',
        title: 'Strong User Growth',
        description: `User growth rate of ${(data.userMetrics.userGrowthRate * 100).toFixed(1)}% indicates healthy product adoption.`,
        impact: 'high',
        confidence: 0.9
      });
    }
    
    // Performance insights
    if (data.performanceMetrics.averageResponseTime > 2000) {
      insights.push({
        type: 'negative',
        category: 'performance',
        title: 'Slow Response Times',
        description: `Average response time of ${data.performanceMetrics.averageResponseTime}ms may be impacting user experience.`,
        impact: 'high',
        confidence: 0.85,
        recommendation: 'Consider optimizing database queries and implementing caching'
      });
    }
    
    // Feature adoption insights
    const lowAdoptionFeatures = data.featureMetrics.features.filter(
      (f: any) => f.adoptionRate < 0.1
    );
    
    if (lowAdoptionFeatures.length > 0) {
      insights.push({
        type: 'warning',
        category: 'feature_adoption',
        title: 'Low Feature Adoption',
        description: `${lowAdoptionFeatures.length} features have adoption rates below 10%.`,
        impact: 'medium',
        confidence: 0.8,
        recommendation: 'Consider improving feature discoverability or removing unused features'
      });
    }
    
    return insights;
  }
  
  async createCustomDashboard(config: DashboardConfig): Promise<Dashboard> {
    const widgets = await Promise.all(
      config.widgets.map(widgetConfig => this.createWidget(widgetConfig))
    );
    
    return {
      id: this.generateDashboardId(),
      name: config.name,
      description: config.description,
      widgets,
      refreshInterval: config.refreshInterval || 300000, // 5 minutes
      createdAt: new Date(),
      lastUpdated: new Date()
    };
  }
  
  private async createWidget(config: WidgetConfig): Promise<DashboardWidget> {
    switch (config.type) {
      case 'metric':
        return await this.createMetricWidget(config);
      case 'chart':
        return await this.createChartWidget(config);
      case 'table':
        return await this.createTableWidget(config);
      case 'gauge':
        return await this.createGaugeWidget(config);
      default:
        throw new Error(`Unknown widget type: ${config.type}`);
    }
  }
}

interface BusinessInsight {
  type: 'positive' | 'negative' | 'warning' | 'neutral';
  category: string;
  title: string;
  description: string;
  impact: 'low' | 'medium' | 'high';
  confidence: number;
  recommendation?: string;
}
```

## Custom Metrics and KPIs

### KPI Tracking System

```typescript
// utils/kpi-tracker.ts
export class KPITracker {
  private kpis = new Map<string, KPI>();
  
  defineKPI(definition: KPIDefinition): void {
    const kpi: KPI = {
      ...definition,
      id: this.generateKPIId(),
      createdAt: new Date(),
      values: [],
      status: 'active'
    };
    
    this.kpis.set(kpi.id, kpi);
  }
  
  async recordKPIValue(
    kpiId: string, 
    value: number, 
    timestamp: Date = new Date(),
    metadata?: any
  ): Promise<void> {
    const kpi = this.kpis.get(kpiId);
    if (!kpi) {
      throw new Error(`KPI not found: ${kpiId}`);
    }
    
    const kpiValue: KPIValue = {
      value,
      timestamp,
      metadata
    };
    
    kpi.values.push(kpiValue);
    kpi.lastUpdated = new Date();
    
    // Keep only recent values to prevent memory issues
    if (kpi.values.length > 10000) {
      kpi.values = kpi.values.slice(-5000);
    }
    
    // Check thresholds
    await this.checkKPIThresholds(kpi, kpiValue);
    
    // Send to metrics store
    await this.storeKPIValue(kpi, kpiValue);
  }
  
  async getKPIReport(
    kpiId: string, 
    timeRange: TimeRange
  ): Promise<KPIReport> {
    const kpi = this.kpis.get(kpiId);
    if (!kpi) {
      throw new Error(`KPI not found: ${kpiId}`);
    }
    
    const values = kpi.values.filter(v => 
      v.timestamp >= timeRange.start && 
      v.timestamp <= timeRange.end
    );
    
    if (values.length === 0) {
      return {
        kpi: kpi.name,
        timeRange,
        noData: true
      };
    }
    
    const numericValues = values.map(v => v.value);
    
    return {
      kpi: kpi.name,
      timeRange,
      currentValue: values[values.length - 1].value,
      averageValue: numericValues.reduce((a, b) => a + b, 0) / numericValues.length,
      minValue: Math.min(...numericValues),
      maxValue: Math.max(...numericValues),
      trend: this.calculateTrend(values),
      thresholdStatus: this.getThresholdStatus(kpi, values[values.length - 1].value),
      dataPoints: values.length,
      percentileValues: {
        p50: this.percentile(numericValues, 0.5),
        p90: this.percentile(numericValues, 0.9),
        p95: this.percentile(numericValues, 0.95),
        p99: this.percentile(numericValues, 0.99)
      }
    };
  }
  
  private async checkKPIThresholds(kpi: KPI, value: KPIValue): Promise<void> {
    if (!kpi.thresholds) return;
    
    const currentValue = value.value;
    
    // Check critical thresholds
    if (kpi.thresholds.critical) {
      const { min, max } = kpi.thresholds.critical;
      if ((min !== undefined && currentValue < min) || 
          (max !== undefined && currentValue > max)) {
        await this.triggerKPIAlert(kpi, value, 'critical');
      }
    }
    
    // Check warning thresholds
    if (kpi.thresholds.warning) {
      const { min, max } = kpi.thresholds.warning;
      if ((min !== undefined && currentValue < min) || 
          (max !== undefined && currentValue > max)) {
        await this.triggerKPIAlert(kpi, value, 'warning');
      }
    }
  }
  
  async generateKPIDashboard(kpiIds: string[]): Promise<KPIDashboard> {
    const kpiReports = await Promise.all(
      kpiIds.map(async id => {
        const timeRange = {
          start: new Date(Date.now() - 24 * 60 * 60 * 1000), // Last 24 hours
          end: new Date()
        };
        return await this.getKPIReport(id, timeRange);
      })
    );
    
    return {
      id: this.generateDashboardId(),
      name: 'KPI Dashboard',
      reports: kpiReports,
      summary: this.generateKPISummary(kpiReports),
      generatedAt: new Date()
    };
  }
}

interface KPIDefinition {
  name: string;
  description: string;
  unit: string;
  category: string;
  calculationMethod: 'sum' | 'average' | 'count' | 'rate' | 'custom';
  thresholds?: {
    warning?: { min?: number; max?: number };
    critical?: { min?: number; max?: number };
  };
  aggregationPeriod: 'minute' | 'hour' | 'day' | 'week' | 'month';
}

interface KPI extends KPIDefinition {
  id: string;
  createdAt: Date;
  lastUpdated?: Date;
  values: KPIValue[];
  status: 'active' | 'inactive' | 'deprecated';
}
```

## Real-time Dashboards

### Live Dashboard System

```typescript
// utils/live-dashboard.ts
export class LiveDashboard {
  private websocketServer: WebSocket.Server;
  private dashboardClients = new Map<string, Set<WebSocket>>();
  private dashboardData = new Map<string, any>();
  
  constructor() {
    this.setupWebSocketServer();
    this.startDataRefreshLoop();
  }
  
  private setupWebSocketServer() {
    this.websocketServer = new WebSocket.Server({ 
      port: process.env.DASHBOARD_WS_PORT || 8080 
    });
    
    this.websocketServer.on('connection', (ws, request) => {
      const dashboardId = this.extractDashboardId(request.url);
      
      if (!dashboardId) {
        ws.close(1008, 'Invalid dashboard ID');
        return;
      }
      
      this.addClient(dashboardId, ws);
      
      // Send current data immediately
      const currentData = this.dashboardData.get(dashboardId);
      if (currentData) {
        ws.send(JSON.stringify({
          type: 'data_update',
          data: currentData
        }));
      }
      
      ws.on('close', () => {
        this.removeClient(dashboardId, ws);
      });
      
      ws.on('message', (message) => {
        this.handleClientMessage(dashboardId, ws, message);
      });
    });
  }
  
  private startDataRefreshLoop() {
    setInterval(async () => {
      for (const dashboardId of this.dashboardClients.keys()) {
        try {
          const newData = await this.fetchDashboardData(dashboardId);
          const currentData = this.dashboardData.get(dashboardId);
          
          // Only broadcast if data has changed
          if (!this.isDataEqual(currentData, newData)) {
            this.dashboardData.set(dashboardId, newData);
            this.broadcastToClients(dashboardId, {
              type: 'data_update',
              data: newData,
              timestamp: new Date()
            });
          }
        } catch (error) {
          console.error(`Failed to refresh dashboard ${dashboardId}:`, error);
          this.broadcastToClients(dashboardId, {
            type: 'error',
            message: 'Failed to refresh dashboard data'
          });
        }
      }
    }, 5000); // Refresh every 5 seconds
  }
  
  async createRealtimeDashboard(config: DashboardConfig): Promise<RealtimeDashboard> {
    const dashboard: RealtimeDashboard = {
      id: this.generateDashboardId(),
      name: config.name,
      widgets: await this.createDashboardWidgets(config.widgets),
      refreshInterval: config.refreshInterval || 5000,
      filters: config.filters || {},
      layout: config.layout,
      permissions: config.permissions,
      createdAt: new Date()
    };
    
    // Initialize data for this dashboard
    this.dashboardData.set(dashboard.id, {});
    this.dashboardClients.set(dashboard.id, new Set());
    
    return dashboard;
  }
  
  private async fetchDashboardData(dashboardId: string): Promise<any> {
    // This would fetch real-time data based on dashboard configuration
    const data = {
      systemMetrics: await this.getSystemMetrics(),
      applicationMetrics: await this.getApplicationMetrics(),
      businessMetrics: await this.getBusinessMetrics(),
      alerts: await this.getActiveAlerts(),
      logs: await this.getRecentLogs(100)
    };
    
    return data;
  }
  
  private broadcastToClients(dashboardId: string, message: any) {
    const clients = this.dashboardClients.get(dashboardId);
    if (!clients) return;
    
    const messageString = JSON.stringify(message);
    
    clients.forEach(client => {
      if (client.readyState === WebSocket.OPEN) {
        client.send(messageString);
      }
    });
  }
  
  async getSystemHealth(): Promise<SystemHealthStatus> {
    const [
      cpuUsage,
      memoryUsage,
      diskUsage,
      networkStats,
      serviceStatus
    ] = await Promise.all([
      this.getCPUUsage(),
      this.getMemoryUsage(),
      this.getDiskUsage(),
      this.getNetworkStats(),
      this.getServiceStatus()
    ]);
    
    const overallHealth = this.calculateOverallHealth({
      cpuUsage,
      memoryUsage,
      diskUsage,
      networkStats,
      serviceStatus
    });
    
    return {
      overall: overallHealth,
      cpu: cpuUsage,
      memory: memoryUsage,
      disk: diskUsage,
      network: networkStats,
      services: serviceStatus,
      timestamp: new Date()
    };
  }
}

interface RealtimeDashboard {
  id: string;
  name: string;
  widgets: DashboardWidget[];
  refreshInterval: number;
  filters: any;
  layout: DashboardLayout;
  permissions: DashboardPermissions;
  createdAt: Date;
}
```

## Best Practices

### Monitoring Strategy

1. **Define Clear SLIs/SLOs**: Establish service level indicators and objectives
2. **Monitor User Experience**: Track real user metrics, not just synthetic tests
3. **Alert on Symptoms**: Alert on user-facing issues, not just system metrics
4. **Reduce Alert Fatigue**: Implement smart alerting with proper thresholds
5. **Regular Review**: Periodically review and update monitoring strategies

### Performance Optimization

1. **Collect Meaningful Metrics**: Focus on metrics that drive business decisions
2. **Implement Distributed Tracing**: Track requests across service boundaries
3. **Use Sampling**: Sample high-volume events to reduce monitoring overhead
4. **Archive Old Data**: Implement data retention policies for cost management

### Security and Privacy

1. **Sanitize Logs**: Remove sensitive data from logs and metrics
2. **Access Control**: Implement proper access controls for monitoring data
3. **Data Encryption**: Encrypt monitoring data in transit and at rest
4. **Compliance**: Ensure monitoring practices comply with regulations

---

[← Back to Multi-environment Setup](environments.md) | [Back to Advanced Topics](index.md)