import 'package:cloud_functions/cloud_functions.dart';

abstract class CloudFuntionsRepository {
  final functions = FirebaseFunctions.instance;
}

class EmulatorCloudFunctionsRepository extends CloudFuntionsRepository {
  EmulatorCloudFunctionsRepository.init() {
    functions.useFunctionsEmulator('localhost', 5001);
  }
}
