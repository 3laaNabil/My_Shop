import 'package:flutter/material.dart';
import 'package:shop_app/business_logic/cubit/shop_cubit.dart';
import 'package:shop_app/data/local/cache_helper.dart';
import 'package:shop_app/ui/screen/login_screen.dart';

navigatTo(context, widget) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}


navigatToFinish(context, widget) {
  return  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (route) {
      return false;
    },
  );
}

 String ?token  ;
void signOut (context) {
  CacheHelper.removeData('token').then((value){
    navigatToFinish(context, LoginScreen());
    ShopCubit.get(context).currentIndex = 0;
  });
}