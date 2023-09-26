import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellbuy/shared/Constants/Components.dart';
import '../models/get_addresses_model.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/cubit.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/status.dart';
import 'UpdateAddress.dart';
import 'order_screen.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopStatus>(
      listener: (BuildContext context, state) {
        if (state is ShopSuccessAddOrderStatus) {
          if (state.addOrderModel.status) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.scale,
              title: 'Your Order in progress',
              desc:
                  " ordered by successfully.\n For details check Menu.",
              btnOkText: "Order",
              btnOkOnPress: () {
                Navigator.pop(context);
                ShopAppCubit.get(context).onChangeTabs(3);
                pushTo(context, const MyOrdersScreen());
              },
              btnCancelOnPress: () {
                Navigator.pop(context);
              },
              btnCancelText: "Home",
              btnCancelColor: Colors.green,
              btnOkIcon: Icons.list_alt_outlined,
              btnCancelIcon: Icons.home,
              width: 400,
            ).show();
          }
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = ShopAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            backgroundColor: Colors.white,
            leading: InkWell(
              onTap: (){Navigator.pop(context);},
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.deepOrange,
                size: 24,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
            title: const Text(
              'Location Info',
              style: TextStyle(fontSize: 18, color: Colors.redAccent),
            ),
          ),
          bottomNavigationBar: navigateToBar(
            context,
            cubit.addressModel!.data!.data!.isEmpty
                ? null
                : cubit.addressModel!.data!.data!.first,
          ),
          body: cubit.addressModel!.data!.data!.isEmpty
              ? const Center(
                  child: Text(
                  ' add New Address for complete process 🙁',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                ))
              : cubit.addressModel!.data!.data!.isEmpty
                  ? const Center(
                      child: Text(
                      ' Tab To Add Address ',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal),
                    ))
                  : ListView.builder(
                      itemBuilder: (BuildContext context, int index) =>
                          buildLocationItem(
                              cubit.addressModel!.data!.data![index], context),
                      itemCount: cubit.addressModel!.data!.data!.length,
                    ),
        );
      },
    );
  }
}

Widget buildLocationItem(AddressData model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              border: Border.all(color: Colors.black),
            ),
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Country :   ${model.name}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          pushTo(
                              context,
                              UpdateAddressScreen(
                                isEdit: true,
                                addressId: model.id,
                                name: model.name,
                                city: model.city,
                                region: model.region,
                                details: model.details,
                                notes: model.notes,
                              ));
                        },
                        child: const Row(
                          children: [
                            Text(
                              'Edit',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),

                            Icon(
                              Icons.edit,
                              color: Colors.indigoAccent,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'city  :   ${model.city}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'centre or street :   ${model.region}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        'details :   ${model.details}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          ShopAppCubit.get(context)
                              .deleteAddress(addressId: model.id);
                        },
                        child: const Row(
                          children: [

                            Text(
                              'Remove',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(width: 4,),
                            Icon(
                              Icons.delete,
                              color: Colors.green,
                              size: 24,
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

Widget navigateToBar(context, AddressData? model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: model == null
          ? MaterialButton(
              height: 40,
              onPressed: () {
                pushTo(
                    context,
                    UpdateAddressScreen(
                      isEdit: false,
                    ));
              },
              color: Colors.deepOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: const Text(
                'Add New Address',
                style: TextStyle(color: Colors.white),
              ),
            )
          : MaterialButton(
              height: 40,
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.question,
                  animType: AnimType.scale,
                  title: 'Are you want to Confirm this Order ?',
                  btnOkOnPress: () {
                    ShopAppCubit.get(context).addOrder(addressId: model.id);
                  },
                  btnCancelText: "Cancel",
                  btnCancelOnPress: () {},
                ).show();
              },
              color: Colors.indigoAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: const Text(
                'Tab To Order',
                style: TextStyle(color: Colors.white),
              ),
            ),
    );
