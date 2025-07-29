---
title: Set up the project
source: pages/build-a-backend/data/working-with-files/index.mdx
---

# Set up the project

The Storage and GraphQL API categories can be used together to associate a file, such as an image or video, with a particular record. For example, you might create a `User` model with a profile picture, or a `Post` model with an associated image. With Amplify's GraphQL API and Storage categories, you can reference the file within the model itself to create an association.

## Set up the project

Set up your project by following the instructions in the [Quickstart guide](/[platform]/start/quickstart/).

## Define the model

Open `amplify/data/resource.ts` and add the following model as shown below:

```ts title="amplify/data/resource.ts"

const schema = a.schema()
    .authorization((allow) => [allow.publicApiKey()]),
});

    apiKeyAuthorizationMode: ,
  },
});
```
## Setup the Storage

Next, Let's configure Storage and allow access to all authenticated(signed in) users of your application. create a file `amplify/storage/resource.ts` and add the following code,This will restrict file access to only the signed-in user.

```ts title="amplify/storage/resource.ts"

Configure the storage in the `amplify/backend.ts` file as demonstrated below:

```ts title="amplify/backend.ts"

## Configuring authorization

Your application needs authorization credentials for reading and writing to both Storage and the Data, except in the case where all data and files are intended to be publicly accessible.

The Storage and Data categories govern data access based on their own authorization patterns, meaning that it's necessary to configure appropriate auth roles for each individual category. Although both categories share the same access credentials set up through the Auth category, they work independently from one another. For instance, adding an `allow.authenticated()` to the Data does not guard against file access in the Storage category. Likewise, adding authorization rules to the Storage category does not guard against data access in the API.

When you configure Storage, Amplify will configure appropriate IAM policies on the bucket using a Cognito Identity Pool role. You will then have the option of adding CRUD (Create, Update, Read and Delete) based permissions as well, so that Authenticated and Guest users will be granted limited permissions within these levels. **Even after adding this configuration, all Storage access is still `guest` by default.** To guard against accidental public access, the Storage access levels must either be configured on the Storage object globally, or set within individual function calls. This guide uses the former approach, setting all Storage access to `authenticated` users.

The ability to independently configure authorization rules for each category allows for more granular control over data access, and adds greater flexibility. For scenarios where authorization patterns must be mixed and matched, configure the access level on individual Storage function calls. For example, you may want to use `entity_id` CRUD access on an individual Storage function call for files that should only be accessible by the owner (such as personal files), `authenticated` read access to allow all logged in users to view common files (such as images in a shared photo album), and `guest` read access to allow all users to view a file (such as a public profile picture).

For more details on how to configure Storage authorization levels, see the [Storage documentation](/[platform]/build-a-backend/storage/authorization/). For more on configuring Data authorization, see the [API documentation](/[platform]/build-a-backend/data/customize-authz/).

## Create a record with an associated file

You can create a record via the Amplify Data client, upload a file to Storage, and finally update the record to associate it with the uploaded file. Use the following example with the Amplify Data client and Amplify Storage library helpers, `uploadData` and `getUrl`, to create a record and associate it the file with the record.

> **Note**: 

The API record's `id` is prepended to the Storage file name to ensure uniqueness. If this is excluded, multiple API records could then be associated with the same file path unintentionally.

```swift title="ContentView"
let song = Song(name: name)

guard let imageData = artCover.pngData() else 

// Create the song record
var createdSong = try await Amplify.API.mutate(request: .create(song)).get()
let coverArtPath = "images/\(createdSong.id)"

// Upload the art cover image
_ = try await Amplify.Storage.uploadData(path: .fromString(coverArtPath), data: imageData).value

// Update the song record with the image path
createdSong.coverArtPath = coverArtPath
let updatedSong = try await Amplify.API.mutate(request: .update(createdSong)).get()
```
</InlineFilter>

```ts title="src/App.tsx"

// Generating the client
const client = generateClient();

// Create the API record:
const response = await client.models.Song.create();

const song = response.data;

if (!song) return;

// Upload the Storage file:
const result = await uploadData(-$`,
  data: file,
  options: ,
}).result;

// Add the file association to the record:
const updateResponse = await client.models.Song.update();

const updatedSong = updateResponse.data;

setCurrentSong(updatedSong);

// If the record has no associated file, we can return early.
if (!updatedSong.coverArtPath) return;

// Retrieve the file's signed URL:
const signedURL = await getUrl();
```
</InlineFilter>

## Add or update a file for an associated record

To associate a file with a record, update the record with the path returned by the Storage upload. The following example uploads the file using Storage, updates the record with the file's path, then retrieves the signed URL to download the image. If an image is already associated with the record, this will update the record with the new image.

```swift title="ContentView"
guard var currentSong = currentSong else 
guard let imageData = artCover.pngData() else 

let coverArtPath = "images/\(currentSong.id)"

// Upload the new art image
_ = try await Amplify.Storage.uploadData(path: .fromString(coverArtPath), data: imageData).value

// Update the song record
currentSong.coverArtPath = coverArtPath
let updatedSong = try await Amplify.API.mutate(request: .update(currentSong)).get()
```
</InlineFilter>

```ts title="src/App.tsx"

// Generating the client
const client = generateClient();

