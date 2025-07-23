# Simple CRUD Pattern

The Simple CRUD pattern provides a straightforward foundation for basic data management applications that need standard create, read, update, and delete operations.

## When to Use

- Basic business applications
- Form-based data entry systems
- Simple inventory management
- Contact management systems
- Task and project tracking tools

## Core Features

### Data Management
- **Create Records**: Form-based data entry with validation
- **Read Records**: List views with search and filtering
- **Update Records**: Edit functionality with change tracking
- **Delete Records**: Safe deletion with confirmation

### User Interface
- **Form Generation**: Auto-generated forms from schema
- **Data Tables**: Sortable, filterable data displays
- **Search & Filter**: Basic query capabilities
- **Pagination**: Efficient large dataset handling

### Basic Features
- **User Authentication**: Simple login/registration
- **Data Validation**: Client and server-side validation
- **Export/Import**: CSV and basic file operations
- **Basic Reporting**: Simple data summaries

## Data Schema

```typescript
export const schema = a.schema({
  User: a.model({
    email: a.email().required(),
    name: a.string().required(),
    role: a.enum(['admin', 'user']).default('user'),
    isActive: a.boolean().default(true)
  }),

  // Example: Task Management
  Task: a.model({
    title: a.string().required(),
    description: a.string(),
    status: a.enum(['todo', 'in_progress', 'completed']).default('todo'),
    priority: a.enum(['low', 'medium', 'high']).default('medium'),
    assignedTo: a.belongsTo('User', 'assignedToId'),
    createdBy: a.belongsTo('User', 'createdById'),
    dueDate: a.date(),
    completedAt: a.datetime(),
    tags: a.string().array()
  }),

  // Example: Contact Management
  Contact: a.model({
    firstName: a.string().required(),
    lastName: a.string().required(),
    email: a.email(),
    phone: a.phone(),
    company: a.string(),
    jobTitle: a.string(),
    address: a.json(), // { street, city, state, zip }
    notes: a.string(),
    createdBy: a.belongsTo('User', 'createdById'),
    tags: a.string().array()
  }),

  // Example: Product Inventory
  Product: a.model({
    name: a.string().required(),
    sku: a.string().required(),
    description: a.string(),
    category: a.string(),
    price: a.float(),
    cost: a.float(),
    quantity: a.integer().default(0),
    minQuantity: a.integer().default(0), // Reorder threshold
    supplier: a.string(),
    isActive: a.boolean().default(true)
  })
});
```

## Form Components

```typescript
// Auto-generated forms with validation
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';

const TaskForm = ({ task, onSubmit, onCancel }) => {
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting }
  } = useForm({
    defaultValues: task || {},
    resolver: zodResolver(taskSchema)
  });

  return (
    <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
      <div>
        <label htmlFor="title">Title *</label>
        <input
          {...register('title')}
          type="text"
          className="form-input"
          placeholder="Enter task title"
        />
        {errors.title && (
          <span className="error">{errors.title.message}</span>
        )}
      </div>

      <div>
        <label htmlFor="description">Description</label>
        <textarea
          {...register('description')}
          className="form-textarea"
          rows={3}
          placeholder="Enter task description"
        />
      </div>

      <div className="grid grid-cols-2 gap-4">
        <div>
          <label htmlFor="status">Status</label>
          <select {...register('status')} className="form-select">
            <option value="todo">To Do</option>
            <option value="in_progress">In Progress</option>
            <option value="completed">Completed</option>
          </select>
        </div>

        <div>
          <label htmlFor="priority">Priority</label>
          <select {...register('priority')} className="form-select">
            <option value="low">Low</option>
            <option value="medium">Medium</option>
            <option value="high">High</option>
          </select>
        </div>
      </div>

      <div>
        <label htmlFor="dueDate">Due Date</label>
        <input
          {...register('dueDate')}
          type="date"
          className="form-input"
        />
      </div>

      <div className="flex justify-end space-x-2">
        <button
          type="button"
          onClick={onCancel}
          className="btn btn-secondary"
        >
          Cancel
        </button>
        <button
          type="submit"
          disabled={isSubmitting}
          className="btn btn-primary"
        >
          {isSubmitting ? 'Saving...' : 'Save Task'}
        </button>
      </div>
    </form>
  );
};
```

## Data Table Components

