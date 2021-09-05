import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/data/local/cache_helper.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());



  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  ThemeMode appMode = ThemeMode.light;

  void changeMode({fromCache}) {
    if(fromCache == null)
      isDark =!isDark;
    else
      isDark = fromCache;
    emit(AppChangeModeState());
    CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
      if(isDark)
        appMode = ThemeMode.dark;
      else
        appMode = ThemeMode.light;
      emit(AppChangeModeState());
    });

  }
}
