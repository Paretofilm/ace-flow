# Simple CRUD Architecture Pattern

**Straightforward architecture pattern for basic data management applications with AWS Amplify Gen 2 and Next.js.**

## 🎯 Pattern Overview

### What This Pattern Provides
The Simple CRUD pattern is perfect for applications that primarily need to Create, Read, Update, and Delete data with a clean, straightforward interface. It's designed for applications where users manage records, tasks, or basic business data without complex relationships or real-time requirements.

### Core Characteristics
- **Data-Centric Design**: Focus on efficient data entry and management
- **Simple UI Patterns**: Forms, lists, and detail views
- **Basic Authentication**: User accounts with role-based permissions
- **Straightforward Workflows**: Clear, linear user journeys
- **Minimal Complexity**: Easy to understand, maintain, and extend

## 🏗️ Architecture Components

### High-Level Architecture
```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Next.js App   │    │  Amplify Gen 2   │    │  AWS Services   │
│                 │    │                  │    │                 │
│ • List Views    │◄──►│ • GraphQL API    │◄──►│ • Cognito       │
│ • Create Forms  │    │ • CRUD Operations│    │ • DynamoDB      │
│ • Edit Forms    │    │ • Auth Rules     │    │ • S3 (optional) │
│ • Detail Views  │    │ • Data Models    │    │                 │
│ • User Auth     │    │ • Validation     │    │                 │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

### Key Components

#### 1. Core Data Models
```typescript
// Example: Task Management Application
interface Task {
  id: string;
  title: string;
  description?: string;
  status: 'todo' | 'in-progress' | 'completed';
  priority: 'low' | 'medium' | 'high';
  dueDate?: Date;
  assignedTo?: string;
  createdBy: string;
  createdAt: Date;
  updatedAt: Date;
}

// Example: Contact Management
interface Contact {
  id: string;
  firstName: string;
  lastName: string;
  email: string;
  phone?: string;
  company?: string;
  notes?: string;
  tags: string[];
  createdAt: Date;
  updatedAt: Date;
}
```

#### 2. Standard CRUD Operations
```typescript
// Basic CRUD service pattern
interface CRUDService<T> {
  create(data: Omit<T, 'id' | 'createdAt' | 'updatedAt'>): Promise<T>;
  read(id: string): Promise<T | null>;
  update(id: string, data: Partial<T>): Promise<T>;
  delete(id: string): Promise<boolean>;
  list(filters?: any, pagination?: any): Promise<T[]>;
}
```

## 📊 Data Modeling Strategy

### Basic Data Schema
```typescript
// amplify/data/resource.ts
import { type ClientSchema, a } from '@aws-amplify/backend';

const schema = a.schema({
  Task: a
    .model({
      title: a.string().required(),
      description: a.string(),
      status: a.enum(['todo', 'in-progress', 'completed']).default('todo'),
      priority: a.enum(['low', 'medium', 'high']).default('medium'),
      dueDate: a.date(),
      assignedTo: a.string(),
      tags: a.string().array(),
      isCompleted: a.boolean().default(false),
      completedAt: a.datetime(),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update', 'delete']),
      allow.authenticated().to(['read']),
    ]),

  Category: a
    .model({
      name: a.string().required(),
      description: a.string(),
      color: a.string(),
      isActive: a.boolean().default(true),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update', 'delete']),
      allow.authenticated().to(['read']),
    ]),

  Contact: a
    .model({
      firstName: a.string().required(),
      lastName: a.string().required(),
      email: a.email().required(),
      phone: a.phone(),
      company: a.string(),
      position: a.string(),
      notes: a.string(),
      tags: a.string().array(),
      isActive: a.boolean().default(true),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update', 'delete']),
    ]),
});

