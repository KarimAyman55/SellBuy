import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/faqs_model.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/cubit.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/status.dart';
import '../shared/Constants/Consts.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShopAppCubit()..getFAQsData(),
      child: BlocConsumer<ShopAppCubit, ShopStatus>(
          listener: (context, state) {},
          builder: (context, state) {
            ShopAppCubit cubit = ShopAppCubit.get(context);
            return Scaffold(
              backgroundColor: primColors,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 1.0,
                titleSpacing: 0,
                title: const Row(
                  children: [
                    Image(
                      image: AssetImage('assets/img/sellbuy.png'),
                      width: 50,
                      height: 40,
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
              body: state is FAQsLoadingState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => faqsItemBuilder(
                                  cubit.faqsModel!.data!.data![index] ),
                              separatorBuilder: (context, index) => myDivider(),
                              itemCount: cubit.faqsModel!.data!.data!.length ),
                        ],
                      ),
                    ),
            );
          }),
    );
  }

  Widget faqsItemBuilder(FAQsData model) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${model.question}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            '${model.answer}',
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
