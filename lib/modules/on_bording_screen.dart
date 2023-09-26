import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sellbuy/shared/Constants/Components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:hexcolor/hexcolor.dart';
import '../shared/remote/CasheHelper.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'login_screen.dart';
class BoardingModel {
  String image;
  String text;

  BoardingModel(
      this.image,
      this.text,
      );
}

class Boarding extends StatefulWidget {
  const Boarding({super.key});


  @override
  State<Boarding> createState() => _BoardingState();
}

class _BoardingState extends State<Boarding> {

  bool isLast = false;
  List <BoardingModel> boardingScreen = [
    BoardingModel('assets/img/sellbuy3.png',
      'SellBuy is a best way to buy products and it provides great services', ),
    BoardingModel('assets/img/sellbuy2.png', 'U can sign in our community aNd order any and many', ),
  ];
  void submitData (){
    CacheHelper.saveData(key: "onBoarding", value: true).then((value) {
      if (value == true){
        pushAndFinish(context,  ShopLoginScreen());

      }
    });

  }

  var boardingController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#190e21"),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title:
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30,left: 14),
                child:   AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      ' Sell-Buy ',
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

              ),
              const SizedBox(width: 2,),
              const Text("🙋")

            ],
          ),
          centerTitle: true,
          actions: [Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.indigo.shade400,
              radius: 23,
              child: TextButton (
                onPressed: (){
                  submitData();
                },
                child:  const Text ('Skip',style: TextStyle(
                    color: Colors.white
                    ,
                    fontSize: 12
                )),
              ),
            ),
          )],
        ),

        body: PageView.builder(itemBuilder: ( (context, index) => boardingItem (boardingScreen[index])  ),
          itemCount:boardingScreen.length ,controller: boardingController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (index){
            if( index == boardingScreen.length-1  ){
              setState(() {
                isLast =true;
              });
            }
            else {

              setState(() {
                isLast =false;

              });}
          },)

    );
  }

  Widget boardingItem (BoardingModel model) => Padding(
    padding: const EdgeInsets.all(28.0),
    child: Column(
     // mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        const  SizedBox(height: 80,),

        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child:
          AspectRatio(
            aspectRatio: 1,
            child: PhotoView(
             backgroundDecoration: const BoxDecoration(color: Colors.transparent),
              imageProvider: AssetImage(model.image),customSize:const Size.fromWidth(400),
                //fit: BoxFit.scaleDown,
              ),
            ),
          ),
        const  SizedBox(height: 140,),
        Text(model.text,maxLines: 3,style: const TextStyle(
            color: Colors.white,fontSize: 15,fontFamily: "Janna",fontStyle: FontStyle.italic
        )),
        Row(
          children: [
            const  SizedBox(height: 85,),
            SmoothPageIndicator(controller: boardingController ,
                count: boardingScreen.length,effect:const ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  expansionFactor: 3,
                  spacing: 5,
                  dotWidth: 10,
                  dotHeight: 10,
                  activeDotColor: Colors.deepOrange,
                ) ),
            const Spacer(),
            FloatingActionButton(onPressed: (){
              if (isLast) {
                submitData();
              } else {
                boardingController.nextPage(duration: const Duration(milliseconds: 950),
                    curve: Curves.fastLinearToSlowEaseIn);
              } } ,backgroundColor: Colors.orange,

                child: const Icon  (Icons.arrow_forward_ios))

          ],)

      ],),
  );
}



