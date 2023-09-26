import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sellbuy/shared/remote/CasheHelper.dart';
import '../layout/shop_app_layout.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/cubit.dart';
import '../shared/AppBloc/register.screen/cubit.dart';
import '../shared/AppBloc/register.screen/status.dart';
import '../shared/Constants/Components.dart';
import '../shared/Constants/Consts.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppRegistercubit, ShopRegisterStatus>(
      listener: (BuildContext context, state) {
        if (state is ShopRegisterSuccessStatus) {
          if (state.userRegisterModel.status == true) {
            Fluttertoast.showToast(
                msg: state.userRegisterModel.message.toString(),
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            CacheHelper.saveData(
                    key: 'token', value: state.userRegisterModel.data!.token)
                .then((value) {
              token = state.userRegisterModel.data!.token!;
              pushAndFinish(context, const ShopAppLayout());
              nameController.clear();
              phoneController.clear();
              emailController.clear();
              passwordController.clear();
              ShopAppCubit.get(context).currentIndex = 0;
              ShopAppCubit.get(context).getHomeData();
              ShopAppCubit.get(context).getShopProfileData();
              ShopAppCubit.get(context).getFavData();
              ShopAppCubit.get(context).getCartData();
              ShopAppCubit.get(context).getAddresses();
              ShopAppCubit.get(context).getOrders();
              ShopAppCubit.get(context).getOrdersDetails();
            }).catchError((error) {
              if (kDebugMode) {
                print(error.toString());
              }
            });
          } else {
            Fluttertoast.showToast(
                msg: state.userRegisterModel.message.toString(),
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = ShopAppRegistercubit.get(context);
        return Scaffold(
          backgroundColor: HexColor("61124a"),
          appBar: AppBar(
            titleSpacing: 1,
            title: const Row(
              children: [
                Image(
                  image: AssetImage('assets/img/sellbuy.png'),
                  width: 40,
                  height: 40,
                ),
                Text(
                  '  SellBuy',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        'Register On Our Community',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defulteditTextx(
                        Controlar: nameController,
                        keyboardType: TextInputType.text,
                        Lable: 'Full Name',
                        prefix: Icons.person,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'PLease Enter your Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defulteditTextx(
                        Controlar: emailController,
                        keyboardType: TextInputType.text,
                        Lable: 'Email',
                        prefix: Icons.email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'PLease Enter your Email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defulteditTextx(
                        Controlar: phoneController,
                        keyboardType: TextInputType.phone,
                        Lable: 'Phone',
                        prefix: Icons.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'PLease Enter your Phone';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defulteditTextx(
                        Controlar: passwordController,
                        keyboardType: TextInputType.text,
                        Lable: 'Password',
                        prefix: Icons.lock,
                        sufix: cubit.iconData,
                        obscureText: cubit.isSecure,
                        suffixPressed: () {
                          cubit.isShow();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'PLease Enter your Password';
                          }
                          return null;
                        },
                        onfiled: (value) {
                         },
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            cubit.UserRegister(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      bottom(
                        width: double.infinity,
                        height: 37,
                        color: Colors.deepOrange,
                        onpressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.UserRegister(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        text: 'REGISTER',
                      ),
                      const SizedBox(
                        height: 35.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
