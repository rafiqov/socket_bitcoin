import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sokketnetwork/page/home_page.dart';
import 'package:sokketnetwork/page/main1_page.dart';
import 'package:sokketnetwork/services/di_service.dart';

void main()async {
  await DIService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:  const MainPage(),
      getPages: [
        GetPage(name: HomePage.id, page:()=> const HomePage()),
        GetPage(name: MainPage.id, page:()=>  const MainPage()),
      ],

    );
  }
}