// Upload the Storage file:
const result = await uploadData(-$`,
  data: file,
  options: ,
}).result;

// Add the file association to the record:
const response = await client.models.Song.update();

const updatedSong = response.data;

setCurrentSong(updatedSong);

// If the record has no associated file, we can return early.
if (!updatedSong?.coverArtPath) return;

// Retrieve the file's signed URL:
const signedURL = await getUrl();
```

</InlineFilter>

## Query a record and retrieve the associated file

To retrieve the file associated with a record, first query the record, then use Storage to get the signed URL. The signed URL can then be used to download the file, display an image, etc:

```swift title="ContentView"
// Get the song record
guard let song = try await Amplify.API.query(request: .get(Song.self, byIdentifier: currentSong.id)).get() else 

// If the record has no associated file, we can return early.
guard let coverArtPath = song.coverArtPath else 

// Download the art cover
print("coverArtPath: ", coverArtPath)
let imageData = try await Amplify.Storage.downloadData(path: .fromString(coverArtPath)).value

let image = UIImage(data: imageData)
```
</InlineFilter>

```ts title="src/App.tsx"

// Generating the client
const client = generateClient();

const response = await client.models.Song.get();

const song = response.data;

// If the record has no associated file, we can return early.
if (!song?.coverArtPath) return;

// Retrieve the signed URL:
const signedURL = await getUrl();
```
</InlineFilter>

## Delete and remove files associated with API records

There are three common deletion workflows when working with Storage files and the GraphQL API:

1. Remove the file association, continue to persist both file and record.
2. Remove the record association and delete the file.
3. Delete both file and record.

### Remove the file association, continue to persist both file and record

The following example removes the file association from the record, but does not delete the file from S3, nor the record from the database.

```swift title="ContentView"
// Get the song record
guard var song = try await Amplify.API.query(request: .get(Song.self, byIdentifier: currentSong.id)).get() else 

guard song.coverArtPath != nil else 

// Set the association to nil and update it
song.coverArtPath = nil

let updatedSong = try await Amplify.API.mutate(request: .update(song)).get()
```
</InlineFilter>

```ts title="src/App.tsx"

// Generating the client
const client = generateClient();

const response = await client.models.Song.get();

const song = response.data;

// If the record has no associated file, we can return early.
if (!song?.coverArtPath) return;

const updatedSong = await client.models.Song.update();
```
</InlineFilter>

### Remove the record association and delete the file

The following example removes the file from the record, then deletes the file from S3:

```swift title="ContentView"
// Get the song record
guard var song = try await Amplify.API.query(request: .get(Song.self, byIdentifier: currentSong.id)).get() else 

guard let coverArtPath = song.coverArtPath else 

// Set the association to nil and update it
song.coverArtPath = nil
let updatedSong = try await Amplify.API.mutate(request: .update(song)).get()

// Remove the image
try await Amplify.Storage.remove(path: .fromString(coverArtPath))
```
</InlineFilter>

```ts title="src/App.tsx"

// Generating the client
const client = generateClient();
const response = await client.models.Song.get();
const song = response?.data;

// If the record has no associated file, we can return early.
if (!song?.coverArtPath) return;

// Remove associated file from record
const updatedSong = await client.models.Song.update();

// Delete the file from S3:
await remove();

```
</InlineFilter>

### Delete both file and record

```swift title="ContentView"
// Get the song record
guard let song = try await Amplify.API.query(request: .get(Song.self, byId: currentSong.id)).get() else 

if let coverArt = song.coverArtPath 

// Delete the song record
_ = try await Amplify.API.mutate(request: .delete(song)).get()
```
</InlineFilter>

```ts title="src/App.tsx"

// Generating the client
const client = generateClient();
const response = await client.models.Song.get();

const song = response.data;

// If the record has no associated file, we can return early.
if (!song?.coverArtPath) return;

await remove();

// Delete the record from the API:
await client.models.Song.delete();

```
</InlineFilter>

## Working with multiple files

You may want to add multiple files to a single record, such as a user profile with multiple images. To do this, you can add a list of file keys to the record. The following example adds a list of file keys to a record:

### GraphQL schema to associate a data model with multiple files

Add the following model in `amplify/data/resource.ts" file.

```ts title="amplify/data/resource.ts"
const schema = a.schema()
    .authorization((allow) => [allow.publicApiKey()]),
});
```

CRUD operations when working with multiple files is the same as when working with a single file, with the exception that we are now working with a list of image keys, as opposed to a single image key.

### Create a record with multiple associated files

First create a record via the GraphQL API, then upload the files to Storage, and finally add the associations between the record and files.

```swift title="ContentView"
// Create the photo album record
let album = PhotoAlbum(name: name)
var createdAlbum = try await Amplify.API.mutate(request: .create(album)).get()

// Upload the photo album images
let imagePaths = await withTaskGroup(of: String?.self)  catch 
        }
    }

    var imagePaths: [String?] = []
    for await imagePath in group 
    return imagePaths.compactMap 
}

// Update the album with the image paths
createdAlbum.imagePaths = imagePaths
let updatedAlbum = try await Amplify.API.mutate(request: .update(createdAlbum)).get()
```
</InlineFilter>

```ts title="src/App.tsx"

// Generating the client
const client = generateClient();

// Create the API record:
const response = await client.models.PhotoAlbum.create();

const photoAlbum = response.data.createPhotoAlbum;

if (!photoAlbum) return;

// Upload all files to Storage:
const imagePaths = await Promise.all(
  Array.from(e.target.files).map(async (file) => -$`,
      data: file,
      options: ,
    }).result;

    return result.path;
  })
);

const updatePhotoAlbumDetails = ;

// Add the file association to the record:
const updateResponse = await client.graphql(,
});

const updatedPhotoAlbum = updateResponse.data.updatePhotoAlbum;

// If the record has no associated file, we can return early.
if (!updatedPhotoAlbum.imageKeys?.length) return;

// Retrieve signed urls for all files:
const signedUrls = await Promise.all(
  updatedPhotoAlbum?.imagePaths.map(
    async (path) => await getUrl()
  )
);
```
</InlineFilter>

### Add new files to an associated record

To associate additional files with a record, update the record with the paths returned by the Storage uploads.

```swift title="ContentView"
// Upload the new photo album image
let path = "images/\(currentAlbum.id)-\(UUID().uuidString)"
_ = try await Amplify.Storage.uploadData(path: .fromString(path), data: imageData).value

// Get the latest album
guard var album = try await Amplify.API.query(request: .get(PhotoAlbum.self, byId: currentAlbum.id)).get() else 

guard var imagePaths = album.imagePaths else 

// Add new to the existing paths
imagePaths.append(path)

// Update the album with the image paths
album.imagePaths = imagePaths
let updatedAlbum = try await Amplify.API.mutate(request: .update(album)).get()
```
</InlineFilter>

```ts title="src/App.tsx"

// Generating the client
const client = generateClient();

// Upload all files to Storage:
const newimagePaths = await Promise.all(
  Array.from(e.target.files).map(async (file) => -$`,
      data: file,
      options: ,
    }).result;

    return result.path;
  })
);

