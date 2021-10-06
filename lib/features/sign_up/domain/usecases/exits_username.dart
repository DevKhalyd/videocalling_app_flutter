import 'package:videocalling_app/features/sign_up/data/api/sign_up_firestore_repository.dart';

abstract class ExistsUsername {
  static Future<bool?> execute({required String username}) async {
    final repo = SignUpFirestoreRepository();
    try {
      return await repo.getUsername(username);
    } catch (e) {
      return null;
    }
  }
}
