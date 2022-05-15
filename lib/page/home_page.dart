import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokketnetwork/controllers/home_controller.dart';
import 'package:sokketnetwork/models/btc_usd_model.dart';

class HomePage extends StatelessWidget {
  static const String id = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (controller) {
              return Center(child: liveTrade(bitcoin: controller.bitcoin));
            }),
      ),
    );
  }

  Widget liveTrade({Bitcoin? bitcoin}) {
    return Text(bitcoin?.data?.price?.toString() ?? 'No Data');
  }
}