import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/AppBloc/Appcubit&&ٍSearchCubit/cubit.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/status.dart';

class UpdateAddressScreen extends StatelessWidget {
  TextEditingController nameControl = TextEditingController();
  TextEditingController cityControl = TextEditingController();
  TextEditingController regionControl = TextEditingController();
  TextEditingController detailsControl = TextEditingController();
  TextEditingController notesControl = TextEditingController();

  var addressFormKey = GlobalKey<FormState>();

  final bool isEdit;
  final int? addressId;
  final String? name;
  final String? city;
  final String? region;
  final String? details;
  final String? notes;

  UpdateAddressScreen({super.key,
    required this.isEdit,
    this.addressId,
    this.name,
    this.city,
    this.region,
    this.details,
    this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopStatus>(
      listener: (context, state) {
        if (state is ShopSuccessUpdateAddressesStatus) {
          if (state.updateAddressModel.status) {
            Navigator.pop(context);
          }
        } else if (state is ShopSuccessPostAddressesStatus &&
            state.addAddressModel.status) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (isEdit) {
          nameControl.text = name!;
          cityControl.text = city!;
          regionControl.text = region!;
          detailsControl.text = details!;
          notesControl.text = notes!;
        }
        return Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            titleSpacing: 10,
            title: const Row(
              children: [
                Image(
                  image: AssetImage('assets/img/sellbuy2.png'),
                  width: 40,
                  height: 40,
                ),
                Text(
                  'SellBuy',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: addressFormKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state is ShopLoadingPostAddressesStatus ||
                          state is ShopLoadingUpdateAddressesStatus)
                        const Column(
                          children: [
                            LinearProgressIndicator(),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      const Text(
                        ' Your Details ',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Country',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextFormField(
                          controller: nameControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: ' enter your Country name',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'must not be Empty';
                            }
                          }),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'City',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextFormField(
                          controller: cityControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: ' enter your City name',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'must not be Empty';
                            }
                          }),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Region',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextFormField(
                          controller: regionControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: ' enter your region',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'must not be Empty';
                            }
                          }),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Details',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextFormField(
                          controller: detailsControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: ' enter more details',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                            border: UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' must not be Empty';
                            }
                          }),
                      const SizedBox(
                        height: 60,
                      ),
                    ]),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: MaterialButton(
              height: 35,
              onPressed: () {
                if (addressFormKey.currentState!.validate()) {
                  if (isEdit) {
                    ShopAppCubit.get(context).updateAddress(
                        addressId: addressId,
                        name: nameControl.text,
                        city: cityControl.text,
                        region: regionControl.text,
                        details: detailsControl.text,
                      );
                  } else {
                    ShopAppCubit.get(context).postAddressesData(
                        name: nameControl.text,
                        city: cityControl.text,
                        region: regionControl.text,
                        details: detailsControl.text,
                      );
                  }
                }
              },
              color: Colors.indigoAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: const Text(
                ' Save ',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
