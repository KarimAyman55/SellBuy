import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellbuy/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';
import 'package:sellbuy/shared/AppBloc/register.screen/cubit.dart';
import 'package:sellbuy/shared/AppBloc/shoplogin_bloc/blocobservar.dart';
import 'package:sellbuy/shared/AppBloc/shoplogin_bloc/cubit.dart';
import 'package:sellbuy/shared/Constants/Consts.dart';
import 'package:sellbuy/shared/remote/CasheHelper.dart';
import 'package:sellbuy/shared/remote/dio.helper.dart';

import 'layout/shop_app_layout.dart';
import 'modules/login_screen.dart';
import 'modules/on_bording_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  Diohelper.init();
  await CacheHelper.init();
  onBoarding = CacheHelper.getData('onBoarding');
  token = CacheHelper.getData('token');
  late Widget start;
  if (onBoarding != null) {
    if (token == null) {
      start = ShopLoginScreen();
    } else {
      start = const ShopAppLayout();
    }
  } else {
    start = const Boarding();
  }

  runApp(MyApp(start));
}

class MyApp extends StatelessWidget {
  Widget startApp;

  MyApp(this.startApp, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(
            create: (context) => ShopAppCubit()
              ..getHomeData()
              ..getAddresses()
              ..getCategoryModel()
              ..getOrders()
              ..getShopProfileData()
        ),
        BlocProvider(create: (context) => ShopAppRegistercubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: startApp,
      ),
    );
  }
}
