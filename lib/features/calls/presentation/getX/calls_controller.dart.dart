import 'package:get/get.dart';

import '../../../home/presentation/getX/home_controller.dart';
import '../../domain/models/history_call.dart';
import '../../domain/usecases/get_history_calls.dart';

class CallsController extends GetxController {
  final idUser = HomeController.to.user?.id;
  Stream<List<HistoryCall>> get historyCalls =>
      GetHistoryCalls.execute(idUser!);
}
