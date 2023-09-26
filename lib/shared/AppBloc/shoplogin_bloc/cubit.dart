import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellbuy/shared/AppBloc/shoplogin_bloc/status.dart';

import '../../../models/shop_login_model.dart';
import '../../../network/end_points/end_points.dart';
import '../../remote/dio.helper.dart';

class LoginCubit extends Cubit<ShopLoginStatus> {
  LoginCubit() : super(ShopLoginInitialStatus());
  ShopLoginModel? userModel;

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLodingStatus());
    Diohelper.PostData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      userModel = ShopLoginModel.formjson(value.data);
      emit(ShopLoginSuccessStatus(userModel!));
    }).catchError((error) {
      print('  الايرور هنا  .........');
      print(error);
      emit(ShopLoginErrorStatus(error.toString()));
    });
  }

  IconData iconData = Icons.visibility_off;

  bool isSecure = true;

  void isShow() {
    iconData = isSecure
        ? Icons.visibility_off_outlined:Icons.visibility_outlined;
    isSecure = !isSecure;
    emit(IseyeShow());
  }
}
