part of 'login_cubit.dart';



abstract class LoginState {}




class ShopLoginInitialState extends LoginState {}

class ShopLoginLoadingState extends LoginState {}

class ShopLoginSuccessState extends LoginState
{
 late  ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends LoginState
{
  final String error;

  ShopLoginErrorState(this.error);
}



class ShopChangePasswordVisibilityState extends LoginState{}
