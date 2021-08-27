import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/constants/constants.dart';
import 'package:shop_app/data/api/end_points.dart';
import 'package:shop_app/data/api/shop_Api.dart';
import 'package:shop_app/data/models/home_model.dart';
import 'package:shop_app/ui/screen/cateogries_screen.dart';
import 'package:shop_app/ui/screen/favorites_screen.dart';
import 'package:shop_app/ui/screen/products_screen.dart';
import 'package:shop_app/ui/screen/settings_screen.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());
   HomeModel ?homeModel;

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }


  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    ShopApi.getData(url: HOME, query: null,token: token ).then((value) {

      homeModel = HomeModel.fromJson(value.data);
      emit(ShopSuccessHomeDataState());
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorHomeDataState());
    });
  }
}
