# EARS Notation Guide (From Kiro Documentation)

## 🎯 **What is EARS Notation?**

EARS (Easy Approach to Requirements Syntax) is a structured format for writing clear, testable requirements that Kiro uses in their specification workflow.

## 📝 **Basic EARS Format**

```
WHEN [condition/event]
THE SYSTEM SHALL [expected behavior]
```

## 🔧 **EARS Templates and Examples**

### **Basic User Action**
```
WHEN a user clicks the "Submit" button
THE SYSTEM SHALL validate all form fields
```

### **Error Handling**
```
WHEN a user submits a form with invalid data
THE SYSTEM SHALL display validation errors next to the relevant fields
```

### **Authentication**
```
WHEN a user enters correct login credentials
THE SYSTEM SHALL redirect them to the dashboard

WHEN a user enters incorrect login credentials
THE SYSTEM SHALL display "Invalid credentials" error message
```

### **Data Processing**
```
WHEN a user uploads a file larger than 10MB
THE SYSTEM SHALL display "File too large" error message

WHEN a user uploads a valid file
THE SYSTEM SHALL process the file and show progress indicator
```

### **Conditional Logic**
```
WHEN a premium user accesses a feature
THE SYSTEM SHALL grant full access to all functionality

WHEN a free user accesses a premium feature
THE SYSTEM SHALL display upgrade prompt
```

## 🎯 **Benefits of EARS Notation**

1. **Clarity**: Unambiguous and easy to understand
2. **Testability**: Each requirement can be directly translated into test cases
3. **Traceability**: Individual requirements can be tracked through implementation
4. **Completeness**: The format encourages thinking through all conditions and behaviors

## 🏗️ **EARS in User Stories**

Kiro combines EARS with traditional user story format:

```markdown
## User Story: User Registration

**As a** new user
**I want** to create an account
**So that** I can access personalized features

**Acceptance Criteria (EARS):**

WHEN a user provides valid registration information
THE SYSTEM SHALL create a new account and send confirmation email

WHEN a user provides an email that already exists
THE SYSTEM SHALL display "Email already registered" error

WHEN a user provides invalid email format
THE SYSTEM SHALL display "Please enter valid email" error

WHEN a user's password is less than 8 characters
THE SYSTEM SHALL display "Password must be at least 8 characters" error
```

## 🚀 **ACE-Flow EARS Integration**

### **Template Generation**
ACE-Flow can generate EARS-formatted requirements from natural language:

**Input**: "Users should be able to upload files"
**Output**:
```
WHEN a user selects a file to upload
THE SYSTEM SHALL validate file type and size

WHEN a user uploads a valid file
THE SYSTEM SHALL display upload progress

WHEN file upload completes successfully
THE SYSTEM SHALL show confirmation message

WHEN file upload fails
THE SYSTEM SHALL display error message and retry option
```

### **Requirements Agent Integration**
The ACE-Flow requirements agent can:
1. Parse natural language feature descriptions
2. Generate comprehensive EARS notation
3. Ensure complete coverage of edge cases
4. Validate requirements against existing system

### **Testing Integration**
EARS requirements directly translate to test cases:
```javascript
// From EARS: "WHEN a user submits a form with invalid data
//             THE SYSTEM SHALL display validation errors"

test('should display validation errors for invalid form data', () => {
  // Test implementation matches EARS requirement exactly
});
```

## 📋 **EARS Best Practices**

1. **Be Specific**: Use concrete conditions, not vague terms
2. **Cover Edge Cases**: Think through error conditions
3. **One Behavior Per Requirement**: Each EARS statement should test one thing
4. **Use Active Voice**: "THE SYSTEM SHALL..." is clearer than passive voice
5. **Measurable Outcomes**: Requirements should have clear success criteria

## 🔧 **ACE-Flow EARS Templates**

### **Authentication Template**
```
WHEN a user [authentication action]
THE SYSTEM SHALL [expected authentication response]
```

### **Data Operation Template**
```
WHEN a user [data action] with [data condition]
THE SYSTEM SHALL [data processing response]
```

### **Error Handling Template**
```
WHEN [error condition occurs]
THE SYSTEM SHALL [error response] and [recovery action]
```

### **Permission Template**
```
WHEN a [user type] attempts to [restricted action]
THE SYSTEM SHALL [permission check result]
```

This EARS notation system ensures that ACE-Flow can generate the same quality of structured requirements that make Kiro's specification-driven development so effective.