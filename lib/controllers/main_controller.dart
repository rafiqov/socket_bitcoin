import 'dart:convert';

import 'package:get/get.dart';
import 'package:sokketnetwork/models/btc_usd_model.dart';
import 'package:sokketnetwork/services/socket_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MainController extends GetxController {
  var chartData = <Bitcoin>[].obs;
  var zoomPanBehavior = ZoomPanBehavior().obs;
  var tooltipBehavior = TooltipBehavior().obs;

  @override
  void onInit() {
    // chartData.bindStream(btc);
    btc();
    zoomPanBehavior = ZoomPanBehavior(enablePinching: true).obs;
    tooltipBehavior = TooltipBehavior(enable: true, header: 'Bitcoin').obs;
    SocketService.connectServer();
    super.onInit();
  }

  @override
  void onClose() {
    SocketService.closeSocketChanel();
    super.onClose();
  }

  void btc() {
    SocketService.channel.stream.listen((event) {
      var item = jsonDecode(event);
      if(item['data'].isNotEmpty){
        chartData.value.add( Bitcoin.fromJson(item));
        Get.log(chartData.value.toString());
      }

    });


  }
}
