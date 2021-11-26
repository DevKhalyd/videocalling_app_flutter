import 'package:cloud_functions/cloud_functions.dart';

import '../utils/utils.dart';

abstract class CloudFuntionsRepository {
  final functions = FirebaseFunctions.instance;
}

class EmulatorCloudFunctionsRepository extends CloudFuntionsRepository {
  EmulatorCloudFunctionsRepository.init() {
    functions.useFunctionsEmulator(Utils.localHost, 5001);
  }
}
