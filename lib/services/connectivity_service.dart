import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  RxBool haveConnection = true.obs;
  Future init() async {
    final result = await _connectivity.checkConnectivity();
    resultHandler(result);

    _connectivity.onConnectivityChanged.listen((result) {
      resultHandler(result);
    });
    return this;
  }

  resultHandler(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      haveConnection.value = false;
    } else {
      haveConnection.value = true;
    }
  }
}
