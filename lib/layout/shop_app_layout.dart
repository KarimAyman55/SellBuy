import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellbuy/modules/contact_screen.dart';
import 'package:sellbuy/modules/faqs_screen.dart';
import 'package:sellbuy/modules/profile_screen.dart';
import 'package:sellbuy/shared/Constants/Components.dart';
import 'package:url_launcher/url_launcher.dart';
import '../modules/searchscreen.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/cubit.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/status.dart';
import 'Location/UI.dart';

class ShopAppLayout extends StatelessWidget {
  const ShopAppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopStatus>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = ShopAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              showMenu(
                shape:const Border.fromBorderSide(BorderSide(color: Colors.indigo)),
                  context: context, position:RelativeRect.fromDirectional(
                  textDirection: TextDirection.ltr, start: 5,
                  top: 84, end: 10, bottom: 0), items: [
                    PopupMenuItem(
                      child:
                    SizedBox(
                      width: 160,
                      child: Column(children: [
                        InkWell(onTap: (){
                          pushTo(context,   ProfileScreen());

                        },
                          child:const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text("Profile",style: TextStyle(color: Colors.indigo),),
                                Spacer(),
                                Icon(Icons.person,color: Colors.black,),
                              ],),
                          )
                          ,),
                        InkWell(onTap: (){
                          pushTo(context, const ContactScreen());

                        },
                          child:const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text("US",style: TextStyle(color: Colors.indigo),),
                                Spacer(),
                                Icon(Icons.location_on_outlined,color: Colors.black,),
                              ],),
                          )
                          ,),
                        InkWell(onTap: (){
                          pushTo(context, const FAQsScreen());

                        },
                          child:const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text("Q-A",style: TextStyle(color: Colors.indigo),),
                                Spacer(),
                                Icon(Icons.info,color: Colors.black,),
                              ],),
                          )
                          ,),
                        InkWell(
                        onTap: ()async{
                          await launch('mailto:kryma734@gmail.com');
                        },
                        child:
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            children: [

                              Text(
                                "send-Mail",style: TextStyle(color: Colors.indigo),
                              ),
                              Spacer(),

                              Icon(Icons.email_outlined),


                            ],
                          ),
                        ),
                      ) ,
                        InkWell(onTap: (){
                          pushTo(context, const CurrentLocation());

                        },
                          child:const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text("Find-Location",style: TextStyle(color: Colors.indigo),),
                                Spacer(),
                                Icon(Icons.location_on_outlined,color: Colors.black,),
                              ],),
                          )
                          ,),
                        InkWell(onTap: (){
                          showDialog(context: context, builder: (context)=>
                              AlertDialog(
                                backgroundColor: Colors.black87,
                                title: const Text(" Are U Sure For Log-Out..?",
                                    style: TextStyle(fontStyle: FontStyle.italic,color: Colors.white70,
                                        fontSize: 15)),
                                actions: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                            InkWell(
                                              onTap: (){
                                                cubit.signOut(context);
                                              },
                                              child:  Container(
                                                width: 40,
                                                color: Colors.white70,
                                                child: const Text( " Ya "
                                                  ,style: TextStyle(fontStyle:
                                                  FontStyle.italic,color: Colors.black
                                                      ,fontSize: 14),),
                                              ),
                                            ),

                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                            InkWell(
                                              onTap: (){
                                                Navigator.pop(context);
                                              },
                                              child:  Container(
                                                width: 40,
                                                color: Colors.white70,

                                                child: const Text( "  No"
                                                  ,style: TextStyle(fontStyle:
                                                  FontStyle.italic,color: Colors.black
                                                      ,fontSize: 14),),
                                              ),
                                            ),

                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ));


                        },
                          child:const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text("Log-Out",style: TextStyle(color: Colors.indigo),),
                                Spacer(),
                                Icon(Icons.logout,color: Colors.red,),
                              ],),
                          )
                          ,),


                      ],),
                    ), )
              ]);
              },icon:  Icon(Icons.menu,color: Colors.orange.shade800,)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleSpacing: 30,
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
                          color: Colors.blue,
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
            actions: [
              IconButton(
                onPressed: () {
                  pushTo(context, SearchScreen());
                },
                icon:  const Icon(Icons.search, color: Colors.black),
              ),
            ],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            buttonBackgroundColor: Colors.white,
            height: 60.0,
            color: Colors.black26,
            backgroundColor: Colors.transparent,
            items: cubit.iconData,
            animationDuration: const Duration(milliseconds: 350),
            index: cubit.currentIndex,
            onTap: (index) {
              cubit.onChangeTabs(index);
            },
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
