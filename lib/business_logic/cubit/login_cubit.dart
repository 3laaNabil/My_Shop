import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants/constants.dart';
import 'package:shop_app/data/api/end_points.dart';
import 'package:shop_app/data/api/shop_Api.dart';
import 'package:shop_app/data/models/shopLoginModel.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  LoginCubit() : super(ShopLoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

 late ShopLoginModel loginModel;
  userLogin({
    required String email,
    required String password,
  }) {

    emit(ShopLoginLoadingState());
    ShopApi.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    },token: token,).then((value) {
      print(value.data);

      loginModel =  ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((e) {
      print(e.toString());
      emit(ShopLoginErrorState(e.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
}
