---
title: Distributed data
source: fragments/lib/datastore/native_common/sync-distributed-data.mdx
---

# Distributed data

## Distributed data

When working with distributed data, it is important to be mindful about the state of the local and the remote systems. DataStore tries to make that as simple as possible for you; however, some scenarios might require some consideration.

For instance, when updating or deleting data, one has to consider that the state of the local data might be out-of-sync with the backend. This scenario can affect how conditions should be implemented.

### Update and delete with predicate

For such scenarios both the `save()` and the `delete()` APIs support an optional predicate which will be sent to the backend and executed against the remote state.

There's a difference between the traditional local condition check using `if/else` constructs and the predicate in the `save()` and `delete()` APIs as you can see in the example below.

### Conflict detection and resolution

When concurrently updating the data in multiple places, it is likely that some conflict might happen. For most of the cases the default _Auto-merge_ algorithm should be able to resolve conflicts. However, there are scenarios where the algorithm won't be able to be resolved, and in these cases, a more advanced option is available and will be described in detail in the [conflict resolution](/gen1/[platform]/build-a-backend/more-features/datastore/conflict-resolution/) section.
