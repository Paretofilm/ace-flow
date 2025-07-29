# Chat

Kiro offers a chat panel where you can interact with your code through natural language conversations. Just tell Kiro what you need. Ask questions about your codebase, request explanations for complex logic, generate new features, debug tricky issues, and automate repetitive tasks—all while Kiro maintains complete context of your project.

![Code review illustration](https://kiro.dev/images/placeholder.svg)

## Key Features

[**Contextual Understanding** \\
\\
Ask questions about your entire codebase, get explanations, or request edits with full awareness of your project structure\\
\\
Learn more](https://kiro.dev/docs/chat/vibe/) [**Smart Intent Detection** \\
\\
Kiro intelligently determines whether you want information or action, adapting its responses to match your workflow needs\\
\\
Learn more](https://kiro.dev/docs/chat/autopilot/) [**Vibe vs Spec sessions** \\
\\
Chat sessions can be either vibe or spec sessions. Learn more about the differences between these two.\\
\\
Learn more](https://kiro.dev/docs/chat/vibe/)

## Getting Started

### Accessing Chat

There are multiple ways to access the chat in your development environment:

1. **Keyboard Shortcut**: Press `Cmd+L` (Mac) or `Ctrl+L` (Windows/Linux) to open the chat panel
2. **Command Palette**: Press `Cmd+Shift+P` (Mac) or `Ctrl+Shift+P` (Windows/Linux) and search for `"Kiro: Open Chat"`
3. **Secondary Side Bar**: Click the Kiro chat icon toggle using `Cmd+Opt+B` (Mac) or `Ctrl+Alt+B` in the top bar on the right to open the chat panel

### Your First Conversation

Once the chat panel is open:

1. Type your question or request in natural language in the chat input
2. Press Enter to send your message
3. Kiro will analyze your request and respond appropriately

Example requests to get started:

**Ask about your code**

```code-highlight

"Explain how authentication works in this project"

```

**Generate new code**

```code-highlight

"Create a React component for a user profile page"

```

**Fix issues**

```code-highlight

"Help me fix the error in this function"

```

### Smart Intent Detection

Kiro intelligently analyzes your messages to understand whether you want information or action. When you ask questions like "How does this work?" or "What's the purpose of this code?",
Kiro recognizes this as an information request and responds with explanations and documentation without modifying your code. When you use directives like "Create a component" or "Fix this bug", Kiro identifies this as an action request and will propose or implement the necessary code changes, execute commands, or manage files accordingly. This seamless intent recognition allows for natural conversation without requiring explicit commands to switch between information and action modes.

## Context Management

Kiro's power comes from its deep understanding of your codebase context. It automatically analyzes open files in the editor, including their dependencies and structure, but you can also explicitly provide additional context.

### Context Providers

Use the `#` symbol in the chat input to access context providers:

| Provider | Description | Example |
| --- | --- | --- |
| `#codebase` | Allow Kiro to automatically find relevant files across your project | `#codebase explain the authentication flow` |
| `#file` | Reference specific files in your codebase | `#auth.ts explain this implementation` |
| `#folder` | Reference a specific folder and its contents | `#components/ what components do we have?` |
| `#git diff` | Reference the current Git changes | `#git diff explain what changed in this PR` |
| `#terminal` | Include terminal output in the context | `#terminal help me fix this build error` |
| `#problems` | Include all problems in the current file | `#problems help me resolve these issues` |
| `#url` | Include web documentation | `#url:https://docs.example.com/api explain this API` |
| `#code` | Include specific code snippets in the context | `#code:const sum = (a, b) => a + b; explain this function` |
| `#repository` | Include a map of your repository structure | `#repository how is this project organized?` |
| `#current` | Reference the currently active file in the editor | `#current explain this component` |
| `#steering` | Include specific steering files for guidance | `#steering:coding-standards.md review my code` |
| `#docs` | Reference documentation files and content | `#docs:api-reference.md explain this API endpoint` |
| `#mcp` | Access Model Context Protocol tools and services | `#mcp:aws-docs how do I configure S3 buckets?` |

You can combine multiple context providers in a single request:

```code-highlight

#codebase #auth.ts explain how authentication works with our database

```

## Sessions and History

Kiro maintains conversation history within sessions, allowing for continuous context-aware interactions.

### Managing Sessions

- **Create New Sessions**: Start fresh conversations for different topics or projects. Click on `+` icon in the chat panel to start a new session
- **Switch between Sessions**: Easily navigate between ongoing conversations through the tab switcher
- **View History**: Access previous interactions and their outcomes through the `History` button
- **Task Tracking**: Monitor the progress of ongoing and completed tasks through the `Task list` button

### Execution History

Kiro maintains a detailed history of sessions that includes actions taken such as code changes, commands executed,
search results, file operations, and more. You can search, restore, or delete a specific session.

![Kiro Execution History](https://kiro.dev/images/kirohistory.png?h=268115f8)

Page updated: July 14, 2025