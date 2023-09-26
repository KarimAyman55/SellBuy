import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sellbuy/modules/on_bording_screen.dart';
import 'package:sellbuy/modules/register_screen.dart';
import 'package:sellbuy/shared/Constants/Components.dart';
import 'package:sellbuy/shared/remote/CasheHelper.dart';
import '../layout/shop_app_layout.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/cubit.dart';
import '../shared/AppBloc/shoplogin_bloc/cubit.dart';
import '../shared/AppBloc/shoplogin_bloc/status.dart';
import '../shared/Constants/Consts.dart';


class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  ShopLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, ShopLoginStatus>(
      listener: (BuildContext context, state) {
        if (state is ShopLoginSuccessStatus) {
          if (state.loginModel.status == true) {
            Fluttertoast.showToast(
                msg: state.loginModel.message.toString(),
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data?.token)
                .then((value) {
              token = state.loginModel.data!.token!;
              pushAndFinish(context, const ShopAppLayout());
              emailController.clear();
              passwordController.clear();
              ShopAppCubit.get(context).currentIndex = 0;
              ShopAppCubit.get(context).getHomeData();
              ShopAppCubit.get(context).getShopProfileData();
              ShopAppCubit.get(context).getShopProfileData();
              ShopAppCubit.get(context).getFavData();
              ShopAppCubit.get(context).getCartData();
              ShopAppCubit.get(context).getAddresses();
              ShopAppCubit.get(context).getOrders();
              ShopAppCubit.get(context).getOrdersDetails();
            }).catchError((error) {});
          } else {
            Fluttertoast.showToast(
                msg: state.loginModel.message.toString(),
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
        var cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(
           title:  Row(
              children: [
                const Image(
                  image: AssetImage('assets/img/sellbuy.png'),
                  width: 40,
                  height: 40,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      ' Sell_Buy ',
                      textStyle: const TextStyle(
                          color: Colors.white70,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic
                      ),
                      speed: const Duration(milliseconds: 300),
                    ),

                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                ),
        ],
            ),
            backgroundColor: HexColor("49124a"),
            elevation: 0,
          actions: [ TextButton(onPressed: (){
            pushAndFinish(context, const Boarding());
          },child: const Text("App Info",style: TextStyle(color: Colors.deepOrange),)),
          ],
          ),

          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: PhotoView(
                          backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                          imageProvider: const AssetImage("assets/img/sellbuy2.png"),customSize:const Size.fromWidth(400),
                          //fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Center(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            const Text(
                              'Login your account now',
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            defulteditTextx(
                              Controlar: emailController,
                              keyboardType: TextInputType.text,
                              Lable: 'Email Address',
                              prefix: Icons.email,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email must not be empty';
                                }
                                return null;
                              },
                              onfiled: (value) {
                                },
                            ),
                            const SizedBox(
                              height: 30.0,
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
                                  return 'Password must not be empty';
                                }
                                return null;
                              },
                              onfiled: (value) {
                              },
                              onSubmit: (value) {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! ShopLoginLodingStatus,
                              builder: (BuildContext context) => bottom(
                                width: double.infinity,
                                height: 30,
                                color: Colors.indigo,
                                onpressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: 'Login',
                              ),
                              fallback: (BuildContext context) => const Center(
                                  child: CircularProgressIndicator()),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Don\'t Have an account yet ?',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                TextButton(
                                  onPressed: () {
                                    pushTo(context, RegisterScreen());
                                  },
                                  child: const Text('Register'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
