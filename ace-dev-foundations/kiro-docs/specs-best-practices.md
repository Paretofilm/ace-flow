# Best practices

## How do I import existing requirements?

If your requirements or designs already exist in another system (such as JIRA, Confluence, or Word documents), you have two options:

1. **Using MCP integration**: If your requirements tool has an MCP server that supports STDIO, you can connect directly to import requirements into your spec session.

2. **Manual import**: Simply copy your existing requirements (e.g. `foo-prfaq.md`) into a new file in your repo and open a spec chat session and say `#foo-prfaq.md Generate a spec from it`. Kiro will read your requirements, and generate requirement and design specs.


## How do I iterate on my specs?

Kiro's specifications are designed for continuous refinement, allowing you to update and enhance them as your project evolves. This iterative approach ensures that specifications remain synchronized with changing requirements and technical designs, providing a reliable foundation for development.

1. **Update Requirements**: Either modify the `requirements.md` file directly or initiate a spec session and instruct Kiro to add new requirements or design elements.

2. **Update Design**: Navigate to the `design.md` file for your spec and select **Refine**. This action will update both the design documentation and the associated task list to reflect your modified requirements.

3. **Update tasks**: Navigate to the `tasks.md` file and choose **Update tasks**. This will create new tasks that map to the new requirements.


## How do I share specs with my team?

Specs are designed to be version-controlled, making them easily shareable across your team. Store specs directly in your project repository alongside the code they describe. This keeps all project artifacts together and maintains the connection between requirements and implementation.

## Can I share specs across multiple teams?

Yes, you can share specs across multiple teams by leveraging Git submodules or package references. Here are some best practices for managing shared specs across teams:

1. **Create a central specs repository** - Establish a dedicated repository for shared specifications that multiple projects can reference.

2. **Use Git submodules or package references** - Link your central specs to individual projects using Git submodules, package references, or symbolic links depending on your development environment.

3. **Implement cross-repository workflows** - Develop processes for proposing, reviewing, and updating shared specs that affect multiple projects.


If you have specific needs for cross-project spec management, please share your requirements on our [GitHub issue tracker](https://github.com/kirodotdev) so we can prioritize features that support your workflow.

## Can I start a spec session from a vibe session?

Yes. You can have a vibe conversation and then say `Generate spec`. Kiro will then ask you if you want to start a spec session. If you say yes, it will proceed with generating requirements based on the context of your vibe session.

## Can I execute all the tasks in my spec in a single shot?

Yes, you can execute all the tasks in your `tasks.md` file by asking the Kiro agent to `Execute all tasks in the spec`. Kiro will start executing all your tasks. Note: we do not recommend doing this as we recommend a task-wise execution to get better results.

## What if some tasks are already implemented?

When working on an existing codebase, you might find that some tasks in your spec are already complete because a coworker or you ended up doing it in another session. Here are two ways to handle this:

**Option 1: Click on Update tasks in your tasks.md**

- Open your `tasks.md` file
- Click **Update tasks**
- Kiro will automatically mark completed tasks.

**Option 2: Let Kiro scan for you in a spec chat session**

- In a spec session, ask Kiro: "Check which tasks are already complete"
- Kiro will analyze your codebase and identify implemented functionality
- Kiro will automatically mark completed tasks

This keeps your task spec accurate.

## How many specs can I have in a single repo?

You can have as many specs as you want in a single repo. We recommend creating multiple specs for different features for your project rather than attempting to just have a single one for your entire codebase.

For example, in an e-commerce application, you might organize your specs like this:

```code-highlight

.kiro/specs/
├── user-authentication/       # Login, signup, password reset
├── product-catalog/           # Product listing, search, filtering
├── shopping-cart/             # Add to cart, quantity updates, checkout
├── payment-processing/        # Payment gateway integration, order confirmation
└── admin-dashboard/           # Product management, user analytics

```

This approach allows you to:

- Work on features independently without conflicts
- Maintain focused, manageable spec documents
- Iterate on specific functionality without affecting other areas
- Collaborate with team members on different features simultaneously

Page updated: July 14, 2025