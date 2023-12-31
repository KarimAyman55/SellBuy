import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/categoriesdetailsdatal.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/cubit.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/status.dart';

import '../shared/Constants/Components.dart';
import 'ProductsDetailes.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String? categoryName;

  const CategoryProductsScreen(this.categoryName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopStatus>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1.0,
            titleSpacing: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
            title: Text(
              '$categoryName',
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black87),
            ),
          ),
          body: ShopAppCubit.get(context).categoriesDetailModel == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    color: Colors.grey[300],
                    child: Column(
                      children: [
                        separator(0, 1),
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 2,
                          childAspectRatio: 0.6,
                          mainAxisSpacing: 2,
                          children: List.generate(
                              ShopAppCubit.get(context)
                                  .categoriesDetailModel!
                                  .data
                                  .productData
                                  .length,
                              (index) => ShopAppCubit.get(context)
                                      .categoriesDetailModel!
                                      .data
                                      .productData
                                      .isEmpty
                                  ? const Center(
                                      child: Text(
                                        'Coming Soon',
                                        style: TextStyle(fontSize: 50),
                                      ),
                                    )
                                  : bodyItem(
                                      ShopAppCubit.get(context)
                                          .categoriesDetailModel!
                                          .data
                                          .productData[index],
                                      context)),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget bodyItem(Categorydata model, context) => InkWell(
        onTap: () {
          ShopAppCubit.get(context).getProductData(model.id.toString());
          pushTo(context, ProductDetails(model.id));
        },
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: NetworkImage('${model.image}'),
                    width: double.infinity,
                    height: 200.0,
                  ),
                  if (model.discount != 0)
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
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14.0, color: Colors.black, height: 1.0),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '${model.price}\$',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (model.discount != 0)
                          Text(
                            '${model.oldPrice}',
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              height: 1.0,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            ShopAppCubit.get(context)
                                .changeFavorites(model.id!);
                            print(model.id);
                          },
                          child: Icon(
                            ShopAppCubit.get(context).favorite[model.id] == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 25,
                            color:
                                ShopAppCubit.get(context).favorite[model.id] ==
                                        true
                                    ? Colors.deepOrange
                                    : Colors.black,
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
}
