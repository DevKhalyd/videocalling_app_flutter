import '../../../../core/utils/utils.dart';
import '../../data/api/sign_up_fcm_repository.dart';

abstract class GetFCMToken {
  /// Get the current token of this user
  static Future<String> execute() async {
    try {
      final repo = SignUpFCMRepository();
      return await repo.getFCMToken();
    } catch (e) {
      Utils.printACatch('GetFCMToken', e);
      return '';
    }
  }
}
