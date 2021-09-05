import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/constants/constants.dart';
import 'package:shop_app/data/api/end_points.dart';
import 'package:shop_app/data/api/shop_Api.dart';
import 'package:shop_app/data/models/shop_search_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

   SearchModel ?searchModel;

  void search(String text) {
    emit(SearchLoadingState());
    ShopApi.postData(url: SEARCH, data: {
      'text': text,
    },token: token).then((value) {
      searchModel = SearchModel.fromJson(value.data);

      print(value.data.toString());
      emit(SearchSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(SearchErrorState());
    });
  }
}
