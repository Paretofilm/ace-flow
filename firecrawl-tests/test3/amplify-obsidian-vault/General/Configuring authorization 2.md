---
title: Configuring authorization
topics: ['General']
primary_topic: General
source: fragments/lib/graphqlapi/ios/working-with-files.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Configuring authorization

The Storage and GraphQL API categories can be used together to associate a file, such as an image or video, with a particular record. For example, you might create a `User` model with a profile picture, or a `Post` model with an associated image. With Amplify's GraphQL API and Storage categories, you can reference the file within the model itself to create an association.

> **Note**: 

For more on the Amplify GraphQL API, see the [API documentation](/gen1/[platform]/prev/build-a-backend/graphqlapi/set-up-graphql-api/). For Storage, see [Storage documentation](/gen1/[platform]/build-a-backend/storage/set-up-storage/). For Auth, see [Auth documentation](/gen1/[platform]/build-a-backend/auth/set-up-auth/)

To get started, go to your project directory and run the command:

```bash
amplify add api
```

Choose the following when prompted:

```bash
? Select from one of the below mentioned services: `GraphQL`
? Choose the default authorization type for the API `Amazon Cognito User Pool`
 Do you want to use the default authentication and security configuration? `Default configuration`
 How do you want users to be able to sign in? `Username`
 Do you want to configure advanced settings? `No, I am done.`
? Here is the GraphQL API that we will create. Select a setting to edit or continue `Continue`
? Choose a schema template: `Blank Schema`
```

When prompted, use the following schema, which can also be found under `amplify/backend/api/[name of project]/schema.graphql`:

```graphql
type Song @model @auth(rules: []) 
```

Add Storage with the command:

```bash
amplify add storage
```

Choose the following when prompted:

```bash
? Select from one of the below mentioned services: `Content (Images, audio, video, etc.)`
✔ Who should have access: `Auth users only`
✔ What kind of access do you want for Authenticated users? `create/update, read, delete`
✔ Do you want to add a Lambda Trigger for your S3 Bucket? (y/N) · `no`
```

Run `amplify push` to deploy the changes.

Once the backend has been provisioned, run `amplify codegen models` to generate the Swift model types for the app.

Next, add the Amplify(`https://github.com/aws-amplify/amplify-swift.git`) package to your Xcode project and select the following modules to import when prompted:

- AWSAPIPlugin
- AWSCognitoAuthPlugin
- AWSS3StoragePlugin
- Amplify

Add the Authenticator from Amplify UI Authenticator for SwiftUI (`https://github.com/aws-amplify/amplify-ui-swift-authenticator.git`)

> **Note**: 

