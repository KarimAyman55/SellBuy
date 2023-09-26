import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellbuy/shared/AppBloc/register.screen/status.dart';

import '../../../models/shop_login_model.dart';
import '../../../network/end_points/end_points.dart';
import '../../remote/dio.helper.dart';

class ShopAppRegistercubit extends Cubit<ShopRegisterStatus> {
  ShopAppRegistercubit() : super(ShopRegisterInitialStatus());

  static ShopAppRegistercubit get(context) => BlocProvider.of(context);

  /// method post&Register Screen
  ShopLoginModel? UserRegisterModel;

  void UserRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLodingStatus());
    Diohelper.PostData(url: REGISTER, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
    }).then((value) {
      UserRegisterModel = ShopLoginModel.formjson(value.data);
      emit(ShopRegisterSuccessStatus(UserRegisterModel!));
    }).catchError((error) {
      emit(ShopRegisterErrorStatus(error.toString()));
    });
  }

  IconData iconData = Icons.visibility_off;

  bool isSecure = true;

  void isShow() {
    iconData = isSecure
        ? Icons.visibility_off_outlined:Icons.visibility_outlined;
    isSecure = !isSecure;
    emit(IseyeRegisterShow());
  }
}
