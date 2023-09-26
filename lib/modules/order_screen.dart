import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../models/add_order_data.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/cubit.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/status.dart';
import '../shared/Constants/Components.dart';


class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopStatus>(
      listener: (context, state) {
        if (state is CancelOrderSuccessState) {
          if (state.cancelOrderModel.status) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.scale,
              title: 'wait for Cancel ',
              desc: " cancelled by successfully!",
              btnOkOnPress: () {},
            ).show();
          } else {}
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            title: const Row(
              children: [
                Text(
                  'Orders',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Text(
                          '${ShopAppCubit.get(context).ordersDetails.length}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Items',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: ConditionalBuilder(
            condition:
                ShopAppCubit.get(context).orderModel!.data.data.isNotEmpty,
            builder: (context) => ConditionalBuilder(
              condition: ShopAppCubit.get(context).ordersDetails.isNotEmpty,
              // state is! CancelOrderLoadingState,
              builder: (context) => SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      itemBuilder: (context, index) => buildOrderItem(
                          ShopAppCubit.get(context).ordersDetails[index].data,
                          context,
                          state),
                      separatorBuilder: (context, index) => Container(),
                      itemCount: ShopAppCubit.get(context).ordersDetails.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ],
                ),
              ),
              fallback: (context) => const Divider(),
            ),
            fallback: (context) => buildNoOrders(context),
          ),
        );
      },
    );
  }

  Widget buildOrderItem(OrderDetailsData model, context, state) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Order ID:",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          model.id.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      model.date,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.6),

                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    const Text(
                      "Cost : ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "${NumberFormat.currency(decimalDigits: 0, symbol: "").format(model.cost)} LE",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,

                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    const Text(
                      "TAX : ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "${NumberFormat.currency(decimalDigits: 0, symbol: "").format(model.vat)} LE",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    const Text(
                      "Total Amount : ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "${NumberFormat.currency(decimalDigits: 0, symbol: "").format(model.total)} LE",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      model.status,
                      style: TextStyle(
                        color:
                            (model.status == "New") ? Colors.green : Colors.red,

                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    if (model.status == "New")
                      bottom(
                        text: "Cancel",
                        width: 105,
                        height: 34,
                        color: Colors.deepOrange,
                        onpressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.question,
                            animType: AnimType.scale,
                            title: 'Are you Sure for Cancel Order ?',
                            btnOkOnPress: () {
                              ShopAppCubit.get(context)
                                  .cancelOrder(id: model.id);
                            },
                            btnCancelOnPress: () {},
                          ).show();
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildNoOrders(context) => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 50,
              child: Icon(
                Icons.list_alt_outlined,
                size: 60,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'No Orders yet',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}
