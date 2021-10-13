import '../../../../core/shared/models/user/user.dart';
import '../../../../core/utils/utils.dart';
import '../../data/api/home_firestore_repository.dart';

abstract class GetUsersByUsername {
  /// Read the documentation about this method
  static Stream<List<User>> execute({
    required String username,
    required String thisUsername,
  }) {
    try {
      final repo = HomeFirestoreRepository();
      return repo.getUsersByUsername(username, thisUsername);
    } catch (e) {
      Utils.printACatch('GetUsersByUsername Stream', e);
      return Stream.empty();
    }
  }
}
