import 'package:get/get.dart';
import 'package:sokketnetwork/models/btc_usd_model.dart';
import 'package:sokketnetwork/services/socket_service.dart';

class HomeController extends GetxController {
  String response = 'No data';
  Bitcoin? bitcoin;

  _initSocketService() {
    SocketService.connectServer();

    SocketService.channel.stream.listen((event) {
      response = event.toString();
      bitcoin = bitcoinFromJson(response);
      update();
    }, onError: (error) {
      response = error.toString();
      update();
    });
  }

  @override
  void onInit() {
    _initSocketService();
    super.onInit();
  }

  @override
  void onClose() {
    SocketService.closeSocketChanel();
    super.onClose();
  }
}
