---
title: Create and update
source: fragments/lib/datastore/native_common/data-access.mdx
---

# Create and update

## Create and update

To write data to the DataStore, pass an instance of a model to `Amplify.DataStore.save()`:

The `save` method creates a new record, or in the event that one already exists in the local store, it updates the record.

> **Note**: 

**Avoid working with stale data!**

Model instances which store values, such as those from the results of a `DataStore.Query` operation, can become stale and outdated when their properties are updated. This can be the result of a manual change or even a side effect of [real time data](/gen1/[platform]/build-a-backend/more-features/datastore/sync-to-cloud/#distributed-data) being received by the application. In order to ensure you are performing mutations on the latest committed state to the system, either perform a query directly before the `DataStore.save()` operation or observe the model to keep the state updated at all times and perform mutations on that latest state referencing the model instance. The preceding example demonstrates one approach. The following example demonstrates the `observeQuery` approach.

## Delete

To delete an item, simply pass in an instance.

## Query Data

Queries are performed against the _local store_. When cloud synchronization is enabled, the local store is updated in the background by the DataStore Sync Engine.

For more advanced filtering, such as matching arbitrary field values on an object, you can supply a query predicate.

### Predicates

Predicates are filters that can be used to match items in the DataStore. When applied to a query(), they constrain the returned results. When applied to a save(), they act as a pre-requisite for updating the data. You can match against fields in your schema by using the following predicates:

For example if you wanted a list of all `Post` Models that have a `rating` greater than 4:

Multiple conditions can also be used, like the ones defined in [GraphQL Transform condition statements](/gen1/[platform]/build-a-backend/graphqlapi/data-modeling/). For example, fetch all posts that have a rating greater than `4` and are `ACTIVE`:

Alternatively, the `or` logical operator can also be used:

### Pagination

Query results can also be paginated by passing in a `page` number (starting at 0) and an optional `limit` (defaults to 100). This will return a list of the first 100 items:

### Query, then observe changes

> **Note**: 

To both query _and_ observe subsequent changes to a Model, consider using [`observeQuery`](/gen1/[platform]/build-a-backend/more-features/datastore/real-time/#displaying-data-during-the-sync-process-with-observequery).