```typescript
// Reusable data table with sorting and filtering
const DataTable = ({ 
  data, 
  columns, 
  onEdit, 
  onDelete, 
  onSort, 
  sortField, 
  sortDirection 
}) => {
  const [filters, setFilters] = useState({});
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 20;

  const filteredData = useMemo(() => {
    return data.filter(item => {
      return Object.entries(filters).every(([field, value]) => {
        if (!value) return true;
        return item[field]?.toString().toLowerCase().includes(value.toLowerCase());
      });
    });
  }, [data, filters]);

  const paginatedData = useMemo(() => {
    const startIndex = (currentPage - 1) * itemsPerPage;
    return filteredData.slice(startIndex, startIndex + itemsPerPage);
  }, [filteredData, currentPage]);

  return (
    <div className="data-table">
      {/* Filters */}
      <div className="filters mb-4">
        {columns.filter(col => col.filterable).map(column => (
          <div key={column.field} className="filter-group">
            <label>{column.label}</label>
            <input
              type="text"
              placeholder={`Filter by ${column.label}`}
              value={filters[column.field] || ''}
              onChange={(e) => setFilters(prev => ({
                ...prev,
                [column.field]: e.target.value
              }))}
              className="filter-input"
            />
          </div>
        ))}
      </div>

      {/* Table */}
      <table className="table">
        <thead>
          <tr>
            {columns.map(column => (
              <th 
                key={column.field}
                className={column.sortable ? 'sortable' : ''}
                onClick={() => column.sortable && onSort(column.field)}
              >
                {column.label}
                {column.sortable && sortField === column.field && (
                  <span className="sort-indicator">
                    {sortDirection === 'asc' ? '↑' : '↓'}
                  </span>
                )}
              </th>
            ))}
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {paginatedData.map(item => (
            <tr key={item.id}>
              {columns.map(column => (
                <td key={column.field}>
                  {column.render 
                    ? column.render(item[column.field], item)
                    : item[column.field]
                  }
                </td>
              ))}
              <td>
                <div className="action-buttons">
                  <button
                    onClick={() => onEdit(item)}
                    className="btn btn-sm btn-outline"
                  >
                    Edit
                  </button>
                  <button
                    onClick={() => onDelete(item)}
                    className="btn btn-sm btn-danger"
                  >
                    Delete
                  </button>
                </div>
              </td>
            </tr>
          ))}
        </tbody>
      </table>

      {/* Pagination */}
      <Pagination
        currentPage={currentPage}
        totalItems={filteredData.length}
        itemsPerPage={itemsPerPage}
        onPageChange={setCurrentPage}
      />
    </div>
  );
};
```

## CRUD Operations

```typescript
// Standard CRUD operations
const useCRUD = (modelName) => {
  const [items, setItems] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  // Read - List all items
  const fetchItems = async (filters = {}) => {
    setLoading(true);
    try {
      const response = await client.models[modelName].list({
        filter: filters,
        limit: 100
      });
      setItems(response.data);
      setError(null);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  // Create - Add new item
  const createItem = async (data) => {
    try {
      const response = await client.models[modelName].create(data);
      setItems(prev => [response.data, ...prev]);
      return response.data;
    } catch (err) {
      setError(err.message);
      throw err;
    }
  };

  // Update - Edit existing item
  const updateItem = async (id, data) => {
    try {
      const response = await client.models[modelName].update({
        id,
        ...data
      });
      setItems(prev => prev.map(item => 
        item.id === id ? response.data : item
      ));
      return response.data;
    } catch (err) {
      setError(err.message);
      throw err;
    }
  };

  // Delete - Remove item
  const deleteItem = async (id) => {
    try {
      await client.models[modelName].delete({ id });
      setItems(prev => prev.filter(item => item.id !== id));
    } catch (err) {
      setError(err.message);
      throw err;
    }
  };

  return {
    items,
    loading,
    error,
    fetchItems,
    createItem,
    updateItem,
    deleteItem
  };
};
```

## Search and Filtering

```typescript
// Advanced search functionality
const useSearch = (items, searchFields) => {
  const [searchTerm, setSearchTerm] = useState('');
  const [filters, setFilters] = useState({});

  const filteredItems = useMemo(() => {
    let filtered = items;

    // Apply text search
    if (searchTerm) {
      filtered = filtered.filter(item =>
        searchFields.some(field =>
          item[field]?.toString().toLowerCase().includes(searchTerm.toLowerCase())
        )
      );
    }

    // Apply filters
    Object.entries(filters).forEach(([field, value]) => {
      if (value) {
        filtered = filtered.filter(item => {
          if (Array.isArray(value)) {
            return value.includes(item[field]);
          }
          return item[field] === value;
        });
      }
    });

    return filtered;
  }, [items, searchTerm, filters, searchFields]);

  return {
    searchTerm,
    setSearchTerm,
    filters,
    setFilters,
    filteredItems
  };
};
```

## Export/Import Features

```typescript
// CSV export functionality
const exportToCSV = (data, filename) => {
  if (!data.length) return;

  const headers = Object.keys(data[0]);
  const csvContent = [
    headers.join(','),
    ...data.map(row => 
      headers.map(header => {
        const value = row[header];
        // Handle commas and quotes in data
        if (typeof value === 'string' && (value.includes(',') || value.includes('"'))) {
          return `"${value.replace(/"/g, '""')}"`;
        }
        return value;
      }).join(',')
    )
  ].join('\\n');

  const blob = new Blob([csvContent], { type: 'text/csv' });
  const url = URL.createObjectURL(blob);
  const link = document.createElement('a');
  link.href = url;
  link.download = `${filename}.csv`;
  link.click();
  URL.revokeObjectURL(url);
};

