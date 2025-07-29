# AWS Amplify UI Components Documentation

This directory contains comprehensive documentation for AWS Amplify UI components, organized by type and usage patterns. The documentation is specifically focused on React components for use with AWS Amplify Gen 2 and Next.js applications.

## 📁 Directory Structure

### `/primitives/` - Base UI Components
Core building blocks for user interfaces:

- **[button.md](./primitives/button.md)** - Interactive button component with variations, sizes, states, and theming
- **[textfield.md](./primitives/textfield.md)** - Text input field with validation, icons, and accessibility features  
- **[card.md](./primitives/card.md)** - Container component for grouping related content

### `/connected/` - Backend-Connected Components  
Components that integrate directly with AWS Amplify backend services:

- **[authenticator.md](./connected/authenticator.md)** - Complete authentication flows with minimal setup

### `/theming/` - Theme and Styling System
*Documentation for Amplify UI theming system (to be added)*

### `/patterns/` - Common UI Patterns
*Reusable patterns and compositions (to be added)*

## 🚀 Quick Start

### Installation

```bash
npm install @aws-amplify/ui-react
```

### Basic Usage

```jsx
import { Button, TextField, Card } from '@aws-amplify/ui-react';
import '@aws-amplify/ui-react/styles.css';

function MyComponent() {
  return (
    <Card>
      <TextField label="Name" />
      <Button variation="primary">Submit</Button>
    </Card>
  );
}
```

### With Next.js App Router (Server Components)

Amplify UI components are client-side interactive components. When using Next.js App Router with Server Components, wrap them in a Client Component:

```jsx
"use client";

import { Button, TextField } from '@aws-amplify/ui-react';
import '@aws-amplify/ui-react/styles.css';

export function MyClientComponent() {
  return (
    <div>
      <TextField label="Search" />
      <Button>Search</Button>
    </div>
  );
}
```

## 🎯 Key Component Categories

### Base Components
- **View, Text, Heading** - Typography and layout foundations
- **Button, Link** - Interactive elements
- **TextField, SelectField, CheckboxField** - Form inputs
- **Card, Flex, Grid** - Layout containers
- **Icon, Image, Avatar** - Media and display elements

### Feedback Components  
- **Alert, Message** - User notifications
- **Loader, Placeholder** - Loading states

### Navigation Components
- **Breadcrumbs, Menu, Tabs** - Navigation patterns

### Layout Components
- **Accordion, Collection, Pagination, Table** - Data organization

### Connected Components
- **Authenticator** - Complete authentication flows
- **Storage components** - File upload and management (when available)

## 🔧 Integration with AWS Amplify Gen 2

### Authentication Integration

```jsx
import { Authenticator } from '@aws-amplify/ui-react';
import { Amplify } from 'aws-amplify';
import outputs from './amplify_outputs.json';

Amplify.configure(outputs);

function App() {
  return (
    <Authenticator>
      {({ signOut, user }) => (
        <main>
          <h1>Hello {user.username}</h1>
          <Button onClick={signOut}>Sign out</Button>
        </main>
      )}
    </Authenticator>
  );
}
```

### Form Integration with Amplify Data

```jsx
import { TextField, Button, Card } from '@aws-amplify/ui-react';
import { generateClient } from 'aws-amplify/data';

const client = generateClient();

function CreatePostForm() {
  const [title, setTitle] = useState('');

  const handleSubmit = async () => {
    await client.models.Post.create({ title });
  };

  return (
    <Card>
      <TextField 
        label="Post Title"
        value={title}
        onChange={(e) => setTitle(e.target.value)}
      />
      <Button variation="primary" onClick={handleSubmit}>
        Create Post
      </Button>
    </Card>
  );
}
```

## 🎨 Theming and Customization

### Global Theme

```jsx
import { ThemeProvider, Theme } from '@aws-amplify/ui-react';

const theme: Theme = {
  name: 'custom-theme',
  tokens: {
    components: {
      button: {
        primary: {
          backgroundColor: { value: '#007bff' },
        },
      },
    },
  },
};

function App() {
  return (
    <ThemeProvider theme={theme}>
      <Button variation="primary">Themed Button</Button>
    </ThemeProvider>
  );
}
```

### CSS Variables

```css
:root {
  --amplify-components-button-primary-background-color: #007bff;
  --amplify-components-button-primary-hover-background-color: #0056b3;
}
```

### Component-Specific Styling

```jsx
<Button 
  variation="primary"
  backgroundColor="red.60"
  color="white"
  className="custom-button"
>
  Custom Styled Button
</Button>
```

## 📋 Component Reference Summary

### Most Common Components for Gen 2 Projects

| Component | Purpose | Gen 2 Integration |
|-----------|---------|-------------------|
| `Authenticator` | Complete auth flows | ✅ Automatic with `defineAuth()` |
| `Button` | Actions and form submission | ✅ Works with all Amplify APIs |
| `TextField` | Text input for forms | ✅ Perfect for data models |
| `Card` | Content grouping | ✅ Great for displaying data |
| `Flex/Grid` | Layout management | ✅ Universal layout |
| `Alert/Message` | User feedback | ✅ Error handling patterns |

### Form Components for Data Management

| Component | Purpose | Best For |
|-----------|---------|----------|
| `TextField` | Single-line text | Names, emails, titles |
| `TextAreaField` | Multi-line text | Descriptions, comments |
| `SelectField` | Dropdown selection | Categories, status |
| `CheckboxField` | Boolean selection | Settings, agreements |
| `RadioGroupField` | Single choice | Options, preferences |

## 🔗 External Resources

- **[Full Amplify UI Documentation](https://ui.docs.amplify.aws/react/components)** - Complete component library
- **[Amplify Gen 2 Documentation](https://docs.amplify.aws/react/start/quickstart/)** - Backend setup
- **[Next.js Integration Guide](https://docs.amplify.aws/react/build-a-backend/server-side-rendering/nextjs-app-router-server-components/)** - SSR patterns
- **[Theme Customization](https://ui.docs.amplify.aws/theming)** - Advanced styling

## 🚨 Important Notes

### Next.js Compatibility
- **App Router**: Wrap components in `"use client"` directive
- **Pages Router**: No changes required
- **SSR**: Use `@aws-amplify/adapter-nextjs` for server-side features

### Version Compatibility  
- **Current**: `@aws-amplify/ui-react` v6+
- **Legacy**: v5 and earlier require migration
- **Gen 2**: Full compatibility with latest versions

### Performance Best Practices
- Import only needed components: `import { Button } from '@aws-amplify/ui-react'`
- Include CSS once: `import '@aws-amplify/ui-react/styles.css'`
- Use component-level styling for better performance
- Leverage CSS variables for theme consistency

---

**Enhanced for ACE-Flow Integration**: This documentation is optimized for use with ACE-Flow's AWS Amplify Gen 2 development workflow, ensuring all examples work seamlessly with specification-driven development patterns.