export type Schema = ClientSchema<typeof schema>;
```

### Relationships and Validation
```typescript
// Extended schema with relationships
const extendedSchema = a.schema({
  Project: a
    .model({
      name: a.string().required(),
      description: a.string(),
      status: a.enum(['active', 'on-hold', 'completed', 'cancelled']).default('active'),
      startDate: a.date(),
      endDate: a.date(),
      budget: a.float(),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update', 'delete']),
      allow.authenticated().to(['read']),
    ]),

  Task: a
    .model({
      title: a.string().required(),
      description: a.string(),
      status: a.enum(['todo', 'in-progress', 'completed']).default('todo'),
      priority: a.enum(['low', 'medium', 'high']).default('medium'),
      dueDate: a.date(),
      estimatedHours: a.float(),
      actualHours: a.float(),
      
      // Relationship to Project
      projectId: a.id(),
      project: a.belongsTo('Project', 'projectId'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update', 'delete']),
      allow.authenticated().to(['read']),
    ]),
});
```

## 🎨 User Interface Implementation

### List View Component
```typescript
// components/TaskList.tsx
'use client';

import { useState, useEffect } from 'react';
import { generateClient } from 'aws-amplify/data';
import type { Schema } from '@/amplify/data/resource';

const client = generateClient<Schema>();

export function TaskList() {
  const [tasks, setTasks] = useState<Schema['Task']['type'][]>([]);
  const [loading, setLoading] = useState(true);
  const [filter, setFilter] = useState<'all' | 'todo' | 'in-progress' | 'completed'>('all');

  useEffect(() => {
    fetchTasks();
  }, [filter]);

  const fetchTasks = async () => {
    try {
      setLoading(true);
      const filterCondition = filter === 'all' ? {} : { status: { eq: filter } };
      
      const result = await client.models.Task.list({
        filter: filterCondition,
        sort: { field: 'createdAt', direction: 'desc' },
      });
      
      setTasks(result.data);
    } catch (error) {
      console.error('Error fetching tasks:', error);
    } finally {
      setLoading(false);
    }
  };

  const deleteTask = async (id: string) => {
    if (!confirm('Are you sure you want to delete this task?')) return;
    
    try {
      await client.models.Task.delete({ id });
      setTasks(prev => prev.filter(task => task.id !== id));
    } catch (error) {
      console.error('Error deleting task:', error);
    }
  };

  const toggleTaskStatus = async (id: string, currentStatus: string) => {
    const newStatus = currentStatus === 'completed' ? 'todo' : 'completed';
    
    try {
      await client.models.Task.update({
        id,
        status: newStatus,
        completedAt: newStatus === 'completed' ? new Date().toISOString() : null,
      });
      
      setTasks(prev => prev.map(task => 
        task.id === id 
          ? { ...task, status: newStatus }
          : task
      ));
    } catch (error) {
      console.error('Error updating task status:', error);
    }
  };

  if (loading) return <div className="loading">Loading tasks...</div>;

  return (
    <div className="task-list-container">
      <div className="task-list-header">
        <h2>Tasks</h2>
        <div className="filters">
          <button 
            className={filter === 'all' ? 'active' : ''}
            onClick={() => setFilter('all')}
          >
            All
          </button>
          <button 
            className={filter === 'todo' ? 'active' : ''}
            onClick={() => setFilter('todo')}
          >
            To Do
          </button>
          <button 
            className={filter === 'in-progress' ? 'active' : ''}
            onClick={() => setFilter('in-progress')}
          >
            In Progress
          </button>
          <button 
            className={filter === 'completed' ? 'active' : ''}
            onClick={() => setFilter('completed')}
          >
            Completed
          </button>
        </div>
        <a href="/tasks/new" className="btn-primary">Add Task</a>
      </div>

      <div className="task-list">
        {tasks.length === 0 ? (
          <div className="empty-state">
            <p>No tasks found</p>
            <a href="/tasks/new" className="btn-secondary">Create your first task</a>
          </div>
        ) : (
          tasks.map(task => (
            <div key={task.id} className={`task-item ${task.status}`}>
              <div className="task-main">
                <div className="task-checkbox">
                  <input
                    type="checkbox"
                    checked={task.status === 'completed'}
                    onChange={() => toggleTaskStatus(task.id, task.status)}
                  />
                </div>
                <div className="task-content">
                  <h3 className="task-title">{task.title}</h3>
                  {task.description && (
                    <p className="task-description">{task.description}</p>
                  )}
                  <div className="task-meta">
                    <span className={`priority ${task.priority}`}>
                      {task.priority}
                    </span>
                    {task.dueDate && (
                      <span className="due-date">
                        Due: {new Date(task.dueDate).toLocaleDateString()}
                      </span>
                    )}
                  </div>
                </div>
              </div>
              <div className="task-actions">
                <a href={`/tasks/${task.id}/edit`} className="btn-edit">
                  Edit
                </a>
                <button 
                  onClick={() => deleteTask(task.id)}
                  className="btn-delete"
                >
                  Delete
                </button>
              </div>
            </div>
          ))
        )}
      </div>
    </div>
  );
}
```

### Create/Edit Form Component
```typescript
// components/TaskForm.tsx
'use client';

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';

interface TaskFormData {
  title: string;
  description: string;
  status: 'todo' | 'in-progress' | 'completed';
  priority: 'low' | 'medium' | 'high';
  dueDate: string;
  assignedTo: string;
}

export function TaskForm({ taskId }: { taskId?: string }) {
  const router = useRouter();
  const [formData, setFormData] = useState<TaskFormData>({
    title: '',
    description: '',
    status: 'todo',
    priority: 'medium',
    dueDate: '',
    assignedTo: '',
  });
  const [loading, setLoading] = useState(false);
  const [errors, setErrors] = useState<Record<string, string>>({});

  useEffect(() => {
    if (taskId) {
      fetchTask(taskId);
    }
  }, [taskId]);

  const fetchTask = async (id: string) => {
    try {
      const result = await client.models.Task.get({ id });
      if (result.data) {
        setFormData({
          title: result.data.title,
          description: result.data.description || '',
          status: result.data.status,
          priority: result.data.priority,
          dueDate: result.data.dueDate || '',
          assignedTo: result.data.assignedTo || '',
        });
      }
    } catch (error) {
      console.error('Error fetching task:', error);
    }
  };

  const validateForm = (): boolean => {
    const newErrors: Record<string, string> = {};

    if (!formData.title.trim()) {
      newErrors.title = 'Title is required';
    }

    if (formData.dueDate && new Date(formData.dueDate) < new Date()) {
      newErrors.dueDate = 'Due date cannot be in the past';
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!validateForm()) return;

    setLoading(true);
    try {
      if (taskId) {
        // Update existing task
        await client.models.Task.update({
          id: taskId,
          ...formData,
          dueDate: formData.dueDate || null,
          assignedTo: formData.assignedTo || null,
        });
      } else {
        // Create new task
        await client.models.Task.create({
          ...formData,
          dueDate: formData.dueDate || null,
          assignedTo: formData.assignedTo || null,
        });
      }
      
      router.push('/tasks');
    } catch (error) {
      console.error('Error saving task:', error);
      setErrors({ submit: 'Failed to save task. Please try again.' });
    } finally {
      setLoading(false);
    }
  };

  const handleInputChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>
  ) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
    
    // Clear error when user starts typing
    if (errors[name]) {
      setErrors(prev => ({ ...prev, [name]: '' }));
    }
  };

  return (
    <div className="task-form-container">
      <h2>{taskId ? 'Edit Task' : 'Create New Task'}</h2>
      
      <form onSubmit={handleSubmit} className="task-form">
        <div className="form-group">
          <label htmlFor="title">Title *</label>
          <input
            type="text"
            id="title"
            name="title"
            value={formData.title}
            onChange={handleInputChange}
            className={errors.title ? 'error' : ''}
            required
          />
          {errors.title && <span className="error-message">{errors.title}</span>}
        </div>

        <div className="form-group">
          <label htmlFor="description">Description</label>
          <textarea
            id="description"
            name="description"
            value={formData.description}
            onChange={handleInputChange}
            rows={4}
          />
        </div>

        <div className="form-row">
          <div className="form-group">
            <label htmlFor="status">Status</label>
            <select
              id="status"
              name="status"
              value={formData.status}
              onChange={handleInputChange}
            >
              <option value="todo">To Do</option>
              <option value="in-progress">In Progress</option>
              <option value="completed">Completed</option>
            </select>
          </div>

          <div className="form-group">
            <label htmlFor="priority">Priority</label>
            <select
              id="priority"
              name="priority"
              value={formData.priority}
              onChange={handleInputChange}
            >
              <option value="low">Low</option>
              <option value="medium">Medium</option>
              <option value="high">High</option>
            </select>
          </div>
        </div>

        <div className="form-row">
          <div className="form-group">
            <label htmlFor="dueDate">Due Date</label>
            <input
              type="date"
              id="dueDate"
              name="dueDate"
              value={formData.dueDate}
              onChange={handleInputChange}
              className={errors.dueDate ? 'error' : ''}
            />
            {errors.dueDate && <span className="error-message">{errors.dueDate}</span>}
          </div>

          <div className="form-group">
            <label htmlFor="assignedTo">Assigned To</label>
            <input
              type="text"
              id="assignedTo"
              name="assignedTo"
              value={formData.assignedTo}
              onChange={handleInputChange}
              placeholder="Enter username or email"
            />
          </div>
        </div>

        {errors.submit && (
          <div className="error-message submit-error">{errors.submit}</div>
        )}

        <div className="form-actions">
          <button 
            type="button" 
            onClick={() => router.push('/tasks')}
            className="btn-secondary"
          >
            Cancel
          </button>
          <button 
            type="submit" 
            disabled={loading}
            className="btn-primary"
          >
            {loading ? 'Saving...' : taskId ? 'Update Task' : 'Create Task'}
          </button>
        </div>
      </form>
    </div>
  );
}
```

### Detail View Component
```typescript
// components/TaskDetail.tsx
export function TaskDetail({ taskId }: { taskId: string }) {
  const [task, setTask] = useState<Schema['Task']['type'] | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchTask();
  }, [taskId]);

  const fetchTask = async () => {
    try {
      const result = await client.models.Task.get({ id: taskId });
      setTask(result.data);
    } catch (error) {
      console.error('Error fetching task:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) return <div className="loading">Loading task...</div>;
  if (!task) return <div className="error">Task not found</div>;

  return (
    <div className="task-detail">
      <div className="task-header">
        <h1>{task.title}</h1>
        <div className="task-actions">
          <a href={`/tasks/${task.id}/edit`} className="btn-primary">
            Edit Task
          </a>
          <a href="/tasks" className="btn-secondary">
            Back to List
          </a>
        </div>
      </div>

      <div className="task-content">
        <div className="task-meta">
          <div className="meta-item">
            <label>Status:</label>
            <span className={`status ${task.status}`}>
              {task.status.replace('-', ' ').toUpperCase()}
            </span>
          </div>
          
          <div className="meta-item">
            <label>Priority:</label>
            <span className={`priority ${task.priority}`}>
              {task.priority.toUpperCase()}
            </span>
          </div>

          {task.dueDate && (
            <div className="meta-item">
              <label>Due Date:</label>
              <span>{new Date(task.dueDate).toLocaleDateString()}</span>
            </div>
          )}

          {task.assignedTo && (
            <div className="meta-item">
              <label>Assigned To:</label>
              <span>{task.assignedTo}</span>
            </div>
          )}

          <div className="meta-item">
            <label>Created:</label>
            <span>{new Date(task.createdAt).toLocaleDateString()}</span>
          </div>

          <div className="meta-item">
            <label>Last Updated:</label>
            <span>{new Date(task.updatedAt).toLocaleDateString()}</span>
          </div>
        </div>

        {task.description && (
          <div className="task-description">
            <h3>Description</h3>
            <p>{task.description}</p>
          </div>
        )}
      </div>
    </div>
  );
}
```

## 🔐 Authentication & Authorization

### Simple User Roles
```typescript
// Simple role-based access control
const authRules = {
  // Users can manage their own records
  owner: allow.owner().to(['create', 'read', 'update', 'delete']),
  
  // Authenticated users can read shared records
  authenticated: allow.authenticated().to(['read']),
  
  // Admin users can manage all records
  admin: allow.groups(['admin']).to(['create', 'read', 'update', 'delete']),
};

// Usage in schema
const schema = a.schema({
  Task: a
    .model({
      // ... task fields
    })
    .authorization(allow => [
      allow.owner(),
      allow.groups(['admin']),
    ]),
});
```

### User Authentication Setup
```typescript
// lib/auth.ts
import { getCurrentUser, signIn, signOut, signUp } from 'aws-amplify/auth';

export const authService = {
  async signUp(username: string, password: string, email: string) {
    try {
      const result = await signUp({
        username,
        password,
        options: {
          userAttributes: {
            email,
          },
        },
      });
      return result;
    } catch (error) {
      console.error('Sign up error:', error);
      throw error;
    }
  },

  async signIn(username: string, password: string) {
    try {
      const result = await signIn({ username, password });
      return result;
    } catch (error) {
      console.error('Sign in error:', error);
      throw error;
    }
  },

  async signOut() {
    try {
      await signOut();
    } catch (error) {
      console.error('Sign out error:', error);
      throw error;
    }
  },

  async getCurrentUser() {
    try {
      const user = await getCurrentUser();
      return user;
    } catch (error) {
      return null;
    }
  },
};
```

## ⚡ Performance & Optimization

### Data Caching
```typescript
// Simple caching strategy
export class CacheService {
  private cache = new Map<string, { data: any; timestamp: number }>();
  private ttl = 5 * 60 * 1000; // 5 minutes

  get<T>(key: string): T | null {
    const cached = this.cache.get(key);
    if (!cached) return null;

    if (Date.now() - cached.timestamp > this.ttl) {
      this.cache.delete(key);
      return null;
    }

    return cached.data;
  }

  set<T>(key: string, data: T): void {
    this.cache.set(key, {
      data,
      timestamp: Date.now(),
    });
  }

  clear(): void {
    this.cache.clear();
  }
}

// Usage in data service
export class TaskService {
  private cache = new CacheService();

  async getTasks(): Promise<Schema['Task']['type'][]> {
    const cacheKey = 'tasks';
    const cached = this.cache.get<Schema['Task']['type'][]>(cacheKey);
    
    if (cached) {
      return cached;
    }

    const result = await client.models.Task.list();
    this.cache.set(cacheKey, result.data);
    return result.data;
  }
}
```

### Pagination
```typescript
// Pagination component
export function usePagination<T>(
  fetchFunction: (nextToken?: string) => Promise<{ data: T[]; nextToken?: string }>,
  pageSize: number = 20
) {
  const [items, setItems] = useState<T[]>([]);
  const [loading, setLoading] = useState(false);
  const [hasMore, setHasMore] = useState(true);
  const [nextToken, setNextToken] = useState<string | undefined>();

  const loadPage = async (reset = false) => {
    if (loading) return;
    
    setLoading(true);
    try {
      const result = await fetchFunction(reset ? undefined : nextToken);
      
      setItems(prev => reset ? result.data : [...prev, ...result.data]);
      setNextToken(result.nextToken);
      setHasMore(!!result.nextToken);
    } catch (error) {
      console.error('Error loading page:', error);
    } finally {
      setLoading(false);
    }
  };

  const reset = () => {
    setItems([]);
    setNextToken(undefined);
    setHasMore(true);
    loadPage(true);
  };

  return {
    items,
    loading,
    hasMore,
    loadMore: () => loadPage(),
    reset,
  };
}
```

## 🔐 Security

### Data Protection & Validation

#### Input Validation & Sanitization
```typescript
// Input validation service
export class ValidationService {
  static validateTask(taskData: Partial<Task>): ValidationResult {
    const errors: string[] = [];

    // Required field validation
    if (!taskData.title?.trim()) {
      errors.push('Title is required');
    }

    // Input sanitization
    if (taskData.title && taskData.title.length > 200) {
      errors.push('Title must be less than 200 characters');
    }

    // Sanitize HTML content
    if (taskData.description) {
      taskData.description = this.sanitizeHtml(taskData.description);
    }

    // Date validation
    if (taskData.dueDate && new Date(taskData.dueDate) < new Date()) {
      errors.push('Due date cannot be in the past');
    }

    return {
      isValid: errors.length === 0,
      errors,
      sanitizedData: taskData
    };
  }

  private static sanitizeHtml(input: string): string {
    // Remove potentially dangerous HTML tags and scripts
    return input
      .replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, '')
      .replace(/<iframe\b[^<]*(?:(?!<\/iframe>)<[^<]*)*<\/iframe>/gi, '')
      .replace(/javascript:/gi, '')
      .replace(/on\w+="[^"]*"/gi, '');
  }
}
```

#### SQL Injection Prevention
```typescript
// Safe query patterns with Amplify GraphQL
export class SecureDataService {
  // ✅ Safe: Using Amplify's parameterized queries
  async getTasksByUser(userId: string): Promise<Task[]> {
    const result = await client.models.Task.list({
      filter: {
        owner: { eq: userId } // Amplify handles parameterization
      }
    });
    return result.data;
  }

  // ✅ Safe: Input validation before queries
  async searchTasks(searchTerm: string): Promise<Task[]> {
    // Validate and sanitize search input
    const sanitizedTerm = searchTerm
      .replace(/[^\w\s-]/g, '') // Only allow alphanumeric, spaces, hyphens
      .trim()
      .substring(0, 100); // Limit length

    if (!sanitizedTerm) {
      return [];
    }

    const result = await client.models.Task.list({
      filter: {
        title: { contains: sanitizedTerm }
      }
    });
    return result.data;
  }
}
```

### Authentication & Session Security

#### Secure Authentication Flow
```typescript
// Secure auth implementation
export class SecureAuthService {
  // Multi-factor authentication setup
  async enableMFA(userId: string): Promise<void> {
    try {
      await updateUserAttributes({
        userAttributes: {
          phone_number: '+1234567890', // User's verified phone
        }
      });

      // Enable TOTP MFA
      await setUpTOTP();
    } catch (error) {
      console.error('MFA setup failed:', error);
      throw new Error('Unable to enable MFA');
    }
  }

  // Secure password requirements
  validatePassword(password: string): ValidationResult {
    const requirements = {
      minLength: password.length >= 12,
      hasUppercase: /[A-Z]/.test(password),
      hasLowercase: /[a-z]/.test(password),
      hasNumbers: /\d/.test(password),
      hasSpecialChars: /[!@#$%^&*(),.?":{}|<>]/.test(password),
      notCommon: !this.isCommonPassword(password)
    };

    const passed = Object.values(requirements).every(req => req);
    
    return {
      isValid: passed,
      requirements,
      errors: passed ? [] : ['Password does not meet security requirements']
    };
  }

  // Session timeout handling
  setupSessionTimeout(): void {
    const TIMEOUT_MINUTES = 30;
    let timeoutId: NodeJS.Timeout;

    const resetTimeout = () => {
      clearTimeout(timeoutId);
      timeoutId = setTimeout(() => {
        this.handleSessionTimeout();
      }, TIMEOUT_MINUTES * 60 * 1000);
    };

    // Reset timeout on user activity
    ['mousedown', 'mousemove', 'keypress', 'scroll', 'touchstart'].forEach(event => {
      document.addEventListener(event, resetTimeout, true);
    });

    resetTimeout();
  }

  private async handleSessionTimeout(): Promise<void> {
    await signOut();
    window.location.href = '/login?reason=timeout';
  }
}
```

### Data Security & Encryption

#### Client-Side Data Protection
```typescript
// Sensitive data handling
export class DataSecurityService {
  // Encrypt sensitive data before storage
  async encryptSensitiveData(data: string, keyId: string): Promise<string> {
    const key = await this.getEncryptionKey(keyId);
    const encrypted = await crypto.subtle.encrypt(
      { name: 'AES-GCM', iv: crypto.getRandomValues(new Uint8Array(12)) },
      key,
      new TextEncoder().encode(data)
    );
    return btoa(String.fromCharCode(...new Uint8Array(encrypted)));
  }

  // Secure local storage handling
  setSecureItem(key: string, value: any): void {
    const encrypted = this.encrypt(JSON.stringify(value));
    sessionStorage.setItem(key, encrypted); // Use sessionStorage for sensitive data
  }

  getSecureItem(key: string): any {
    const encrypted = sessionStorage.getItem(key);
    if (!encrypted) return null;
    
    try {
      const decrypted = this.decrypt(encrypted);
      return JSON.parse(decrypted);
    } catch {
      // Remove corrupted data
      sessionStorage.removeItem(key);
      return null;
    }
  }

  // Clear sensitive data on logout
  clearSensitiveData(): void {
    const sensitiveKeys = ['userPreferences', 'tempFormData', 'searchHistory'];
    sensitiveKeys.forEach(key => {
      sessionStorage.removeItem(key);
      localStorage.removeItem(key);
    });
  }
}
```

### Authorization & Access Control

#### Role-Based Access Control (RBAC)
```typescript
// Enhanced authorization rules
const securitySchema = a.schema({
  Task: a
    .model({
      title: a.string().required(),
      description: a.string(),
      status: a.enum(['todo', 'in-progress', 'completed']),
      priority: a.enum(['low', 'medium', 'high']),
      isPublic: a.boolean().default(false),
      // Add security fields
      classification: a.enum(['public', 'internal', 'confidential']).default('internal'),
      lastAccessedAt: a.datetime(),
      accessCount: a.integer().default(0),
    })
    .authorization(allow => [
      // Owner can do everything with their tasks
      allow.owner().to(['create', 'read', 'update', 'delete']),
      
      // Authenticated users can only read public tasks
      allow.authenticated().to(['read']).where(task => 
        task.isPublic === true && task.classification === 'public'
      ),
      
      // Admins can read all but not delete
      allow.groups(['admin']).to(['read', 'update']),
      
      // Moderators can read and update inappropriate content
      allow.groups(['moderator']).to(['read', 'update']).where(task =>
        task.classification !== 'confidential'
      ),
    ]),

  // Audit log for security monitoring
  AccessLog: a
    .model({
      userId: a.id().required(),
      action: a.enum(['create', 'read', 'update', 'delete']).required(),
      resourceType: a.string().required(),
      resourceId: a.id().required(),
      ipAddress: a.string(),
      userAgent: a.string(),
      success: a.boolean().required(),
      errorMessage: a.string(),
    })
    .authorization(allow => [
      // Only system can create audit logs
      allow.resource(accessLog => accessLog).to(['create']),
      // Admins can read audit logs
      allow.groups(['admin']).to(['read']),
    ]),
});
```

#### Permission Validation
```typescript
// Runtime permission checking
export class PermissionService {
  async canUserAccessTask(userId: string, taskId: string, action: string): Promise<boolean> {
    try {
      // Get task with owner info
      const task = await client.models.Task.get({ id: taskId });
      if (!task.data) return false;

      // Get user groups
      const user = await getCurrentUser();
      const groups = user.signInUserSession?.accessToken?.payload['cognito:groups'] || [];

      // Check ownership
      if (task.data.owner === userId) {
        return true;
      }

      // Check admin/moderator permissions
      if (groups.includes('admin')) {
        return ['read', 'update'].includes(action);
      }

      if (groups.includes('moderator')) {
        return ['read', 'update'].includes(action) && 
               task.data.classification !== 'confidential';
      }

      // Check public access for read operations
      if (action === 'read' && task.data.isPublic && task.data.classification === 'public') {
        return true;
      }

      return false;
    } catch (error) {
      // Log security event
      await this.logSecurityEvent(userId, 'permission_check_failed', { taskId, action, error });
      return false;
    }
  }

  private async logSecurityEvent(userId: string, event: string, metadata: any): Promise<void> {
    try {
      await client.models.AccessLog.create({
        userId,
        action: 'security_event',
        resourceType: 'permission',
        resourceId: event,
        success: false,
        errorMessage: JSON.stringify(metadata),
      });
    } catch (error) {
      // Fallback logging to console if audit log fails
      console.error('Security event logging failed:', { userId, event, metadata, error });
    }
  }
}
```

### Security Monitoring & Compliance

#### Security Headers & CSP
```typescript
// Content Security Policy configuration
export const securityHeaders = {
  'Content-Security-Policy': [
    "default-src 'self'",
    "script-src 'self' 'unsafe-inline' https://cognito-idp.*.amazonaws.com",
    "style-src 'self' 'unsafe-inline'",
    "img-src 'self' data: https:",
    "connect-src 'self' https://*.amazonaws.com wss://*.amazonaws.com",
    "font-src 'self'",
    "object-src 'none'",
    "media-src 'self'",
    "frame-src 'none'"
  ].join('; '),
  
  'X-Content-Type-Options': 'nosniff',
  'X-Frame-Options': 'DENY',
  'X-XSS-Protection': '1; mode=block',
  'Referrer-Policy': 'strict-origin-when-cross-origin',
  'Permissions-Policy': 'geolocation=(), microphone=(), camera=()'
};
```

#### Security Event Monitoring
```typescript
// Security monitoring service
export class SecurityMonitor {
  private failedAttempts = new Map<string, number>();
  private readonly MAX_FAILED_ATTEMPTS = 5;
  private readonly LOCKOUT_DURATION = 15 * 60 * 1000; // 15 minutes

  async trackFailedLogin(identifier: string): Promise<boolean> {
    const attempts = this.failedAttempts.get(identifier) || 0;
    const newAttempts = attempts + 1;
    
    this.failedAttempts.set(identifier, newAttempts);
    
    // Auto-lockout after max attempts
    if (newAttempts >= this.MAX_FAILED_ATTEMPTS) {
      await this.lockoutUser(identifier);
      return true; // Account locked
    }
    
    return false; // Not locked yet
  }

  async isAccountLocked(identifier: string): Promise<boolean> {
    // Check if account is currently locked
    const lockoutData = await this.getLockoutData(identifier);
    if (lockoutData && Date.now() < lockoutData.unlockTime) {
      return true;
    }
    
    // Clear expired lockout
    if (lockoutData) {
      await this.clearLockout(identifier);
    }
    
    return false;
  }

  private async lockoutUser(identifier: string): Promise<void> {
    const unlockTime = Date.now() + this.LOCKOUT_DURATION;
    
    // Store lockout info (in production, use database)
    await this.storeLockoutData(identifier, unlockTime);
    
    // Notify administrators of security event
    await this.notifySecurityTeam('account_lockout', { identifier, unlockTime });
  }

  // Detect suspicious patterns
  async detectAnomalies(userId: string, action: string): Promise<void> {
    const recentActions = await this.getRecentActions(userId, 1000 * 60 * 10); // 10 minutes
    
    // Detect rapid-fire requests
    if (recentActions.length > 100) {
      await this.flagSuspiciousActivity(userId, 'rapid_requests', { count: recentActions.length });
    }
    
    // Detect unusual access patterns
    const actionsByType = recentActions.reduce((acc, action) => {
      acc[action.type] = (acc[action.type] || 0) + 1;
      return acc;
    }, {});
    
    if (actionsByType.delete > 10) {
      await this.flagSuspiciousActivity(userId, 'mass_deletion', actionsByType);
    }
  }
}
```

### Security Best Practices Checklist

#### Development Security
- [ ] **Input Validation**: All user inputs validated and sanitized
- [ ] **Output Encoding**: All dynamic content properly encoded
- [ ] **SQL Injection**: Using parameterized queries only
- [ ] **XSS Prevention**: Content Security Policy implemented
- [ ] **CSRF Protection**: Anti-CSRF tokens on state-changing operations
- [ ] **Authentication**: Strong password policies and MFA enabled
- [ ] **Authorization**: Proper access controls on all resources
- [ ] **Session Security**: Secure session handling and timeout
- [ ] **Data Encryption**: Sensitive data encrypted in transit and at rest
- [ ] **Error Handling**: No sensitive information in error messages
- [ ] **Logging**: Security events logged and monitored
- [ ] **Dependencies**: Regular security updates for all dependencies

#### Production Security
- [ ] **HTTPS**: TLS 1.3 enforced for all connections
- [ ] **Security Headers**: All security headers properly configured
- [ ] **Rate Limiting**: API rate limiting implemented
- [ ] **Monitoring**: Real-time security monitoring active
- [ ] **Backup**: Regular security-tested backups
- [ ] **Incident Response**: Security incident response plan ready
- [ ] **Penetration Testing**: Regular security assessments conducted
- [ ] **Compliance**: GDPR/CCPA compliance measures implemented

## 📱 Responsive Design

### Mobile-First Approach
```scss
// Simple responsive styles
.task-list-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 1rem;

  @media (max-width: 768px) {
    padding: 0.5rem;
  }
}

.task-item {
  display: flex;
  align-items: center;
  padding: 1rem;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  margin-bottom: 0.5rem;

  @media (max-width: 768px) {
    flex-direction: column;
    align-items: flex-start;
    
    .task-actions {
      width: 100%;
      margin-top: 0.5rem;
      display: flex;
      gap: 0.5rem;
    }
  }
}

.form-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;

  @media (max-width: 768px) {
    grid-template-columns: 1fr;
  }
}
```

## 🎯 Success Metrics

### Key Performance Indicators
```typescript
interface CRUDMetrics {
  usageMetrics: {
    recordsCreated: number;
    recordsUpdated: number;
    recordsDeleted: number;
    searchQueries: number;
  };
  
  performanceMetrics: {
    averageLoadTime: number;
    formSubmissionTime: number;
    searchResponseTime: number;
  };
  
  userExperience: {
    taskCompletionRate: number;
    errorRate: number;
    userSatisfaction: number;
  };
}
```

### Analytics Implementation
```typescript
// Simple analytics tracking
export const analytics = {
  trackAction(action: string, metadata: Record<string, any> = {}) {
    console.log('Analytics:', { action, metadata, timestamp: Date.now() });
    
    // In production, send to analytics service
    // analytics.track(action, metadata);
  },

  trackFormSubmission(formType: string, success: boolean) {
    this.trackAction('form_submission', {
      formType,
      success,
      userAgent: navigator.userAgent,
    });
  },

  trackPageView(page: string) {
    this.trackAction('page_view', {
      page,
      referrer: document.referrer,
    });
  },
};
```

---

*This Simple CRUD architecture pattern provides a solid foundation for straightforward data management applications with AWS Amplify Gen 2 and Next.js, focusing on simplicity, maintainability, and rapid development.*

**Pattern Version**: 1.0  
**Complexity**: Low  
**Estimated Implementation**: 1-2 weeks  
**Recommended Team Size**: 1-2 developers