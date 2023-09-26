import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sellbuy/shared/Constants/Components.dart';
import '../layout/shop_app_layout.dart';
import '../models/get_favourite_data.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/cubit.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/status.dart';
import '../shared/Constants/Consts.dart';

import 'ProductsDetailes.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ShopAppCubit>(context)..getFavData(),
      child: BlocConsumer<ShopAppCubit, ShopStatus>(
        listener: (BuildContext context, state) {},
        builder: (context, state) {
          var cubit = ShopAppCubit.get(context);
          return Scaffold(
            body: ShopAppCubit.get(context).getFavouriteData == null
                ? const Center(child: CircularProgressIndicator())
                : cubit.getFavouriteData!.data!.data.isEmpty
                ? const Center(
                child: Text(
                  ' Not Fav yet 🙁',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                ))
                : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildFavoriteItem(
                    cubit.getFavouriteData!.data!.data[index], context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: cubit.getFavouriteData!.data!.data.length),
          );},
      ),
    );
  }
}

Widget buildFavoriteItem(FavouriteData model, context) => InkWell(
      onTap: () {
        pushTo(context, ProductDetails(model.product!.id));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 120.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: NetworkImage(
                      '${model.product!.image}',
                    ),
                    width: 120.0,
                    height: 120.0,
                  ),
                  if (model.product!.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(color: Colors.white, fontSize: 10.0),
                      ),
                    )
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
                      '${model.product!.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14.0, color: Colors.black, height: 1.0),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product!.price}',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (model.product!.discount != 0)
                          Text(
                            '${model.product!.oldPrice}',
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
                                .changeFavorites(model.product!.id);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.green,
                            size: 30,
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
      ),
    );
