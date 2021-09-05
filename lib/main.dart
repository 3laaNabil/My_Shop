import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/cubit/app_cubit.dart';
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
  bool ?isDark = CacheHelper.getData(key: 'isDark');
  bool? showOnBoard = CacheHelper.getData(
    key: 'onBoarding',
  );

  token = CacheHelper.getData(key: 'token');
  print(token);

  if (showOnBoard == false) {
    if (token != null) {
      widget = HomeScreen();
    } else {
      widget = LoginScreen();
    }
  } else
    widget = OnboardingScreen();

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  late final bool? isDark;
  late final Widget startWidget;

  MyApp({this.isDark, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppCubit()),
          BlocProvider(
            create: (context) =>
            ShopCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavorites()
              ..getUserData()) ]
            ,
            child: BlocConsumer<AppCubit, AppState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  //themeMode: ThemeMode.light,
                    themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
                  home: startWidget,
                );
              },
            ),


    );
  }
}
