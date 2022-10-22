import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/moduls/search/cubit/states.dart';

import '../../../models/search_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remot/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search({required String? text}){
    emit(SearchLoadingState());

    DioHelper.postData(
        url: SEARCH,
        data: {
          'text' : text
        }
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
      print(error.toString());
    });
  }
}