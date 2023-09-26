import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: const Row(
          children: [
            Image(
              image: AssetImage('assets/img/sellbuy.png'),
              width: 50,
              height: 35,
            ),
            Text(
              'SellBuy',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.only(start: 20, top: 40,bottom: 18),
            child: Text(
              ' developer : ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsetsDirectional.only(top:5,start: 20, bottom: 5),
            child: Text(
              'Name : \n  Karim Ayman Mohammed',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          const Padding(
            padding: EdgeInsetsDirectional.only(top:5,start: 20, bottom: 5),
            child: Text(
              'Email : \n  karimayman552000@gmail.com',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          const Padding(
            padding: EdgeInsetsDirectional.only(top:5,start: 20, bottom: 20),
            child: Text(
              'Age : \n   22 ',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          const SizedBox(
            width: double.infinity,
            height: 20,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    launch("https://www.facebook.com/karim.ayman.9889261?mibextid=ZbWKwL");

                  },
                  child: const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                      'https://www.hubbardinteractive.com/wp-content/uploads/2020/04/facebook-logo.png',
                    ),
                  ),
                ),
                const SizedBox(width: 12,),
                InkWell(
                  onTap: () {
                    launch("https://wa.me/+201157643398/?text=${Uri.parse("Hello")}");

                  },
                  child: const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        'https://th.bing.com/th/id/OIP.rYwLvduBi2m_Kk6jSko6ZAHaEu?pid=ImgDet&rs=1'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),

        ],
      ),
    );
  }



}
