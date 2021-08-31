import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/constants/constants.dart';
import 'package:shop_app/data/api/end_points.dart';
import 'package:shop_app/data/api/shop_Api.dart';
import 'package:shop_app/data/models/categories_model.dart';
import 'package:shop_app/data/models/change_favoritesModel.dart';
import 'package:shop_app/data/models/favorites_model.dart';
import 'package:shop_app/data/models/home_model.dart';
import 'package:shop_app/data/models/shopLoginModel.dart';
import 'package:shop_app/ui/screen/cateogries_screen.dart';
import 'package:shop_app/ui/screen/favorites_screen.dart';
import 'package:shop_app/ui/screen/products_screen.dart';
import 'package:shop_app/ui/screen/settings_screen.dart';
import 'package:shop_app/ui/styles/colors.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());
  Icon favoriteIcon = Icon(
    Icons.favorite,
    color: defaultColor,
  );
  Icon unFavoriteIcon = Icon(Icons.favorite_border_rounded);

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

  Map<dynamic, dynamic> favorites = {};
  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    ShopApi.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    ShopApi.getData(url: GetCategories, query: null, token: token)
        .then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeToFavoritesModel;

  void changeFavorites(int? productId) {

    favorites[productId] = !favorites[productId];
    emit(ShopChangeFavoritesState());

    ShopApi.postData(
        url: FAVORITES,
        token: token,
        data: {'product_id': productId}).then((value) {
      changeToFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if (!changeToFavoritesModel!.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeToFavoritesModel!));
    }).catchError((e) {
      print(e.toString());

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel ?favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    ShopApi.getData(
      url: FAVORITES,
      token: token,
    ).then((value){
      favoritesModel = FavoritesModel.fromJson(value.data);
  //    print('Favorites '+favoritesModel!.status.toString());
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      emit(ShopErrorGetFavoritesState());
      print(error.toString());
    });
  }

  ShopLoginModel ?userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());

    ShopApi.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
//      printFullText(userModel.data.name);

      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }
}
