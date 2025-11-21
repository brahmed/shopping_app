import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

/// Firebase Storage service for uploading and managing files
class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  final Uuid _uuid = const Uuid();

  // Storage paths
  static const String productImagesPath = 'product-images';
  static const String userAvatarsPath = 'user-avatars';
  static const String reviewImagesPath = 'review-images';
  static const String categoryImagesPath = 'category-images';

  // ==========================================================================
  // IMAGE PICKER
  // ==========================================================================

  /// Pick image from gallery
  Future<XFile?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      return image;
    } catch (e) {
      debugPrint('❌ Pick image error: $e');
      return null;
    }
  }

  /// Pick image from camera
  Future<XFile?> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      return image;
    } catch (e) {
      debugPrint('❌ Capture image error: $e');
      return null;
    }
  }

  /// Pick multiple images
  Future<List<XFile>> pickMultipleImages({int maxImages = 5}) async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (images.length > maxImages) {
        return images.sublist(0, maxImages);
      }

      return images;
    } catch (e) {
      debugPrint('❌ Pick multiple images error: $e');
      return [];
    }
  }

  // ==========================================================================
  // UPLOAD OPERATIONS
  // ==========================================================================

  /// Upload product image
  Future<String?> uploadProductImage(
    String productId,
    XFile imageFile, {
    UploadProgressCallback? onProgress,
  }) async {
    try {
      final fileName = '${_uuid.v4()}${path.extension(imageFile.path)}';
      final ref = _storage.ref().child('$productImagesPath/$productId/$fileName');

      final uploadTask = ref.putFile(
        File(imageFile.path),
        SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {
            'uploadedAt': DateTime.now().toIso8601String(),
          },
        ),
      );

      if (onProgress != null) {
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          final progress = snapshot.bytesTransferred / snapshot.totalBytes;
          onProgress(progress);
        });
      }

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      debugPrint('✅ Product image uploaded: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      debugPrint('❌ Upload product image error: $e');
      return null;
    }
  }

  /// Upload user avatar
  Future<String?> uploadUserAvatar(
    String userId,
    XFile imageFile, {
    UploadProgressCallback? onProgress,
  }) async {
    try {
      final fileName = 'avatar${path.extension(imageFile.path)}';
      final ref = _storage.ref().child('$userAvatarsPath/$userId/$fileName');

      final uploadTask = ref.putFile(
        File(imageFile.path),
        SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {
            'uploadedAt': DateTime.now().toIso8601String(),
          },
        ),
      );

      if (onProgress != null) {
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          final progress = snapshot.bytesTransferred / snapshot.totalBytes;
          onProgress(progress);
        });
      }

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      debugPrint('✅ User avatar uploaded: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      debugPrint('❌ Upload user avatar error: $e');
      return null;
    }
  }

  /// Upload review images
  Future<List<String>> uploadReviewImages(
    String userId,
    String reviewId,
    List<XFile> imageFiles, {
    UploadProgressCallback? onProgress,
  }) async {
    final urls = <String>[];

    for (var i = 0; i < imageFiles.length; i++) {
      try {
        final fileName = 'image_$i${path.extension(imageFiles[i].path)}';
        final ref = _storage
            .ref()
            .child('$reviewImagesPath/$userId/$reviewId/$fileName');

        final uploadTask = ref.putFile(
          File(imageFiles[i].path),
          SettableMetadata(
            contentType: 'image/jpeg',
            customMetadata: {
              'uploadedAt': DateTime.now().toIso8601String(),
            },
          ),
        );

        if (onProgress != null) {
          uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
            final progress =
                (i + snapshot.bytesTransferred / snapshot.totalBytes) /
                    imageFiles.length;
            onProgress(progress);
          });
        }

        final snapshot = await uploadTask;
        final downloadUrl = await snapshot.ref.getDownloadURL();
        urls.add(downloadUrl);
      } catch (e) {
        debugPrint('❌ Upload review image $i error: $e');
      }
    }

    debugPrint('✅ Review images uploaded: ${urls.length}');
    return urls;
  }

  /// Upload category image
  Future<String?> uploadCategoryImage(
    String categoryId,
    XFile imageFile, {
    UploadProgressCallback? onProgress,
  }) async {
    try {
      final fileName = 'banner${path.extension(imageFile.path)}';
      final ref = _storage.ref().child('$categoryImagesPath/$categoryId/$fileName');

      final uploadTask = ref.putFile(
        File(imageFile.path),
        SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {
            'uploadedAt': DateTime.now().toIso8601String(),
          },
        ),
      );

      if (onProgress != null) {
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          final progress = snapshot.bytesTransferred / snapshot.totalBytes;
          onProgress(progress);
        });
      }

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      debugPrint('✅ Category image uploaded: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      debugPrint('❌ Upload category image error: $e');
      return null;
    }
  }

  /// Generic file upload
  Future<String?> uploadFile(
    String storagePath,
    XFile file, {
    UploadProgressCallback? onProgress,
    Map<String, String>? customMetadata,
  }) async {
    try {
      final ref = _storage.ref().child(storagePath);

      final metadata = SettableMetadata(
        contentType: _getContentType(file.path),
        customMetadata: {
          'uploadedAt': DateTime.now().toIso8601String(),
          ...?customMetadata,
        },
      );

      final uploadTask = ref.putFile(File(file.path), metadata);

      if (onProgress != null) {
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          final progress = snapshot.bytesTransferred / snapshot.totalBytes;
          onProgress(progress);
        });
      }

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      debugPrint('✅ File uploaded: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      debugPrint('❌ Upload file error: $e');
      return null;
    }
  }

  // ==========================================================================
  // DELETE OPERATIONS
  // ==========================================================================

  /// Delete file by URL
  Future<bool> deleteFileByUrl(String downloadUrl) async {
    try {
      final ref = _storage.refFromURL(downloadUrl);
      await ref.delete();
      debugPrint('✅ File deleted');
      return true;
    } catch (e) {
      debugPrint('❌ Delete file error: $e');
      return false;
    }
  }

  /// Delete file by path
  Future<bool> deleteFile(String storagePath) async {
    try {
      final ref = _storage.ref().child(storagePath);
      await ref.delete();
      debugPrint('✅ File deleted');
      return true;
    } catch (e) {
      debugPrint('❌ Delete file error: $e');
      return false;
    }
  }

  /// Delete folder
  Future<bool> deleteFolder(String folderPath) async {
    try {
      final ref = _storage.ref().child(folderPath);
      final result = await ref.listAll();

      for (final item in result.items) {
        await item.delete();
      }

      for (final prefix in result.prefixes) {
        await deleteFolder(prefix.fullPath);
      }

      debugPrint('✅ Folder deleted');
      return true;
    } catch (e) {
      debugPrint('❌ Delete folder error: $e');
      return false;
    }
  }

  // ==========================================================================
  // DOWNLOAD OPERATIONS
  // ==========================================================================

  /// Get download URL
  Future<String?> getDownloadUrl(String storagePath) async {
    try {
      final ref = _storage.ref().child(storagePath);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      debugPrint('❌ Get download URL error: $e');
      return null;
    }
  }

  /// Get file metadata
  Future<FullMetadata?> getMetadata(String storagePath) async {
    try {
      final ref = _storage.ref().child(storagePath);
      final metadata = await ref.getMetadata();
      return metadata;
    } catch (e) {
      debugPrint('❌ Get metadata error: $e');
      return null;
    }
  }

  // ==========================================================================
  // LIST OPERATIONS
  // ==========================================================================

  /// List files in folder
  Future<List<Reference>> listFiles(String folderPath) async {
    try {
      final ref = _storage.ref().child(folderPath);
      final result = await ref.listAll();
      return result.items;
    } catch (e) {
      debugPrint('❌ List files error: $e');
      return [];
    }
  }

  /// List folders
  Future<List<Reference>> listFolders(String folderPath) async {
    try {
      final ref = _storage.ref().child(folderPath);
      final result = await ref.listAll();
      return result.prefixes;
    } catch (e) {
      debugPrint('❌ List folders error: $e');
      return [];
    }
  }

  // ==========================================================================
  // HELPER METHODS
  // ==========================================================================

  /// Get content type from file extension
  String _getContentType(String filePath) {
    final extension = path.extension(filePath).toLowerCase();
    switch (extension) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.gif':
        return 'image/gif';
      case '.webp':
        return 'image/webp';
      case '.pdf':
        return 'application/pdf';
      default:
        return 'application/octet-stream';
    }
  }

  /// Format file size
  String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}

/// Upload progress callback
typedef UploadProgressCallback = void Function(double progress);