For the complete working example, including required imports, obtaining the file from the user, and SwiftUI components, see the [Complete Example](#complete-example) below.

## Configuring authorization

Your application needs authorization credentials for reading and writing to both Storage and the GraphQL API, except in the case where all data and files are intended to be publicly accessible.

The Storage and API categories govern data access based on their own authorization patterns, meaning that it's necessary to configure appropriate auth roles for each individual category. Although both categories share the same access credentials set up through the Auth category, they work independently from one another. For instance, adding an `@auth` directive to the API schema does not guard against file access in the Storage category. Likewise, adding authorization rules to the Storage category does not guard against data access in the API category.

When you run `amplify add storage`, the CLI will configure appropriate IAM policies on the bucket using a Cognito Identity Pool role. You will then have the option of adding CRUD (Create, Update, Read and Delete) based permissions as well, so that Authenticated and Guest users will be granted limited permissions within these levels. **Even after adding this configuration via the CLI, all Storage access is still `public` by default.** To guard against accidental public access, the Storage access levels must either be configured globally in the configuration, or set within individual method calls. This guide uses the latter approach, setting Storage access to `private` per method call.

The ability to independently configure authorization rules for each category allows for more granular control over data access, and adds greater flexibility. For scenarios where authorization patterns must be mixed and matched, configure the access level on individual Storage method calls. For example, you may want to use `private` CRUD access on an individual Storage method call for files that should only be accessible by the owner (such as personal files), `protected` read access to allow all logged in users to view common files (such as images in a shared photo album), and `public` read access to allow all users to view a file (such as a public profile picture).

For more details on how to configure Storage authorization levels, see the [Storage documentation](/gen1/[platform]/build-a-backend/storage/configure-access/). For more on configuring GraphQL API authorization, see the [API documentation](/gen1/[platform]/build-a-backend/graphqlapi/customize-authorization-rules).

## Create a record with an associated file

First create a record via the GraphQL API, then upload the file to Storage, and finally add the association between the record and file. Use the following example with the GraphQL API and Storage categories to create a record and associate the file with the record.

> **Note**: 

Make sure that the file key used for Storage is unique. In this case, the API record's `id` is used as the file key for Storage to ensure uniqueness so that multiple API records will not be associated with the same file key unintentionally. However, this may not be true if the API record's `id` is customized to be a combination of two or more fields, or a different primary key field is used.

```swift
let song = Song(name: name)

guard let imageData = artCover.pngData() else 

// Create the song record
let result = try await Amplify.API.mutate(request: .create(song))
guard case .success(var createdSong) = result else 

// Upload the art cover image
_ = try await Amplify.Storage.uploadData(key: createdSong.id,
                                         data: imageData,
                                         options: .init(accessLevel: .private)).value

// Update the song record with the image key
createdSong.coverArtKey = createdSong.id
let updateResult = try await Amplify.API.mutate(request: .update(createdSong))
guard case .success(let updatedSong) = updateResult else 
```

## Add or update a file for an associated record

To associate a new or different file with the record, update the existing record with the file key. The following example uploads the file using Storage and updates the record with the file's key. If an image is already associated with the record, this will update the record with the new image.

```swift
// Upload the new art image
_ = try await Amplify.Storage.uploadData(key: currentSong.id,
                                         data: imageData,
                                         options: .init(accessLevel: .private)).value

// Update the song record
currentSong.coverArtKey = currentSong.id
let result = try await Amplify.API.mutate(request: .update(currentSong))
guard case .success(let updatedSong) = result else 
```

## Query a record and retrieve the associated file

To retrieve the file associated with a record, first query the record, then use Storage to download the data to display an image:

```swift
// Get the song record
let result = try await Amplify.API.query(request: .get(Song.self, byIdentifier: currentSong.id))
guard case .success(let queriedSong) = result else 
guard let song = queriedSong else 

guard let coverArtKey = song.coverArtKey else 

// Download the art cover
let imageData = try await Amplify.Storage.downloadData(key: coverArtKey,
                                                       options: .init(accessLevel: .private)).value
let image = UIImage(data: imageData)
```

## Delete and remove files associated with API records

There are three common deletion workflows when working with Storage files and the GraphQL API:

1. Remove the file association, continue to persist both file and record.
2. Remove the file association and delete the file.
3. Delete both file and record.

### Remove the file association, continue to persist both file and record

The following example removes the file association from the record, but does not delete the file from S3 or the record from the DynamoDB instance.

```swift
// Get the song record
let result = try await Amplify.API.mutate(request: .get(Song.self, byIdentifier: currentSong.id))
guard case .success(let queriedSong) = result else 
guard var song = queriedSong else 
guard song.coverArtKey != nil else 

// Set the association to nil and update it
song.coverArtKey = nil
let updateResult = try await Amplify.API.mutate(request: .update(song))
guard case .success(let updatedSong) = updateResult else 
```

### Remove the file association and delete the file

The following example removes the file from the record, then deletes the file from S3:

```swift
// Get the song record
let result = try await Amplify.API.query(request: .get(Song.self, byIdentifier: currentSong.id))
guard case .success(let queriedSong) = result else 
guard var song = queriedSong else 
guard let coverArtKey = song.coverArtKey else 

// Set the association to nil and update it
song.coverArtKey = nil
let updateResult = try await Amplify.API.mutate(request: .update(song))
guard case .success(let updatedSong) = updateResult else 

// Remove the image
try await Amplify.Storage.remove(key: coverArtKey,
                                 options: .init(accessLevel: .private))
```

### Delete both file and record

The following example deletes the record from DynamoDB and then deletes the file from S3:

```swift
// Get the song record
let result = try await Amplify.API.mutate(request: .get(Song.self, byIdentifier: currentSong.id))
guard case .success(let queriedSong) = result else 
guard let song = queriedSong else 

if let coverArt = song.coverArtKey 

// Delete the song record
let deleteResult = try await Amplify.API.mutate(request: .delete(song))
guard case .success = deleteResult else 
```

## Working with multiple files

You may want to add multiple files to a single record, such as a user profile with multiple images. To do this, you can add a list of file keys to the record. The following example adds a list of file keys to a record:

### GraphQL schema to associate a data model with multiple files

When prompted after running `amplify add api` use the following schema, which can also be found under `amplify/backend/api/[name of project]/schema.graphql`:

```graphql
type PhotoAlbum @model @auth(rules: []) 
```

CRUD operations when working with multiple files is the same as when working with a single file, with the exception that we are now working with a list of image keys, as opposed to a single image key.

### Create a record with multiple associated files

First create a record via the GraphQL API, then upload the files to Storage, and finally add the associations between the record and files.

```swift
// Create the photo album record
let album = PhotoAlbum(name: name)
let result = try await Amplify.API.mutate(request: .create(album))
guard case .success(var createdAlbum) = result else 

// Upload the photo album images
let imageKeys = await withTaskGroup(of: String?.self)  catch 
        }
    }

    var imageKeys: [String?] = []
    for await imageKey in group 
    return imageKeys.compactMap 
}

// Update the album with the image keys
createdAlbum.imageKeys = imageKeys
let updateResult = try await Amplify.API.mutate(request: .update(createdAlbum))
guard case .success(let updatedAlbum) = updateResult else 
```

### Create a record with a single associated file

When a schema allows for multiple associated images, you can still create a record with a single associated file.

```swift
// Create the photo album record
let album = PhotoAlbum(name: name)
let result = try await Amplify.API.mutate(request: .create(album))
guard case .success(var createdAlbum) = result else 

// Upload the photo album image
let key = "\(album.id)-\(UUID().uuidString)"
_ = try await Amplify.Storage.uploadData(key: key,
                                         data: imageData,
                                         options: .init(accessLevel: .private)).value

// Update the album with the image key
createdAlbum.imageKeys = [key]
let updateResult = try await Amplify.API.mutate(request: .update(createdAlbum))
guard case .success(let updatedAlbum) = updateResult else 
```

### Add new files to an associated record

To associate additional files with a record, update the record with the keys returned by the Storage uploads.

```swift
// Upload the new photo album image
let key = "\(currentAlbum.id)-\(UUID().uuidString)"
_ = try await Amplify.Storage.uploadData(key: key,
                                          data: imageData,
                                          options: .init(accessLevel: .private)).value

// Get the latest album
let result = try await Amplify.API.query(request: .get(PhotoAlbum.self, byIdentifier: currentAlbum.id))
guard case .success(let queriedAlbum) = result else 
guard var album = queriedAlbum else 

guard var imageKeys = album.imageKeys else 

// Add new to the existing keys
imageKeys.append(key)

// Update the album with the image keys
album.imageKeys = imageKeys
let updateResult = try await Amplify.API.mutate(request: .update(album))
guard case .success(let updatedAlbum) = updateResult else 
```

### Update the file for an associated record

Updating a file for an associated record is the same as updating a file for a single file record, with the exception that you will need to update the list of file keys. The following replaces the last image in the album with a new image.

```swift
// Upload the new photo album image
let key = "\(currentAlbum.id)-\(UUID().uuidString)"
_ = try await Amplify.Storage.uploadData(key: key,
                                         data: imageData,
                                         options: .init(accessLevel: .private)).value

// Update the album with the image keys
var album = currentAlbum
if var imageKeys = album.imageKeys  else 
let updateResult = try await Amplify.API.mutate(request: .update(album))
guard case .success(let updatedAlbum) = updateResult else 
```

### Query a record and retrieve the associated files

To retrieve the files associated with a record, first query the record, then use Storage to retrieve all the images.

```swift
// Get the song record
let result = try await Amplify.API.query(request: .get(PhotoAlbum.self, byIdentifier: currentAlbum.id))
guard case .success(let queriedAlbum) = result else 
guard let album = queriedAlbum else 

guard let imageKeysOptional = album.imageKeys else 
let imageKeys = imageKeysOptional.compactMap 

// Download the photos
let images = await withTaskGroup(of: UIImage?.self)  catch 
        }
    }

    var images: [UIImage?] = []
    for await image in group 
    return images.compactMap 
}
```

### Delete and remove files associated with API records

The workflow for deleting and removing files associated with API records is the same as when working with a single file, except that when performing a delete you will need to iterate over the list of files keys and call `Storage.remove()` for each file.

#### Remove the file association, keep the persisted file and record

```swift
// Get the album record
let result = try await Amplify.API.mutate(request: .get(PhotoAlbum.self, byIdentifier: currentAlbum.id))
guard case .success(let queriedAlbum) = result else 
guard var album = queriedAlbum else 
guard let imageKeys = album.imageKeys, !imageKeys.isEmpty else 

// Set the association to nil and update it
album.imageKeys = nil
let updateResult = try await Amplify.API.mutate(request: .update(album))
guard case .success(let updatedAlbum) = updateResult else 
```

#### Remove the file association and delete the files

```swift
// Get the album record
let result = try await Amplify.API.query(request: .get(PhotoAlbum.self, byIdentifier: currentAlbum.id))
guard case .success(let queriedAlbum) = result else 
guard let album = queriedAlbum else 

guard let imageKeysOptional = album.imageKeys else 
let imageKeys = imageKeysOptional.compactMap 

// Set the associations to nil and update it
album.imageKeys = nil
let updateResult = try await Amplify.API.mutate(request: .update(album))
guard case .success(let updatedAlbum) = updateResult else 

// Remove the photos
await withTaskGroup(of: Void.self)  catch 
        }
    }

    for await _ in group 
}
```

#### Delete the record and all associated files

```swift
// Get the album record
let result = try await Amplify.API.query(request: .get(PhotoAlbum.self, byIdentifier: currentAlbum.id))
guard case .success(let queriedAlbum) = result else 
guard let album = queriedAlbum else 

guard let imageKeysOptional = album.imageKeys else 
    return
}
let imageKeys = imageKeysOptional.compactMap 

// Remove the photos
await withTaskGroup(of: Void.self)  catch 
        }
    }

    for await _ in group 

}

// Delete the album record
let deleteResult = try await Amplify.API.mutate(request: .delete(album))
guard case .success = deleteResult else 
```

## Data consistency when working with records and files

The access patterns in this guide attempt to remove deleted files, but favor leaving orphans over leaving records that point to non-existent files. This optimizes for read latency by ensuring clients _rarely_ attempt to fetch a non-existent file from Storage. However, any app that deletes files can inherently cause records _on-device_ to point to non-existent files.

One example is when we [create an API record, associate the Storage file with that record](#create-a-record-with-an-associated-file). "Device A" calls the GraphQL API to create `API_Record_1`, and then associates that record with `First_Photo`. Later, when "Device A" is about to retrieve the file, "Device B" might query `API_Record_1`, delete `First_Photo`, and update the record accordingly. However, "Device A" is still using the old `API_Record_1`, which is now out-of-date. Even though the shared global state is correctly in sync at every stage, the individual device ("Device A") has an out-of-date record that points to a non-existent file. Similar issues can conceivably occur for updates. Depending on your app, some of these mismatches can be minimized _even more_ with [real-time data / GraphQL subscriptions](/gen1/[platform]/build-a-backend/graphqlapi/subscribe-data/).

It is important to understand when these mismatches can occur and to add meaningful error handling around these cases. This guide does not include exhaustive error handling, real-time subscriptions, re-querying of outdated records, or attempts to retry failed operations. However, these are all important considerations for a production-level application.

## Complete examples

```swift
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

```swift
import SwiftUI
import Amplify

class SongViewModel: ObservableObject 
        }
        let song = Song(name: name)

        guard let imageData = artCover.pngData() else 

        // Create the song record
        let result = try await Amplify.API.mutate(request: .create(song))
        guard case .success(var createdSong) = result else 

        // Upload the art cover image
        _ = try await Amplify.Storage.uploadData(key: createdSong.id,
                                                 data: imageData,
                                                 options: .init(accessLevel: .private)).value

        // Update the song record with the image key
        createdSong.coverArtKey = createdSong.id
        let updateResult = try await Amplify.API.mutate(request: .update(createdSong))
        guard case .success(let updatedSong) = updateResult else 

        await setCurrentSong(updatedSong)
    }

    // Add or update an image for an associated record
    func updateArtCover(artCover: UIImage) async throws 
        }

        guard var currentSong = currentSong else 
        guard let imageData = artCover.pngData() else 

        // Upload the new art image
        _ = try await Amplify.Storage.uploadData(key: currentSong.id,
                                                 data: imageData,
                                                 options: .init(accessLevel: .private)).value

        // Update the song record
        currentSong.coverArtKey = currentSong.id
        let result = try await Amplify.API.mutate(request: .update(currentSong))
        guard case .success(let updatedSong) = result else 

        await setCurrentSong(updatedSong)
    }

    func refreshSongAndArtCover() async throws 
        }
        guard let currentSong = currentSong else 
        await setCurrentSong(nil)
        await setCurrentImage(nil)

        // Get the song record
        let result = try await Amplify.API.query(request: .get(Song.self, byIdentifier: currentSong.id))
        guard case .success(let queriedSong) = result else 
        guard let song = queriedSong else 

        guard let coverArtKey = song.coverArtKey else 

        // Download the art cover
        let imageData = try await Amplify.Storage.downloadData(key: coverArtKey,
                                                               options: .init(accessLevel: .private)).value
        let image = UIImage(data: imageData)
        await setCurrentSong(song)
        await setCurrentImage(image)
    }

    func removeImageAssociationFromSong() async throws 
        }
        guard let currentSong = currentSong else 

        // Get the song record
        let result = try await Amplify.API.mutate(request: .get(Song.self, byIdentifier: currentSong.id))
        guard case .success(let queriedSong) = result else 
        guard var song = queriedSong else 
        guard song.coverArtKey != nil else 

        // Set the association to nil and update it
        song.coverArtKey = nil
        let updateResult = try await Amplify.API.mutate(request: .update(song))
        guard case .success(let updatedSong) = updateResult else 

        await setCurrentSong(updatedSong)
    }

    func removeImageAssociationAndDeleteImage() async throws 
        }
        guard let currentSong = currentSong else 

        // Get the song record
        let result = try await Amplify.API.query(request: .get(Song.self, byIdentifier: currentSong.id))
        guard case .success(let queriedSong) = result else 
        guard var song = queriedSong else 
        guard let coverArtKey = song.coverArtKey else 

        // Set the association to nil and update it
        song.coverArtKey = nil
        let updateResult = try await Amplify.API.mutate(request: .update(song))
        guard case .success(let updatedSong) = updateResult else 

        // Remove the image
        try await Amplify.Storage.remove(key: coverArtKey,
                                         options: .init(accessLevel: .private))

        await setCurrentSong(updatedSong)
        await setCurrentImage(nil)
    }

    func deleteSongAndArtCover() async throws 
        }
        guard let currentSong = currentSong else 

        // Get the song record
        let result = try await Amplify.API.mutate(request: .get(Song.self, byIdentifier: currentSong.id))
        guard case .success(let queriedSong) = result else 
        guard let song = queriedSong else 

        if let coverArt = song.coverArtKey 

        // Delete the song record
        let deleteResult = try await Amplify.API.mutate(request: .delete(song))
        guard case .success = deleteResult else 
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

