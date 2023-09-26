import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/cubit.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/status.dart';
import '../shared/Constants/Components.dart';
import '../shared/Constants/Consts.dart';

class ProfileScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ShopAppCubit>(context)..getShopProfileData(),
      child: BlocConsumer<ShopAppCubit, ShopStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopAppCubit cubit = ShopAppCubit.get(context);
          var model = cubit.userModel;
          nameController.text = model!.data!.name!;
          phoneController.text = model.data!.phone!;
          return Scaffold(

            appBar: AppBar(
              elevation: 1.0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              titleSpacing: 0,
              title: const Row(
                children: [
                  // Image(image: AssetImage('assets/images/ShopLogo.png'),width: 50, height: 50,),
                  Text(
                    'SellBuy',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            body: ShopAppCubit.get(context).userModel == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state is ShopLoadingUpdateUserStatus)
                          const Column(
                            children: [
                              LinearProgressIndicator(),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        Container(
                          color: Colors.white,
                          width: double.infinity,
                          height: 280,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Account Info',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                        onPressed: () {
                                          editPressed(
                                              context: context,
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              email:
                                                  cubit.userModel!.data!.email);
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              editText,
                                              style: const TextStyle(
                                                  color: Colors.indigo),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),

                                            const Icon(
                                              Icons.edit,
                                              color: Colors.indigo,
                                              size: 15,
                                            ),

                                          ],
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  'Your Name',
                                  style: TextStyle(fontSize: 15),
                                ),
                                defaultFormField(
                                    controller: nameController,
                                    context: context,
                                    prefix: Icons.person,
                                    enabled: isEdit ? true : false,
                                    validate: (value) {}),
                                const SizedBox(
                                  height: 40,
                                ),
                                const Text(
                                  'Your Phone',
                                  style: TextStyle(fontSize: 15),
                                ),
                                defaultFormField(
                                    context: context,
                                    controller: phoneController,
                                    prefix: Icons.phone,
                                    enabled: isEdit ? true : false,
                                    validate: (value) {}),
                              ]),
                        ),

                        Container(
                          width: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),color: Colors.white,
                            border: const Border.fromBorderSide(BorderSide(color: Colors.red))
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name : ${cubit.userModel!.data!.name!}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Email : ${cubit.userModel!.data!.email}',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
