---
title: Access User management
topics: ['Authentication']
primary_topic: Authentication
source: pages/build-a-backend/auth/manage-users/with-amplify-console/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Access User management

The **User management** page in the Amplify console provides a user-friendly interface for managing your application's users. You can create and manage users and groups, edit user attributes, and suspend users. 

If you have not yet created an **auth** resource, visit the [Auth setup guide](/[platform]/build-a-backend/auth/set-up-auth/).

## Access User management

After you've deployed your auth resource, you can access the manager on Amplify Console.

1. Log in to the [Amplify console](https://console.aws.amazon.com/amplify/home) and choose your app.
2. Select the branch you would like to access.
3. Select **Authentication** from the left navigation bar.
4. Then, select **User management**.

### To create a user

1. On the **User management** page, select **Users** tab.
2. Select **Create user**.
3. In the **Create user** window, for Unique identifier enter a email address, username, or phone number. For Temporary password enter a password.
4. Choose Create user.

> **Note**: 

A user can be confirmed by using the [pre-built UI components](/[platform]/build-a-backend/auth/connect-your-frontend/using-the-authenticator/) and [Amplify libraries](/[platform]/build-a-backend/auth/connect-your-frontend/sign-up/).

## To create a group

1. On the **User management** page, choose the **Groups** tab and then choose **Create group**.
2. In the **Create group** window, for **Title** enter a name for the group.
3. Choose **Create group**.

## To add a users to a group

1. On the **User management** page, choose the **Groups** tab.
2. Select the name of the group to add users to.
3. Choose **Add users**.
4. In the **Add users to group** window, choose how you want to search for users to add from the **Search** menu. You can choose _Email_, _Phone number_, or _Username_.
5. Add one user or multiple users to add to the group and then choose **Add users**.

## To delete a group

1. On the **User management** page, choose the **Groups** tab.
2. In the **Groups** section, select the name of the group to delete.
3. Choose **Delete**.
4. A confirmation window is displayed. Enter _Delete_ and choose, **Confirm deletion**.


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `pages/build-a-backend/auth/manage-users/with-amplify-console/index.mdx`