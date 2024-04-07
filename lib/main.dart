import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'Network/ApiProvider.dart';
import 'Pages/BottomNaviBar.dart';
import 'Pages/SplashScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'model/native_item.dart';

void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(NativeItemAdapter());
  Hive.registerAdapter(ItemsAdapter());

  runApp(MaterialApp(
    themeMode: ThemeMode.light, // Always use light theme
    theme: ThemeData.light(), // Define light theme
    home: RepositoryProvider(
      create: (context) => ApiProvider(),
      child: SplashScreen(),
    ),
    routes: {
      '/home': (context) => BottomNaviBar(),
    },
  ));
}
