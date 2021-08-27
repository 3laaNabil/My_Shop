import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/cubit/shop_cubit.dart';
import 'package:shop_app/data/api/shop_Api.dart';
import 'package:shop_app/ui/screen/home_screen.dart';
import 'package:shop_app/ui/screen/login_screen.dart';
import 'package:shop_app/ui/screen/onboarding_screen.dart';
import 'package:shop_app/ui/styles/thems.dart';

import 'constants/constants.dart';
import 'data/local/cache_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ShopApi.init();
  await CacheHelper.init();
  Widget widget;
  bool? showOnBoard = CacheHelper.getData(key: 'onBoarding',);

   token = CacheHelper.getData(key: 'token',);
  if (showOnBoard == false) {
    if (token != "")
      widget = HomeScreen();
    else
      widget = LoginScreen();
  }
  else
    widget = OnboardingScreen();


  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  late final bool? isDark;
  late final Widget startWidget;

  MyApp({this.isDark, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getHomeData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        //   AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
        home: startWidget,
      ),
    );
  }
}