// CSV import functionality
const importFromCSV = async (file, modelName) => {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    
    reader.onload = async (e) => {
      try {
        const csv = e.target.result;
        const lines = csv.split('\\n');
        const headers = lines[0].split(',');
        
        const data = lines.slice(1)
          .filter(line => line.trim())
          .map(line => {
            const values = line.split(',');
            const item = {};
            headers.forEach((header, index) => {
              item[header.trim()] = values[index]?.trim() || '';
            });
            return item;
          });

        // Validate and import each record
        const imported = [];
        for (const item of data) {
          try {
            const result = await client.models[modelName].create(item);
            imported.push(result.data);
          } catch (error) {
            console.warn(`Failed to import row:`, item, error);
          }
        }

        resolve(imported);
      } catch (error) {
        reject(error);
      }
    };

    reader.onerror = () => reject(new Error('File read error'));
    reader.readAsText(file);
  });
};
```

## Example Implementations

### Task Management App
```bash
/ace-genesis "simple task management app for small teams"

# Features generated:
# - Task creation and assignment
# - Status tracking (todo, in progress, completed)
# - Due date management
# - Basic team collaboration
# - Simple reporting dashboard
```

### Contact Management System
```bash
/ace-genesis "contact management system for sales teams"

# Features generated:
# - Contact information storage
# - Company and lead tracking
# - Search and filtering
# - Import/export capabilities
# - Basic interaction history
```

### Inventory Management
```bash
/ace-genesis "basic inventory management for small business"

# Features generated:
# - Product catalog management
# - Stock level tracking
# - Low inventory alerts
# - Simple purchase orders
# - Basic reporting
```

## Performance Considerations

### Database Optimization
```typescript
// Efficient pagination with cursor-based pagination
const paginatedFetch = async (modelName, cursor = null, limit = 20) => {
  const params = { limit };
  if (cursor) {
    params.nextToken = cursor;
  }

  const response = await client.models[modelName].list(params);
  
  return {
    items: response.data,
    nextCursor: response.nextToken,
    hasMore: !!response.nextToken
  };
};

// Batch operations for performance
const batchDelete = async (modelName, ids) => {
  const promises = ids.map(id => 
    client.models[modelName].delete({ id })
  );
  
  return await Promise.allSettled(promises);
};
```

### Caching Strategy
```typescript
// Simple client-side caching
const useCache = (key, fetcher, ttl = 300000) => { // 5 minutes default
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const cached = localStorage.getItem(key);
    if (cached) {
      const { data: cachedData, timestamp } = JSON.parse(cached);
      if (Date.now() - timestamp < ttl) {
        setData(cachedData);
        setLoading(false);
        return;
      }
    }

    fetcher().then(result => {
      setData(result);
      localStorage.setItem(key, JSON.stringify({
        data: result,
        timestamp: Date.now()
      }));
      setLoading(false);
    });
  }, [key]);

  return { data, loading };
};
```

## Cost Estimates

For a simple CRUD app with 50 users and moderate usage:

- **DynamoDB**: ~$5-15/month
- **Lambda Functions**: ~$5-10/month  
- **S3 Storage**: ~$1-5/month
- **CloudFront CDN**: ~$1-5/month
- **Authentication**: ~$0-10/month (Cognito free tier)

**Total estimated cost**: $12-45/month

## Security Features

- **Input Validation**: Server-side validation for all inputs
- **SQL Injection Prevention**: Parameterized queries
- **Access Control**: User-based permissions
- **Audit Logging**: Track all data changes
- **Data Backup**: Regular automated backups

## Common Patterns

### Master-Detail Views
```typescript
const MasterDetailView = () => {
  const [selectedItem, setSelectedItem] = useState(null);
  const { items } = useCRUD('Task');

  return (
    <div className="master-detail">
      <div className="master-panel">
        <ItemList 
          items={items}
          onSelect={setSelectedItem}
          selectedId={selectedItem?.id}
        />
      </div>
      
      <div className="detail-panel">
        {selectedItem ? (
          <ItemDetail item={selectedItem} />
        ) : (
          <div>Select an item to view details</div>
        )}
      </div>
    </div>
  );
};
```

### Modal Forms
```typescript
const ModalForm = ({ isOpen, onClose, item, onSave }) => {
  if (!isOpen) return null;

  return (
    <div className="modal-overlay">
      <div className="modal-content">
        <div className="modal-header">
          <h2>{item ? 'Edit' : 'Create'} Item</h2>
          <button onClick={onClose} className="close-button">×</button>
        </div>
        
        <div className="modal-body">
          <ItemForm 
            item={item}
            onSubmit={onSave}
            onCancel={onClose}
          />
        </div>
      </div>
    </div>
  );
};
```

## Getting Started

1. Run `/ace-genesis` with your basic app idea
2. Describe the main data entities you need to manage
3. Specify any special validation or business rules
4. Review the generated forms and tables
5. Deploy and start managing your data!

The Simple CRUD pattern is perfect for getting started quickly with basic business applications and can be extended as your needs grow.

---

[← Dashboard Analytics](dashboard-analytics.md) | [Back to Patterns](index.md)