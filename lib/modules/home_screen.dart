import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sellbuy/modules/produc_category_data_screen.dart';
import 'package:sellbuy/shared/Constants/Components.dart';
import '../models/shop_category_model.dart';
import '../models/shopappmodel.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/cubit.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/status.dart';
import 'ProductsDetailes.dart';
import 'cart_screen.dart';
import 'favourit_screen.dart';
import 'order_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopStatus>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = ShopAppCubit.get(context);
        return ConditionalBuilder(
            condition:
                cubit.shopHomeModel != null && cubit.categoryModel != null,
            builder: (context) =>
                HomeData(cubit.shopHomeModel, cubit.categoryModel, context),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }
}

Widget HomeData(ShopHomeModel? model, CategoryModel? categoryModel, context) =>
    SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model!.data!.banners
                    .map((e) => PhotoView(imageProvider: NetworkImage('${e.image}'),
                  backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                  customSize: const Size(490,300),)).toList(),
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(seconds: 3),
                  scrollDirection: Axis.horizontal,
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                )),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Categories :',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 100.0,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    buildCategoriesItem(categoryModel.data!.data[index], context),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 10,
                ),
                itemCount: categoryModel!.data!.data.length,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        pushTo(context, const CartScreen());

                      },
                      child: Container(
                        width: 130,
                        height: 28,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.indigoAccent),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text("       My Cart",style: TextStyle(color: Colors.white)),
                        ),),
                    ),

                    const SizedBox(
                      width: 25,
                    ),
                    InkWell(
                      onTap: (){

                        pushTo(context, const MyOrdersScreen());
                      },
                      child: Container(
                        width: 130,
                        height: 28,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.grey.shade800),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text("       My Orders ",style: TextStyle(color: Colors.white)),
                        ),),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    InkWell(
                      onTap: (){
                        Fluttertoast.showToast(msg: "This Feature Will come Soon ",backgroundColor: Colors.green);
                      },
                      child: Container(
                        width: 130,
                        height: 28,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.indigoAccent),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text("     Add Product ",style: TextStyle(color: Colors.white)),
                        ),),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    InkWell(
                      onTap: (){
                        pushTo(context, const FavouriteScreen());
                      },
                      child: Container(
                        width: 130,
                        height: 28,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: Colors.grey.shade800),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text("       Favorites ",style: TextStyle(color: Colors.white)),
                        ),),
                    ),

                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Products :',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                childAspectRatio: 1 / 2.268,
                mainAxisSpacing: 1.5,
                crossAxisSpacing: 1.5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                children: List.generate(
                    model.data!.products.length,
                    (index) => InkWell(
                        onTap: () {
                          pushTo(context,
                              ProductDetails(model.data!.products[index].id));
                        },
                        child: homeProductsItems(
                            model.data!.products[index], context))),
              ),
            ),
          ],
        ),
      ),
    );

Widget buildCategoriesItem(Data data, context) => InkWell(
      onTap: () {
        ShopAppCubit.get(context).getCategoriesDetailData(data.id);
        pushTo(context, CategoryProductsScreen(data.name));
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 20.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Image(
                  image: NetworkImage('${data.image}'),
                  fit: BoxFit.cover,
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              Container(
                width: 100.0,
                color: Colors.black.withOpacity(
                  .8,
                ),
                child: Text(
                  '${data.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget homeProductsItems(ProductsData model, context) => Container(
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
                    Column(
                      children: [
                        Text(
                          '${model.price}\$',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(height: 4,),
                        if (model.discount != 0)
                          Text(
                            '${model.old_price}',
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              height: 1.0,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),

                      ],
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        ShopAppCubit.get(context).changeFavorites(model.id);
                      },
                      child: Icon(
                        ShopAppCubit.get(context).favorite[model.id] == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 25,
                        color:
                            ShopAppCubit.get(context).favorite[model.id] == true
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
    );
