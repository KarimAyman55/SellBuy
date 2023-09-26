import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellbuy/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/status.dart';

import '../../../models/search_model.dart';
import '../../../network/end_points/end_points.dart';
import '../../Constants/Consts.dart';
import '../../remote/dio.helper.dart';

class SearchCubit extends Cubit<SearchStatus> {
  SearchCubit() : super(ShopSearchInitialStatus());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void getSearchData(String searchText) {
    emit(ShopLoadingSearchStatus());
    Diohelper.PostData(url: productssearch, Token: token, data: {
      'text': searchText,
    }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSuccessSearchStatus(searchModel!));
    }).catchError((error) {
      emit(ShopErrorSearchStatus());
      });
  }
}