// Query existing record to retrieve currently associated files:
const queriedResponse = await client.models.PhotoAlbum.get();

const photoAlbum = queriedResponse.data;

if (!photoAlbum?.imagePaths) return;

// Merge existing and new file paths:
const updatedimagePaths = [...newimagePaths, ...photoAlbum.imagePaths];

// Update record with merged file associations:
const response = await client.models.PhotoAlbum.update();

const updatedPhotoAlbum = response.data;

// If the record has no associated file, we can return early.
if (!updatedPhotoAlbum?.imageKeys) return;

// Retrieve signed urls for merged image paths:
const signedUrls = await Promise.all(
  updatedPhotoAlbum?.imagePaths.map(
    async (path) => await getUrl()
  )
);
```
</InlineFilter>

### Update the file for an associated record

Updating a file for an associated record is the same as updating a file for a single file record, with the exception that you will need to update the list of file keys.

```swift title="ContentView"
// Upload new file to Storage:
let path = "images/\(currentAlbum.id)-\(UUID().uuidString)"

_ = try await Amplify.Storage.uploadData(path: .fromString(path), data: imageData).value

// Update the album with the image keys
var album = currentAlbum

if var imagePaths = album.imagePaths  else 

// Update record with updated file associations:
let updateResult = try await Amplify.API.mutate(request: .update(album)).get()
```
</InlineFilter>

```ts title="src/App.tsx"

// Generating the client
const client = generateClient();

