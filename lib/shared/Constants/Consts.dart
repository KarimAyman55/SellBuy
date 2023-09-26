import 'package:flutter/material.dart';

import '../AppBloc/Appcubit&&ٍSearchCubit/cubit.dart';
import '../AppBloc/Appcubit&&ٍSearchCubit/status.dart';

dynamic token = '';
bool ? onBoarding;
bool isEdit = false;
String editText = 'Edit';
const primColors = Color(0xffDAD3C8);


void editPressed({
  required context,
  required email,
  required name,
  required phone,
}) {
  isEdit = !isEdit;
  if (isEdit) {
    editText = 'Save';
    ShopAppCubit.get(context).emit(EditPressedState());
  } else {
    editText = 'Edit';
    ShopAppCubit.get(context)
        .getShopUpdateProfileData(email: email, name: name, phone: phone);
  }
}

Widget myDivider() => Container(
      color: Colors.grey[300],
      height: 1,
      width: double.infinity,
    );