```swift
import SwiftUI
import Amplify
import Photos

class PhotoAlbumViewModel: ObservableObject 
        }

        let imagesData = photos.compactMap 
        guard !imagesData.isEmpty else 

        // Create the photo album record
        let album = PhotoAlbum(name: name)
        let result = try await Amplify.API.mutate(request: .create(album))
        guard case .success(var createdAlbum) = result else 

        // Upload the photo album images
        let imageKeys = await withTaskGroup(of: String?.self)  catch 
                }
            }

            var imageKeys: [String?] = []
            for await imageKey in group 
            return imageKeys.compactMap 
        }

        // Update the album with the image keys
        createdAlbum.imageKeys = imageKeys
        let updateResult = try await Amplify.API.mutate(request: .update(createdAlbum))
        guard case .success(let updatedAlbum) = updateResult else 

        await setCurrentAlbum(updatedAlbum)
    }

    // Create a record with a single associated file
    func createPhotoAlbum(name: String, photo: UIImage) async throws 
        }

        guard let imageData = photo.pngData() else 

        // Create the photo album record
        let album = PhotoAlbum(name: name)
        let result = try await Amplify.API.mutate(request: .create(album))
        guard case .success(var createdAlbum) = result else 

        // Upload the photo album image
        let key = "\(album.id)-\(UUID().uuidString)"
        _ = try await Amplify.Storage.uploadData(key: key,
                                                 data: imageData,
                                                 options: .init(accessLevel: .private)).value

        // Update the album with the image key
        createdAlbum.imageKeys = [key]
        let updateResult = try await Amplify.API.mutate(request: .update(createdAlbum))
        guard case .success(let updatedAlbum) = updateResult else 

        await setCurrentAlbum(updatedAlbum)
    }

    // Add new file to an associated record
    func addAdditionalPhotos(_ photo: UIImage) async throws 
        }

        guard let currentAlbum = currentAlbum else 

        guard let imageData = photo.pngData() else 

        // Upload the new photo album image
        let key = "\(currentAlbum.id)-\(UUID().uuidString)"
        _ = try await Amplify.Storage.uploadData(key: key,
                                                 data: imageData,
                                                 options: .init(accessLevel: .private)).value

        // Get the latest album
        let result = try await Amplify.API.query(request: .get(PhotoAlbum.self, byIdentifier: currentAlbum.id))
        guard case .success(let queriedAlbum) = result else 
        guard var album = queriedAlbum else 

        guard var imageKeys = album.imageKeys else 

        // Add new to the existing keys
        imageKeys.append(key)

        // Update the album with the image keys
        album.imageKeys = imageKeys
        let updateResult = try await Amplify.API.mutate(request: .update(album))
        guard case .success(let updatedAlbum) = updateResult else 

        await setCurrentAlbum(updatedAlbum)
    }

    func replaceLastImage(_ photo: UIImage) async throws 
        }

        guard let currentAlbum = currentAlbum else 

        guard let imageData = photo.pngData() else 

        // Upload the new photo album image
        let key = "\(currentAlbum.id)-\(UUID().uuidString)"
        _ = try await Amplify.Storage.uploadData(key: key,
                                                 data: imageData,
                                                 options: .init(accessLevel: .private)).value

        // Update the album with the image keys
        var album = currentAlbum
        if var imageKeys = album.imageKeys  else 
        let updateResult = try await Amplify.API.mutate(request: .update(album))
        guard case .success(let updatedAlbum) = updateResult else 

        await setCurrentAlbum(updatedAlbum)
    }

    // Query a record and retrieve the associated files
    func refreshAlbumAndPhotos() async throws 
        }
        guard let currentAlbum = currentAlbum else 
        await setCurrentAlbum(nil)
        await setCurrentImages([])

        // Get the song record
        let result = try await Amplify.API.query(request: .get(PhotoAlbum.self, byIdentifier: currentAlbum.id))
        guard case .success(let queriedAlbum) = result else 
        guard let album = queriedAlbum else 

        guard let imageKeysOptional = album.imageKeys else 
        let imageKeys = imageKeysOptional.compactMap 

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
        let result = try await Amplify.API.mutate(request: .get(PhotoAlbum.self, byIdentifier: currentAlbum.id))
        guard case .success(let queriedAlbum) = result else 
        guard var album = queriedAlbum else 
        guard let imageKeys = album.imageKeys, !imageKeys.isEmpty else 

        // Set the association to nil and update it
        album.imageKeys = nil
        let updateResult = try await Amplify.API.mutate(request: .update(album))
        guard case .success(let updatedAlbum) = updateResult else 

        await setCurrentAlbum(updatedAlbum)
    }

    // Remove the record association and delete the files
    func removeStorageAssociationsAndDeletePhotos() async throws 
        }

        guard let currentAlbum = currentAlbum else 

        // Get the album record
        let result = try await Amplify.API.query(request: .get(PhotoAlbum.self, byIdentifier: currentAlbum.id))
        guard case .success(let queriedAlbum) = result else 
        guard var album = queriedAlbum else 

        guard let imageKeysOptional = album.imageKeys else 
        let imageKeys = imageKeysOptional.compactMap 

        // Set the associations to nil and update it
        album.imageKeys = nil
        let updateResult = try await Amplify.API.mutate(request: .update(album))
        guard case .success(let updatedAlbum) = updateResult else 

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
        let result = try await Amplify.API.query(request: .get(PhotoAlbum.self, byIdentifier: currentAlbum.id))
        guard case .success(let queriedAlbum) = result else 
        guard let album = queriedAlbum else 

        guard let imageKeysOptional = album.imageKeys else 

            await setCurrentAlbum(nil)
            await setCurrentImages([])
            return
        }
        let imageKeys = imageKeysOptional.compactMap 

        // Remove the photos
        await withTaskGroup(of: Void.self)  catch 
                }
            }

            for await _ in group 
        }

        // Delete the album record
        let deleteResult = try await Amplify.API.mutate(request: .delete(album))
        guard case .success = deleteResult else 

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


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/graphqlapi/ios/working-with-files.mdx`