// Upload new file to Storage:
const result = await uploadData(-$`,
  data: file,
  options: ,
}).result;

const newFilePath = result.path;

// Query existing record to retrieve currently associated files:
const queriedResponse = await client.models.PhotoAlbum.get();

const photoAlbum = queriedResponse.data;

if (!photoAlbum?.imagePaths?.length) return;

// Retrieve last image path:
const [lastImagePath] = photoAlbum.imagePaths.slice(-1);

// Remove last file association by path
const updatedimagePaths = [
  ...photoAlbum.imagePaths.filter((path) => path !== lastImagePath),
  newFilePath,
];

// Update record with updated file associations:
const response = await client.models.PhotoAlbum.update();

const updatedPhotoAlbum = response.data;

// If the record has no associated file, we can return early.
if (!updatedPhotoAlbum?.imagePaths) return;

// Retrieve signed urls for merged image paths:
const signedUrls = await Promise.all(
  updatedPhotoAlbum?.imagePaths.map(
    async (path) => await getUrl()
  )
);

```
</InlineFilter>
### Query a record and retrieve the associated files

To retrieve the files associated with a record, first query the record, then use Storage to retrieve all of the signed URLs.

```swift title="ContentView"
// Query the record to get the file paths:
guard let album = try await Amplify.API.query(
    request: .get(PhotoAlbum.self, byId: currentAlbum.id)).get() else 

guard let imagePathsOptional = album.imagePaths else 

let imagePaths = imagePathsOptional.compactMap 

// Download the photos
let images = await withTaskGroup(of: UIImage?.self)  catch 
        }
    }

    var images: [UIImage?] = []
    for await image in group 
    return images.compactMap 
}
```
</InlineFilter>

```ts title="src/App.tsx"
async function getImagesForPhotoAlbum() );

// Query the record to get the file paths:
const response = await client.models.PhotoAlbum.get();

const photoAlbum = response.data;

// If the record has no associated files, we can return early.
if (!photoAlbum?.imagePaths) return;

// Retrieve the signed URLs for the associated images:
const signedUrls = await Promise.all(
  photoAlbum.imagePaths.map(async (imagePath) => );
  })
);
}
```
</InlineFilter>

### Delete and remove files associated with API records

The workflow for deleting and removing files associated with API records is the same as when working with a single file, except that when performing a delete you will need to iterate over the list of file paths and call `Storage.remove()` for each file.

#### Remove the file association, continue to persist both files and record

```swift title="ContentView"
// Get the album record
guard var album = try await Amplify.API.query(request: .get(PhotoAlbum.self, byId: currentAlbum.id)).get() else 

guard let imagePaths = album.imagePaths, !imagePaths.isEmpty else 

// Set the association to nil and update it
album.imagePaths = nil
let updatedAlbum = try await Amplify.API.mutate(request: .update(album)).get()
```
</InlineFilter>

```ts title="src/App.tsx"

// Generating the client
const client = generateClient();

const response = await client.models.PhotoAlbum.get();

const photoAlbum = response.data;

// If the record has no associated file, we can return early.
if (!photoAlbum?.imagePaths) return;

const updatedPhotoAlbum = await client.models.PhotoAlbum.update();
```
</InlineFilter>

#### Remove the record association and delete the files

```swift title="ContentView"
// Get the album record
guard var album = try await Amplify.API.query(request: .get(PhotoAlbum.self, byId: currentAlbum.id)).get() else 

guard let imagePathsOptional = album.imagePaths else 
let imagePaths = imagePathsOptional.compactMap 

// Set the associations to nil and update it
album.imagePaths = nil
let updatedAlbum = try await Amplify.API.mutate(request: .update(album)).get()

// Remove the photos
await withTaskGroup(of: Void.self)  catch 
        }
    }

    for await _ in group 
}
```
</InlineFilter>

```ts title="src/App.tsx"

// Generating the client
const client = generateClient();

const response = await client.models.PhotoAlbum.get();

const photoAlbum = response.data;

// If the record has no associated files, we can return early.
if (!photoAlbum?.imagePaths) return;

// Remove associated files from record
const updateResponse = await client.models.PhotoAlbum.update();

const updatedPhotoAlbum = updateResponse.data;

// Delete the files from S3:
await Promise.all(
  photoAlbum?.imagePaths.map(async (imagePath) => );
  })
);
```
</InlineFilter>

#### Delete record and all associated files

```swift title="ContentView"
// Get the album record
guard let album = try await Amplify.API.query(request: .get(PhotoAlbum.self, byId: currentAlbum.id)).get() else 

guard let imagePathsOptional = album.imagePaths else 

let imagePaths = imagePathsOptional.compactMap 

// Remove the photos
await withTaskGroup(of: Void.self)  catch 
        }
    }

    for await _ in group 
}

// Delete the album record
_ = try await Amplify.API.mutate(request: .delete(album)).get()
```
</InlineFilter>

```ts title="src/App.tsx"

// Generating the client
const client = generateClient();

const response = await client.models.PhotoAlbum.get();

const photoAlbum = response.data;

if (!photoAlbum) return;

await client.models.PhotoAlbum.delete();

setCurrentPhotoAlbum(null);

// If the record has no associated file, we can return early.
if (!photoAlbum?.imagePaths) return;

await Promise.all(
  photoAlbum?.imagePaths.map(async (imagePath) => );
  })
);

```
</InlineFilter>

## Data consistency when working with records and files

The recommended access patterns in these docs attempt to remove deleted files, but favor leaving orphans over leaving records that point to non-existent files. This optimizes for read latency by ensuring clients _rarely_ attempt to fetch a non-existent file from Storage. However, any app that deletes files can inherently cause records _on-device_ to point to non-existent files.

One example is when we [create an API record, associate the Storage file with that record, and then retrieve the file's signed URL](#create-a-record-with-an-associated-file). "Device A" calls the GraphQL API to create `API_Record_1`, and then associates that record with `First_Photo`. Before "Device A" is about to retrieve the signed URL, "Device B" might query `API_Record_1`, delete `First_Photo`, and update the record accordingly. However, "Device A" is still using the old `API_Record_1`, which is now out-of-date. Even though the shared global state is correctly in sync at every stage, the individual device ("Device A") has an out-of-date record that points to a non-existent file. Similar issues can conceivably occur for updates. Depending on your app, some of these mismatches can be minimized _even more_ with [real-time data / GraphQL subscriptions](/[platform]/build-a-backend/data/subscribe-data/).

It is important to understand when these mismatches can occur and to add meaningful error handling around these cases. This guide does not include exhaustive error handling, real-time subscriptions, re-querying of outdated records, or attempts to retry failed operations. However, these are all important considerations for a production-level application.

## Complete examples

```swift title="AmplifySwiftApp"
import SwiftUI
import Amplify
import AWSAPIPlugin
import AWSCognitoAuthPlugin
import AWSS3StoragePlugin
import Authenticator
import PhotosUI

@main
struct WorkingWithFilesApp: App  catch 
    }

    var body: some Scene 

                    PhotoAlbumView()
                        .tabItem 
                }

            }
        }
    }
}

struct SignOutButton: View 
        }.foregroundColor(.black)
    }
}

struct TappedButtonStyle: ButtonStyle 
}

extension Color 

struct DimmedBackgroundView: View 
}

struct ImagePicker: UIViewControllerRepresentable 

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) 
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) 
    }

    func makeCoordinator() -> Coordinator 

    func makeUIViewController(context: UIViewControllerRepresentableContext) -> UIImagePickerController 

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext) 
}

struct MultiImagePicker: UIViewControllerRepresentable 

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) 

    func makeCoordinator() -> Coordinator 

    class Coordinator: PHPickerViewControllerDelegate 

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) 
            for result in results 
                        }
                    }
                }
            }
        }
    }
}
```
</Block>

```swift title="SongView"
import SwiftUI
import Amplify

class SongViewModel: ObservableObject 
        }
                let song = Song(name: name)

        guard let imageData = artCover.pngData() else 

        // Create the song record
        var createdSong = try await Amplify.API.mutate(request: .create(song)).get()
        let coverArtPath = "images/\(createdSong.id)"

        // Upload the art cover image
        _ = try await Amplify.Storage.uploadData(path: .fromString(coverArtPath), data: imageData).value

        // Update the song record with the image path
        createdSong.coverArtPath = coverArtPath
        let updatedSong = try await Amplify.API.mutate(request: .update(createdSong)).get()

        await setCurrentSong(updatedSong)
    }

    func getSongAndFile(currentSong: Song, imageData: Data) async throws 

        guard let coverArtPath = song.coverArtPath else 

        // Download the art cover
        let imageData = try await Amplify.Storage.downloadData(path: .fromString(coverArtPath)).value

        let image = UIImage(data: imageData)
    }

    // Add or update an image for an associated record
    func updateArtCover(artCover: UIImage) async throws 
        }

        guard var currentSong = currentSong else 

        guard let imageData = artCover.pngData() else 

        let coverArtPath = "images/\(currentSong.id)"

        // Upload the new art image
        _ = try await Amplify.Storage.uploadData(path: .fromString(coverArtPath), data: imageData).value

        // Update the song record
        currentSong.coverArtPath = coverArtPath
        let updatedSong = try await Amplify.API.mutate(request: .update(currentSong)).get()

        await setCurrentSong(updatedSong)
    }

    func refreshSongAndArtCover() async throws 
        }
        guard let currentSong = currentSong else 
        await setCurrentSong(nil)
        await setCurrentImage(nil)

        // Get the song record
        guard let song = try await Amplify.API.query(request: .get(Song.self, byIdentifier: currentSong.id)).get() else 

        guard let coverArtPath = song.coverArtPath else 

        // Download the art cover
        let imageData = try await Amplify.Storage.downloadData(path: .fromString(coverArtPath)).value

        let image = UIImage(data: imageData)

        await setCurrentSong(song)
        await setCurrentImage(image)
    }

    func removeImageAssociationFromSong() async throws 
        }
        guard let currentSong = currentSong else 

        // Get the song record
        guard var song = try await Amplify.API.query(request: .get(Song.self, byIdentifier: currentSong.id)).get() else 

        guard song.coverArtPath != nil else 

        // Set the association to nil and update it
        song.coverArtPath = nil

        let updatedSong = try await Amplify.API.mutate(request: .update(song)).get()

        await setCurrentSong(updatedSong)
    }

    func removeImageAssociationAndDeleteImage() async throws 
        }
        guard let currentSong = currentSong else 

        // Get the song record
        guard var song = try await Amplify.API.query(request: .get(Song.self, byIdentifier: currentSong.id)).get() else 

        guard let coverArtPath = song.coverArtPath else 

        // Set the association to nil and update it
        song.coverArtPath = nil
        let updatedSong = try await Amplify.API.mutate(request: .update(song)).get()

        // Remove the image
        try await Amplify.Storage.remove(path: .fromString(coverArtPath))

        await setCurrentSong(updatedSong)
        await setCurrentImage(nil)
    }

    func deleteSongAndArtCover() async throws 
        }
        guard let currentSong = currentSong else 

        // Get the song record
        guard var song = try await Amplify.API.query(request: .get(Song.self, byId: currentSong.id)).get() else 

        if let coverArt = song.coverArtPath 

        // Delete the song record
        _ = try await Amplify.API.mutate(request: .delete(song)).get()

        await setCurrentSong(nil)
        await setCurrentImage(nil)
    }

    @MainActor
    func setCurrentSong(_ song: Song?) 

    @MainActor
    func setCurrentImage(_ image: UIImage?) 

    @MainActor
    func setIsLoading(_ isLoading: Bool) 
}

struct SongView: View 
                .padding()
                .sheet(isPresented: $isImagePickerPresented) 
                VStack 
            }
            .navigationBarItems(trailing: SignOutButton())
        }
    }

    @ViewBuilder
    func SongInformation() -> some View 
        }
    }

    @ViewBuilder
    func DisplayImage() -> some View  else 

    }

    func OpenImagePickerButton() -> some View .buttonStyle(TappedButtonStyle())
    }

    @ViewBuilder
    func SongNameTextField() -> some View 

    @ViewBuilder
    func CreateOrUpdateSongButton() -> some View 
            }
            .buttonStyle(TappedButtonStyle())
            .disabled(viewModel.isLoading)
        } else if viewModel.currentSong != nil, let image = viewModel.currentImage 
            }
            .buttonStyle(TappedButtonStyle())
            .disabled(viewModel.isLoading)
        }
    }

    @ViewBuilder
    func AdditionalOperations() -> some View 
                }.buttonStyle(TappedButtonStyle())
                Button("Remove association from song") 
                }.buttonStyle(TappedButtonStyle())
                Button("Remove association and delete image") 
                }.buttonStyle(TappedButtonStyle())
                Button("Delete song and art cover") 
                    songName = ""
                }.buttonStyle(TappedButtonStyle())
            }.disabled(viewModel.isLoading)
        }
    }

    @ViewBuilder
    func IsLoadingView() -> some View 
        }
    }
}

struct SongView_Previews: PreviewProvider 
}
```
</Block>

```swift title="PhotoAlbumView"
import SwiftUI
import Amplify
import Photos

class PhotoAlbumViewModel: ObservableObject 
        }

        let imagesData = photos.compactMap 
        guard !imagesData.isEmpty else 

        // Create the photo album record
        let album = PhotoAlbum(name: name)
        var createdAlbum = try await Amplify.API.mutate(request: .create(album)).get()

        // Upload the photo album images
        let imagePaths = await withTaskGroup(of: String?.self)  catch 
                }
            }

            var imagePaths: [String?] = []
            for await imagePath in group 
            return imagePaths.compactMap 
        }

        // Update the album with the image paths
        createdAlbum.imagePaths = imagePaths
        let updatedAlbum = try await Amplify.API.mutate(request: .update(createdAlbum)).get()

        await setCurrentAlbum(updatedAlbum)
    }

    // Create a record with a single associated file
    func createPhotoAlbum(name: String, photo: UIImage) async throws 
        }

        guard let imageData = photo.pngData() else 

        // Create the photo album record
        let album = PhotoAlbum(name: name)
        var createdAlbum = try await Amplify.API.mutate(request: .create(album)).get()

        // Upload the photo album image
        let path = "images/\(album.id)-\(UUID().uuidString)"
        _ = try await Amplify.Storage.uploadData(path: .fromString(path), data: imageData).value

        // Update the album with the image path
        createdAlbum.imagePaths = [path]
        let updatedAlbum = try await Amplify.API.mutate(request: .update(createdAlbum)).get()

        await setCurrentAlbum(updatedAlbum)
    }

    // Add new file to an associated record
    func addAdditionalPhotos(_ photo: UIImage) async throws 
        }

        guard let currentAlbum = currentAlbum else 

        guard let imageData = photo.pngData() else 

        // Upload the new photo album image
        let path = "images/\(currentAlbum.id)-\(UUID().uuidString)"
        _ = try await Amplify.Storage.uploadData(path: .fromString(path), data: imageData).value

        // Get the latest album
        guard var album = try await Amplify.API.query(request: .get(PhotoAlbum.self, byId: currentAlbum.id)).get() else 

        guard var imagePaths = album.imagePaths else 

        // Add new to the existing paths
        imagePaths.append(path)

        // Update the album with the image paths
        album.imagePaths = imagePaths
        let updatedAlbum = try await Amplify.API.mutate(request: .update(album)).get()

        await setCurrentAlbum(updatedAlbum)
    }

    func replaceLastImage(_ photo: UIImage) async throws 
        }

        guard let currentAlbum = currentAlbum else 

        guard let imageData = photo.pngData() else 

        // Upload the new photo album image
        let path = "images/\(currentAlbum.id)-\(UUID().uuidString)"
        _ = try await Amplify.Storage.uploadData(path: .fromString(path), data: imageData).value

        // Update the album with the image paths
        var album = currentAlbum
        if var imagePaths = album.imagePaths  else 

        let updatedAlbum = try await Amplify.API.mutate(request: .update(album)).get()

        await setCurrentAlbum(updatedAlbum)
    }

    // Query a record and retrieve the associated files
    func refreshAlbumAndPhotos() async throws 
        }
        guard let currentAlbum = currentAlbum else 

        await setCurrentAlbum(nil)
        await setCurrentImages([])

        // Get the song record
        guard let album = try await Amplify.API.query(
            request: .get(PhotoAlbum.self, byId: currentAlbum.id)).get() else 

        guard let imagePathsOptional = album.imagePaths else 

        let imagePaths = imagePathsOptional.compactMap 

        // Download the photos
        let images = await withTaskGroup(of: UIImage?.self)  catch 
                }
            }

            var images: [UIImage?] = []
            for await image in group 
            return images.compactMap 
        }

        await setCurrentAlbum(album)
        await setCurrentImages(images)
    }

    // Remove the file association
    func removeStorageAssociationsFromAlbum() async throws 
        }
        guard let currentAlbum = currentAlbum else 

        // Get the album record
        guard var album = try await Amplify.API.query(request: .get(PhotoAlbum.self, byId: currentAlbum.id)).get() else 

        guard let imagePaths = album.imagePaths, !imagePaths.isEmpty else 

        // Set the association to nil and update it
        album.imagePaths = nil
        let updatedAlbum = try await Amplify.API.mutate(request: .update(album)).get()

        await setCurrentAlbum(updatedAlbum)
    }

    // Remove the record association and delete the files
    func removeStorageAssociationsAndDeletePhotos() async throws 
        }

        guard let currentAlbum = currentAlbum else 

        // Get the album record
        guard var album = try await Amplify.API.query(request: .get(PhotoAlbum.self, byId: currentAlbum.id)).get() else 

        guard let imagePathsOptional = album.imagePaths else 
        let imagePaths = imagePathsOptional.compactMap 

        // Set the associations to nil and update it
        album.imagePaths = nil
        let updatedAlbum = try await Amplify.API.mutate(request: .update(album)).get()

        // Remove the photos
        await withTaskGroup(of: Void.self)  catch 
                }
            }

            for await _ in group 
        }

        await setCurrentAlbum(updatedAlbum)
        await setCurrentImages([])
    }

    // Delete record and all associated files
    func deleteAlbumAndPhotos() async throws 
        }

        guard let currentAlbum = currentAlbum else 

        // Get the album record
        guard let album = try await Amplify.API.query(request: .get(PhotoAlbum.self, byId: currentAlbum.id)).get() else 

        guard let imagePathsOptional = album.imagePaths else 

        let imagePaths = imagePathsOptional.compactMap 

        // Remove the photos
        await withTaskGroup(of: Void.self)  catch 
                }
            }

            for await _ in group 
        }

        // Delete the album record
        _ = try await Amplify.API.mutate(request: .delete(album)).get()

        await setCurrentAlbum(nil)
        await setCurrentImages([])
    }

    @MainActor
    func setCurrentAlbum(_ album: PhotoAlbum?) 

    @MainActor
    func setCurrentImages(_ images: [UIImage]) 

    @MainActor
    func setIsLoading(_ isLoading: Bool) 
}

struct PhotoAlbumView: View 
                .padding()
                .sheet(isPresented: $isImagePickerPresented) 
                .sheet(isPresented: $isLastImagePickerPresented) 
                VStack 
            }
            .navigationBarItems(trailing: SignOutButton())
        }
    }

    @ViewBuilder
    func AlbumInformation() -> some View 
        }
    }

    @ViewBuilder
    func DisplayImages() -> some View 
            }
        }
        if $viewModel.currentImages.isEmpty 
    }

    func OpenImagePickerButton() -> some View .buttonStyle(TappedButtonStyle())
    }

    @ViewBuilder
    func PhotoAlbumNameTextField() -> some View 

    @ViewBuilder
    func CreateOrUpdateAlbumButton() -> some View 
            }
            .buttonStyle(TappedButtonStyle())
            .disabled(viewModel.isLoading)
        } else if viewModel.currentAlbum != nil 
            .buttonStyle(TappedButtonStyle())
            .disabled(viewModel.isLoading)

            if let lastImage = lastImage 
                }
                .buttonStyle(TappedButtonStyle())
                .disabled(viewModel.isLoading)
                Button("Append above image to album") 
                }
                .buttonStyle(TappedButtonStyle())
                .disabled(viewModel.isLoading)
            }
        }
    }

    @ViewBuilder
    func AdditionalOperations() -> some View 
                }.buttonStyle(TappedButtonStyle())
                Button("Remove associations from album") 
                }.buttonStyle(TappedButtonStyle())
                Button("Remove association and delete photos") 
                }.buttonStyle(TappedButtonStyle())
                Button("Delete album and images") 
                    albumName = ""
                }.buttonStyle(TappedButtonStyle())
            }.disabled(viewModel.isLoading)
        }
    }

    @ViewBuilder
    func IsLoadingView() -> some View 
        }
    }
}

struct PhotoAlbumView_Previews: PreviewProvider 
}
```
</Block>
</BlockSwitcher>
</InlineFilter>

```ts title="src/App.tsx"

import "./App.css";
import "@aws-amplify/ui-react/styles.css";
import  from "@aws-amplify/ui-react";

Amplify.configure(outputs);

// Generating the client
const client = generateClient();

type Song = Schema["Song"]["type"];

function App(: WithAuthenticatorProps) );

      const song = response.data;

      if (!song) return;

      // Upload the Storage file:
      const result = await uploadData(-$`,
        data: file,
        options: ,
      }).result;

      // Add the file association to the record:
      const updateResponse = await client.models.Song.update();

      const updatedSong = updateResponse.data;
      setCurrentSong(updatedSong);

      // If the record has no associated file, we can return early.
      if (!updatedSong?.coverArtPath) return;

      // Retrieve the file's signed URL:
      const signedURL = await getUrl();

      setCurrentImageUrl(signedURL.url.toString());
    } catch (error) 
  }

  // Upload image, add to song, retrieve signed URL and retrieve the image.
  // Also updates image if one already exists.
  async function addNewImageToSong(e: React.ChangeEvent) -$`,
        data: file,
        options: ,
      }).result;

      // Add the file association to the record:
      const response = await client.models.Song.update();

      const updatedSong = response.data;

      setCurrentSong(updatedSong);

      // If the record has no associated file, we can return early.
      if (!updatedSong?.coverArtPath) return;

      // Retrieve the file's signed URL:
      const signedURL = await getUrl();
      setCurrentImageUrl(signedURL.url.toString());

    } catch (error) 
  }

  async function getImageForCurrentSong() );

      const song = response.data;

      // If the record has no associated file, we can return early.
      if (!song?.coverArtPath) return;

      // Retrieve the signed URL:
      const signedURL = await getUrl();
      setCurrentImageUrl(signedURL.url.toString());
    } catch (error) 
  }

  // Remove the file association, continue to persist both file and record
  async function removeImageFromSong() );

      const song = response.data;

      // If the record has no associated file, we can return early.
      if (!song?.coverArtPath) return;

      const updatedSong = await client.models.Song.update();

      // If successful, the response here will be `null`:
      setCurrentSong(updatedSong.data);

      setCurrentImageUrl(updatedSong.data?.coverArtPath);

    } catch (error) 
  }

  // Remove the record association and delete the file
  async function deleteImageForCurrentSong() );

      const song = response?.data;

      // If the record has no associated file, we can return early.
      if (!song?.coverArtPath) return;

      // Remove associated file from record
      const updatedSong = await client.models.Song.update();

      // Delete the file from S3:
      await remove();

      // If successful, the response here will be `null`:
      setCurrentSong(updatedSong.data);

      setCurrentImageUrl(updatedSong.data?.coverArtPath);

    } catch (error) 
  }

  // Delete both file and record
  async function deleteCurrentSongAndImage() );
      const song = response.data;

      // If the record has no associated file, we can return early.
      if (!song?.coverArtPath) return;

      await remove();

      // Delete the record from the API:
      await client.models.Song.delete();

      clearLocalState();

    } catch (error) 
  }

  function clearLocalState() 

  return (
    <>
      <h1>Hello </h1>
      <button onClick=>Sign out</button>
      <div>
        <label>
          <h2>`}</h2>
          Create song with file:
          <input id="name" type="file" onChange= />
        </label>
        <label>
          Add / update song image:
          <input
            id="name"
            type="file"
            onChange=
            disabled=
          />
        </label>
        <button
          onClick=
          disabled=
        >
          Get image for current song
        </button>
        <button
          onClick=
          disabled=
        >
          Remove image from current song (does not delete image)
        </button>
        <button
          onClick=
          disabled=
        >
          Remove image from current song, then delete image
        </button>
        <button onClick= disabled=>
          Delete current song (and image, if it exists)
        </button>
        <button onClick= className="app-button">
          Sign out
        </button>
      </div>
    </>
  );
}

