import '../../../../core/shared/models/user/user.dart';
import '../../../../core/utils/utils.dart';
import '../../data/api/home_firestore_repository.dart';

abstract class GetUsersByUsername {
  static Stream<List<User>> execute(String username) {
    try {
      final repo = HomeFirestoreRepository();
      return repo.getUsersByUsername(username);
    } catch (e) {
      Utils.printACatch('GetUsersByUsername Stream', e);
      return Stream.empty();
    }
  }
}
