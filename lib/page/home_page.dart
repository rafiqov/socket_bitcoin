import 'package:flutter/material.dart';
import 'package:sokketnetwork/models/btc_usd_model.dart';
import 'package:sokketnetwork/services/socket_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String response = 'No data';
  Bitcoin? bitcoin;


  _initSocketService() {
    SocketService.connectServer();

    SocketService.channel.stream.listen((event) {
      setState(() {
        response = event.toString();
        bitcoin = bitcoinFromJson(response);
      });
    }, onError: (error) {
      setState(() {
        response = error.toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initSocketService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(child: liveTrade(bitcoin: bitcoin)),
      ),
    );
  }

  Widget liveTrade({Bitcoin? bitcoin}) {
    return Text(bitcoin?.data?.price?.toString() ?? 'No Data');
  }
}