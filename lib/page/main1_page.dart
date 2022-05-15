import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokketnetwork/controllers/main_controller.dart';
import 'package:sokketnetwork/models/btc_usd_model.dart';
import 'package:sokketnetwork/services/utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MainPage extends GetView<MainController> {
  static const String id = '/main1';

  @override
  // TODO: implement controller
  MainController get controller => super.controller;

  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.withOpacity(0.8),
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.indigo.shade100,
            ),
            margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: const Text(
              'Bitcoin - USD',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          Obx(() => Container(
                padding: const EdgeInsets.all(20),
                child: Center(
                    child: Column(
                  children: [
                    SfCartesianChart(
                        zoomPanBehavior: controller.zoomPanBehavior.value,
                        tooltipBehavior: controller.tooltipBehavior.value,
                        enableAxisAnimation: true,
                        legend: Legend(
                            isVisible: true, position: LegendPosition.top),
                        backgroundColor: Colors.indigo.shade100,
                        plotAreaBorderWidth: 0,
                        primaryXAxis: NumericAxis(
                            crossesAt: 0,
                            anchorRangeToVisiblePoints: false,
                            isVisible: true,
                            majorGridLines: const MajorGridLines(width: 0)),
                        primaryYAxis: NumericAxis(
                            crossesAt: 0,
                            majorTickLines:
                                const MajorTickLines(color: Colors.transparent),
                            axisLine: const AxisLine(width: 0),
                            minimum: controller.chartData.length > 2
                                ? (controller.chartData.value[1].data!.price! - 300.0)
                                : 47000,
                            maximum: controller.chartData.length > 2
                                ? (controller.chartData.value[1].data!.price! + 300.0)
                                : 48000),
                        series: <LineSeries<Bitcoin, num>>[
                          LineSeries<Bitcoin, num>(
                              dataSource: controller.chartData.value,
                              xValueMapper: (Bitcoin btc, number) => number,
                              yValueMapper: (Bitcoin btc, _) => btc.data?.price,
                              markerSettings: const MarkerSettings(
                                  isVisible: true, height: 2, width: 2),
                              color: Colors.green,
                              enableTooltip: true,
                              legendItemText: "BTC - USD",
                              isVisible: true,
                              dataLabelMapper: (Bitcoin btc, _) =>
                                  Utils.getHourMin(
                                      btc.data?.timestamp ?? "1648710969"),
                              dataLabelSettings: const DataLabelSettings(
                                  borderRadius: 0, isVisible: false))
                        ]),
                    const SizedBox(height: 10),
                    if (controller.chartData.length > 1)
                      GridView.builder(
                        itemBuilder: (context, index) {
                          return liveTrade(
                              bitcoin: controller.chartData.value[index]);
                        },
                        itemCount: controller.chartData.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 3,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 6,
                                crossAxisCount: 2),
                      )
                  ],
                )),
              ))
        ],
      ),
    );
  }

  Widget liveTrade({Bitcoin? bitcoin}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.indigo.shade100,
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          CircleAvatar(
              backgroundColor: Colors.blueAccent.shade100,
              child: const Icon(CupertinoIcons.bitcoin,
                  color: Colors.yellow, size: 30)),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (bitcoin?.data?.priceStr ?? '47000') + ' \$',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(Utils.getHourMin(bitcoin?.data?.timestamp ?? "1648710969")),
            ],
          )
        ],
      ),
    );
  }
}
