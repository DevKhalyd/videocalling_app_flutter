import '../../../../core/shared/models/user/user.dart';
import '../../data/api/home_firestore_repository.dart';

abstract class UpdateImageUrl {
  /// Updates the url in the user data
  static Future<void> execute({
    required String id,
    required String url,
  }) async {
    try {
      final repo = HomeFirestoreRepository();
      await repo.updateUserData(id, User.imageUrlField, url);
    } catch (e) {
      rethrow;
    }
  }
}
