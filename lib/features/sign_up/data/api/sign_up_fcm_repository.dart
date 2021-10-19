import '../../../../core/repositories/fcm_repository.dart';

class SignUpFCMRepository extends FCMRepository {
  /// Get the token for this device
  Future<String> getFCMToken() async {
    try {
      final token = (await getToken()) ?? '';
      return token;
    } catch (e) {
      rethrow;
    }
  }
}