```
</Block>

```ts title="src/App.tsx"

import "./App.css";
import "@aws-amplify/ui-react/styles.css";
import  from "@aws-amplify/ui-react";

Amplify.configure(outputs);

// Generating the client
const client = generateClient();

type PhotoAlbum = Schema["PhotoAlbum"]["type"];

function App(: WithAuthenticatorProps) );

      const photoAlbum = response.data;

      if (!photoAlbum) return;

      // Upload the Storage file:
      const result = await uploadData(-$`,
        data: file,
        options: ,
      }).result;

      const updatePhotoAlbumDetails = ;

      // Add the file association to the record:
      const updateResponse = await client.models.PhotoAlbum.update();

      const updatedPhotoAlbum = updateResponse.data;

      setCurrentPhotoAlbum(updatedPhotoAlbum);

      // If the record has no associated file, we can return early.
      if (!updatedPhotoAlbum?.imagePaths?.length) return;

      // Retrieve the file's signed URL:
      const signedURL = await getUrl();
      setCurrentImages([signedURL.url.toString()]);
    } catch (error) 
  }

  async function createPhotoAlbumWithMultipleImages(
    e: React.ChangeEvent
  ) ;

      // Create the API record:
      const response = await client.models.PhotoAlbum.create();

      const photoAlbum = response.data;

      if (!photoAlbum) return;

      // Upload all files to Storage:
      const imagePaths = await Promise.all(
        Array.from(e.target.files).map(async (file) => -$`,
            data: file,
            options: ,
          }).result;

          return result.path;
        })
      );

      // Add the file association to the record:
      const updateResponse = await client.models.PhotoAlbum.update();
      const updatedPhotoAlbum = updateResponse.data;

      setCurrentPhotoAlbum(updatedPhotoAlbum);

      // If the record has no associated file, we can return early.
      if (!updatedPhotoAlbum?.imagePaths?.length) return;

      // Retrieve signed urls for all files:
      const signedUrls = await Promise.all(
        updatedPhotoAlbum.imagePaths.map(
          async (path) => await getUrl()
        )
      );

      if (!signedUrls) return;
      setCurrentImages(signedUrls.map((signedUrl) => signedUrl.url.toString()));
    } catch (error) 
  }

  async function addNewImagesToPhotoAlbum(
    e: React.ChangeEvent
  ) -$`,
            data: file,
            options: ,
          }).result;

          return result.path;
        })
      );

      // Query existing record to retrieve currently associated files:
      const queriedResponse = await client.models.PhotoAlbum.get();

      const photoAlbum = queriedResponse.data;

      if (!photoAlbum?.imagePaths) return;

      // Merge existing and new file paths:
      const updatedimagePaths = [...newimagePaths, ...photoAlbum.imagePaths];

      // Update record with merged file associations:
      const response = await client.models.PhotoAlbum.update();

      const updatedPhotoAlbum = response.data;
      setCurrentPhotoAlbum(updatedPhotoAlbum);

      // If the record has no associated file, we can return early.
      if (!updatedPhotoAlbum?.imagePaths) return;

      // Retrieve signed urls for merged image paths:
      const signedUrls = await Promise.all(
        updatedPhotoAlbum?.imagePaths.map(
          async (path) => await getUrl()
        )
      );

      if (!signedUrls) return;

      setCurrentImages(signedUrls.map((signedUrl) => signedUrl.url.toString()));
    } catch (error) 
  }

  // Replace last image associated with current photoAlbum:
  async function updateLastImage(e: React.ChangeEvent) -$`,
        data: file,
        options: ,
      }).result;

      const newFilePath = result.path;

      // Query existing record to retrieve currently associated files:
      const queriedResponse = await client.models.PhotoAlbum.get();

      const photoAlbum = queriedResponse.data;

      if (!photoAlbum?.imagePaths?.length) return;

      // Retrieve last image path:
      const [lastImagePath] = photoAlbum.imagePaths.slice(-1);

      // Remove last file association by path
      const updatedimagePaths = [
        ...photoAlbum.imagePaths.filter((path) => path !== lastImagePath),
        newFilePath,
      ];

      // Update record with updated file associations:
      const response = await client.models.PhotoAlbum.update();

      const updatedPhotoAlbum = response.data;

      setCurrentPhotoAlbum(updatedPhotoAlbum);

      // If the record has no associated file, we can return early.
      if (!updatedPhotoAlbum?.imagePaths) return;

      // Retrieve signed urls for merged image paths:
      const signedUrls = await Promise.all(
        updatedPhotoAlbum?.imagePaths.map(
          async (path) => await getUrl()
        )
      );

      if (!signedUrls) return;

      setCurrentImages(signedUrls.map((signedUrl) => signedUrl.url.toString()));
    } catch (error) 
  }

  async function getImagesForPhotoAlbum() 
    try );
      const photoAlbum = response.data;

      // If the record has no associated files, we can return early.
      if (!photoAlbum?.imagePaths) return;

      // Retrieve the signed URLs for the associated images:
      const signedUrls = await Promise.all(
        photoAlbum.imagePaths.map(async (imagePath) => );
        })
      );

      setCurrentImages(
        signedUrls.map((signedUrl) => signedUrl?.url.toString())
      );
    } catch (error) 
  }

  // Remove the file associations, continue to persist both files and record
  async function removeImagesFromPhotoAlbum() );

      const photoAlbum = response.data;

      // If the record has no associated file, we can return early.
      if (!photoAlbum?.imagePaths) return;

      const updatedPhotoAlbum = await client.models.PhotoAlbum.update();

      // If successful, the response here will be `null`:
      setCurrentPhotoAlbum(updatedPhotoAlbum.data);
      setCurrentImages(updatedPhotoAlbum.data?.imagePaths);
    } catch (error) 
  }

  // Remove the record association and delete the file
  async function deleteImagesForCurrentPhotoAlbum() );

      const photoAlbum = response.data;

      // If the record has no associated files, we can return early.
      if (!photoAlbum?.imagePaths) return;

      // Remove associated files from record
      const updateResponse = await client.models.PhotoAlbum.update();

      const updatedPhotoAlbum = updateResponse.data;

      // Delete the files from S3:
      await Promise.all(
        photoAlbum?.imagePaths.map(async (imagePath) => );
        })
      );

      // If successful, the response here will be `null`:
      setCurrentPhotoAlbum(updatedPhotoAlbum);
      setCurrentImages(null);
    } catch (error) 
  }

  // Delete both files and record
  async function deleteCurrentPhotoAlbumAndImages() );

      const photoAlbum = response.data;

      if (!photoAlbum) return;

      await client.models.PhotoAlbum.delete();

      setCurrentPhotoAlbum(null);

      // If the record has no associated file, we can return early.
      if (!photoAlbum?.imagePaths) return;

      await Promise.all(
        photoAlbum?.imagePaths.map(async (imagePath) => );
        })
      );

      clearLocalState();
    } catch (error) 
  }

  function clearLocalState() 

  return (
    <main className="app-container">
      <h1 className="greeting">Hello !</h1>
      <h2 className="current-album">
        Current PhotoAlbum: 
      </h2>

      <div className="file-input-container">
        <label className="file-input-label">
          Create photoAlbum with one file:
          <input
            type="file"
            accept="image/*"
            onChange=
            className="file-input"
          />
        </label>

        <label className="file-input-label">
          Create photoAlbum with multiple files:
          <input
            type="file"
            accept="image/*"
            onChange=
            multiple
            className="file-input"
          />
        </label>

        <label className="file-input-label">
          Add multiple images to current photoAlbum:
          <input
            type="file"
            accept="image/*"
            onChange=
            disabled=
            multiple
            className="file-input"
          />
        </label>

        <label className="file-input-label">
          Replace last image:
          <input
            type="file"
            accept="image/*"
            onChange=
            disabled=
            className="file-input"
          />
        </label>
      </div>

      <div className="button-container">
        <button
          onClick=
          disabled=
          className="app-button"
        >
          Get Images for Current Photo Album
        </button>
        <button
          onClick=
          disabled=
          className="app-button"
        >
          Remove images from current PhotoAlbum (does not delete images)
        </button>
        <button
          onClick=
          disabled=
          className="app-button"
        >
          Remove images from current PhotoAlbum, then delete images
        </button>
        <button
          onClick=
          disabled=
          className="app-button"
        >
          Delete current PhotoAlbum (and images, if they exist)
        </button>
        <button onClick= className="app-button">
          Sign out
        </button>
      </div>

      <div className="image-container">
         key= alt="Storage file" className="image" />
            );
          })}
      </div>
    </main>
  );
}

```
</Block>
</BlockSwitcher>
</InlineFilter>
