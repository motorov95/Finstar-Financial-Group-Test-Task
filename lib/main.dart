import 'package:calc/bloc/calculating_bloc.dart';
import 'package:calc/screens/calculating_screen.dart';
import 'package:calc/screens/history_screen.dart';
import 'package:calc/screens/payment_table_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => CalculatingService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      getPages: [
        GetPage(name: '/', page: () => CreditCalculatorScreen()),
        GetPage(name: '/historyScreen', page: () => HistoryScreen()),
        GetPage(name: '/tableScreen', page: () => PaymentTableScreen())
      ],
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      home: CreditCalculatorScreen(),
    );
  }
}
