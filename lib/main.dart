import 'package:flutter/material.dart';
import 'package:focus/info_model.dart';
import 'package:focus/Widgets/bottomNav.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SetData>(
          create: (context) => SetData(),
        ),
      ],
      child: MaterialApp(
        title: 'Focus',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: BottomBar(),
      ),
    );
  }
}
