import 'package:binarys/controller/convert_controller.dart';
import 'package:binarys/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ConvertController(),
        ),
      ],
      child: MaterialApp(
        title: 'Binary',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: HomeView(),
      ),
    );
  }
}
