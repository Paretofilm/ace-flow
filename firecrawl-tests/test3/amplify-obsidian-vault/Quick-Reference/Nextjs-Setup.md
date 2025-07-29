# ⚡ Next.js with Amplify - Quick Setup

## 🚀 Installation
```bash
npm create next-app@latest my-app
cd my-app
npm install aws-amplify @aws-amplify/ui-react
```

## ⚙️ Configuration
```typescript
// Configure Amplify
import { Amplify } from 'aws-amplify';
import outputs from './amplify_outputs.json';
Amplify.configure(outputs);
```

## 🔐 Authentication
```typescript
import { signIn, signOut, getCurrentUser } from 'aws-amplify/auth';
```

## 📊 Data/API
```typescript
import { generateClient } from 'aws-amplify/data';
const client = generateClient();
```

## 📂 Storage
```typescript
import { uploadData, downloadData } from 'aws-amplify/storage';
```

## 🔗 Related Topics
- [[Authentication/]]
- [[Data & APIs/]]
- [[File Storage/]]
- [[Getting Started/]]
