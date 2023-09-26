import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sellbuy/shared/Constants/Components.dart';

import '../models/get_cart_data.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/cubit.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/status.dart';
import '../shared/Constants/Consts.dart';
import 'address_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ShopAppCubit>(context)..getCartData(),
      child: BlocConsumer<ShopAppCubit, ShopStatus>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var cubit = ShopAppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1.0,
              title: const Text(
                'Your Cart',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
            bottomNavigationBar: ShopAppCubit.get(context).getCartModel == null
                ? const Center(child: CircularProgressIndicator())
                : buildNavigationBar(context),
            body: ShopAppCubit.get(context).getCartModel == null
                ? const Center(child: CircularProgressIndicator())
                : ShopAppCubit.get(context).getCartModel!.data.cartItems.isEmpty
                    ? const Center(
                        child: Text(
                        ' not in Cart yet  🙁',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal),
                      ))
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildCartItem(
                            cubit.getCartModel!.data.cartItems[index],
                            context,
                            index,
                            ShopAppCubit.get(context).getCartModel!),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: cubit.getCartModel!.data.cartItems.length),
          );
        },
      ),
    );
  }

  Widget buildCartItem(
          CartItems cartItems, context, index, GetCartModel model) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 140.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: NetworkImage(
                      cartItems.product.image,
                    ),
                    width: 120.0,
                    height: 120.0,
                  ),
                  if (cartItems.product.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: const Text(
                        'Discount',
                        style: TextStyle(color: Colors.white, fontSize: 10.0),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItems.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14.0, color: Colors.black, height: 1.0),
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,

                      children:
                    [
                      Container(
                        width: 70,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(cartItems.quantity.toString()),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10 ,),
                      IconButton(
                          onPressed: () {
                            ShopAppCubit.get(context)
                                .minusQuantity(model, index);
                            ShopAppCubit.get(context).updateCartData(
                                id: model.data.cartItems[index].id
                                    .toString(),
                                quantity:
                                ShopAppCubit.get(context).quantity);
                          },
                          icon: const Icon(Icons.remove)),
                      const SizedBox(width: 12 ,),
                      IconButton(
                          onPressed: () {
                            ShopAppCubit.get(context)
                                .plusQuantity(model, index);
                            ShopAppCubit.get(context).updateCartData(
                                id: model.data.cartItems[index].id
                                    .toString(),
                                quantity:
                                ShopAppCubit.get(context).quantity);
                          },
                          icon: const Icon(Icons.add)),

                    ],),
                    Row(
                      children: [
                        Text(
                          '${cartItems.product.price} EGP',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (cartItems.product.discount !=0 )
                        Text(
                          cartItems.product.oldprice.toString(),
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                            height: 1.0,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopAppCubit.get(context)
                                .changeCart(cartItems.product.id);
                          },
                          icon: const Icon(
                            Icons.delete,
                            size: 28,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildNavigationBar(context) => ListTile(
        title: const Text('Total Cost'),
        subtitle: Text(
          '${ShopAppCubit.get(context).getCartModel!.data.total} EGP',
          style: const TextStyle(color: Colors.green),
        ),
        trailing: SizedBox(
          width: 160.0,
          height: 40.0,
          child: MaterialButton(
            onPressed: () {
              if (ShopAppCubit.get(context)
                  .getCartModel!
                  .data
                  .cartItems
                  .isNotEmpty) {
                pushTo(context, const AddressesScreen());
              } else {
                Fluttertoast.showToast(
                    msg: 'No Cart Data ',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            color: Colors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: const Text(
              'Order',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
}
