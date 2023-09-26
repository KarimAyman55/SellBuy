import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellbuy/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/status.dart';
import 'package:sellbuy/shared/Constants/Components.dart';
import 'package:sellbuy/shared/remote/CasheHelper.dart';
import '../../../models/add_order_data.dart';
import '../../../models/categoriesdetailsdatal.dart';
import '../../../models/change_cart_items.dart';
import '../../../models/change_favourite_model.dart';
import '../../../models/faqs_model.dart';
import '../../../models/get_addresses_model.dart';
import '../../../models/get_cart_data.dart';
import '../../../models/get_favourite_data.dart';
import '../../../models/get_homedata.dart';
import '../../../models/post_addresses.dart';
import '../../../models/shop_category_model.dart';
import '../../../models/shop_login_model.dart';
import '../../../models/shopappmodel.dart';
import '../../../models/updateaddress_model.dart';
import '../../../modules/category_screen.dart';
import '../../../modules/favourit_screen.dart';
import '../../../modules/home_screen.dart';
import '../../../modules/login_screen.dart';
import '../../../modules/setting_screen.dart';
import '../../../network/end_points/end_points.dart';
import '../../Constants/Consts.dart';
import '../../remote/dio.helper.dart';

class ShopAppCubit extends Cubit<ShopStatus> {
  ShopAppCubit() : super(ShopInitialStatus());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  //change Bottom nav bar
  int currentIndex = 0;
  Color? color = Colors.grey[300];

  void onChangeTabs(int index) {
    currentIndex = index;
    emit(ChangeTabs());
  }

  bool? icon;

  final iconData = [
    const Icon(
      Icons.home_filled,
      size: 30.0,
      color: Colors.indigo,
    ),
    const Icon(
      Icons.auto_graph_outlined,
      size: 30.0,
      color: Colors.indigo,
    ),
    const Icon(
      Icons.favorite,
      size: 30.0,
      color: Colors.indigo,
    ),

  ];

  // App Screens
  List<Widget> screens = [
    const HomeScreen(),
    const CategoryScreen(),
    const FavouriteScreen(),
    ];

  // method get home Data
  ShopHomeModel? shopHomeModel;
  IconData? favIcon;
  Map<int, bool> favorite = {};
  Map<int, bool> inCart = {};

  void getHomeData() {
    emit(ShopLoadingStatus());
    Diohelper.getdata(url: HOME, Token: token).then((value) {
      emit(ShopSuccessStatus());
      shopHomeModel = ShopHomeModel.fromjsom(value.data);
      shopHomeModel!.data!.products.forEach((element) {
        favorite.addAll({
          element.id: element.infavorites,
        });
      });
      shopHomeModel!.data!.products.forEach((element) {
        inCart.addAll({
          element.id: element.Incart,
        });
      });
      }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorStatus());
    });
  }

  // getProductData
  ProductDetailsModel? productDetailsModel;

  void getProductData(String id) {
    productDetailsModel = null;
    emit(ShopLoadingGetHomProductDataStatus());
    Diohelper.getdata(url: 'products/$id', Token: token).then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      emit(ShopSuccessGetHomProductDataStatus());
    }).catchError((error) {
      emit(ShopErrorGetHomProductDataStatus());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  // method get home Category Data
  CategoryModel? categoryModel;

  void getCategoryModel() {
    Diohelper.getdata(url: CATEGORIES).then((value) {
      categoryModel = CategoryModel.formjson(value.data);
      emit(ShopCategoriesSuccessStatus());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopCategoriesErrorStatus());
    });
  }

  // method get User profile
  ShopLoginModel? userModel;

  void getShopProfileData() {
    emit(ShopLoadingProfileStatus());
    Diohelper.getdata(url: SETTING, Token: token).then((value) {
      userModel = ShopLoginModel.formjson(value.data);
      emit(ShopSuccessProfileStatus(userModel!));
    }).catchError((error) {
      error.toString();
      emit(ShopErrorProfileStatus());
    });
  }

  // method put&Update User Data
  void getShopUpdateProfileData({
    required String? name,
    required String? email,
    required String? phone,
  }) {
    emit(ShopLoadingUpdateUserStatus());
    Diohelper.PutData(
      url: update_profile,
      Token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      getShopProfileData();
      userModel = ShopLoginModel.formjson(value.data);
      emit(ShopSuccessUpdateUserStatus(userModel!));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorUpdateUserStatus());
    });
  }

  // method Sign Out
  void signOut(context) {
    CacheHelper.removeData('token').then((value) {
      pushAndFinish(context, ShopLoginScreen());
      ShopAppCubit.get(context).currentIndex = 0;
      emit(SignOut());
    });
  }

  // method change favourite model
  ChangeFavouriteModel? changeFavouriteModel;

  void changeFavorites(int productId) {
    if (favorite[productId] == true) {
      favorite[productId] = false;
    } else {
      favorite[productId] = true;
    }
    emit(ShopChangeFavoritesState());
    Diohelper.PostData(
      url: FAVOURITE,
      data: {
        'product_id': productId,
      },
      Token: token,
    ).then((value) {
      changeFavouriteModel = ChangeFavouriteModel.fromjson(value.data);
      getFavData();
      emit(ShopSuccessChangeFavouriteStatus());
    }).catchError((error) {
      if (favorite[productId] == true) {
        favorite[productId] = false;
        favIcon = Icons.favorite;
      } else {
        favorite[productId] = true;
        favIcon = Icons.favorite_border;
      }

      emit(ShopErrorChangeFavouriteStatus());
    });
  }

  // get favourite data
  getfavoyritedata? getFavouriteData;

  void getFavData() {
    emit(ShopLoadingGetFavouriteDataStatus());
    Diohelper.getdata(url: FAVOURITE, Token: token).then((value) {
      getFavouriteData = getfavoyritedata.fromJson(value.data);
      emit(ShopSuccessGetFavouriteDataStatus());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorGetFavouriteDataStatus());
    });
  }

  // changeVal
  int value = 0;

  void changeVal(val) {
    value = val;
    emit(ChangeIndicatorState());
  }

  // changeCart
  ChangeCartModel? changeCartModel;

  void changeCart(int productId) {
    if (inCart[productId] == true) {
      inCart[productId] = false;
    } else {
      inCart[productId] = true;
    }
    emit(ShopChangeCartsState());
    Diohelper.PostData(
      url: CARTS,
      data: {
        'product_id': productId,
      },
      Token: token,
    ).then((value) {
      changeCartModel = ChangeCartModel.fromjson(value.data);
      getCartData();
      emit(ShopSuccessChangeCartsStatus());
    }).catchError((error) {
      if (inCart[productId] == true) {
        inCart[productId] = false;
      } else {
        inCart[productId] = true;
      }
      emit(ShopErrorChangeCartsStatus());
    });
  }

  // get cart data
  GetCartModel? getCartModel;

  void getCartData() {
    emit(ShopLoadingGetCartsDataStatus());
    Diohelper.getdata(url: CARTS, Token: token).then((value) {
      getCartModel = GetCartModel.fromJson(value.data);
      if (kDebugMode) {
        print(value.toString());
      }
      emit(ShopSuccessGetCartsDataStatus());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorGetCartsDataStatus());
    });
  }

  // plusQuantity
  int quantity = 1;

  void plusQuantity(GetCartModel model, index) {
    emit(PlusQuantity());
    quantity = model.data.cartItems[index].quantity;
    quantity++;
    emit(PlusQuantity());
  }

  //minusQuantity
  void minusQuantity(GetCartModel model, index) {
    quantity = model.data.cartItems[index].quantity;
    if (quantity > 1) quantity--;
    emit(MinusQuantity());
  }

  // updateCartData
  void updateCartData({required String id, int? quantity}) {
    emit(LoadingGetCountCarts());
    Diohelper.PutData(
            url: UPATECARTS + id,
            data: {
              'quantity': quantity,
            },
            Token: token)
        .then((value) {
      getCartData();
      emit(SuccessGetCountCarts());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorGetCountCarts());
    });
  }

  /// POST addresses
  AddAddressModel? addAddressModel;

  void postAddressesData({
    required String name,
    required String city,
    required String region,
    required String details,
    double latitude = 30.0616863,
    double longitude = 31.3260088,
  }) {
    emit(ShopLoadingPostAddressesStatus());
    Diohelper.PostData(
      url: Ad_ADDRESSES,
      data: {
        'name': name,
        'city': city,
        'region': region,
        'details': details,
        'latitude': latitude,
        'longitude': longitude,
      },
      Token: token,
    ).then((value) {
      addAddressModel = AddAddressModel.fromJson(value.data);
      if (addAddressModel!.status) {
        getAddresses();
      } else {
        showToast(addAddressModel!.message);
      }
      emit(ShopSuccessPostAddressesStatus(addAddressModel!));
    }).catchError((error) {
      emit(ShopErrorPostAddressesStatus());
    });
  }

  // get Adresses data
  AddressModel? addressModel;

  void getAddresses() {
    emit(ShopLoadingGetAddressesStatus());
    Diohelper.getdata(
      url: ADDRESSES,
      Token: token,
    ).then((value) {
      addressModel = AddressModel.fromJson(value.data);
      emit(ShopSuccessGetAddressesStatus());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorGetAddressesStatus());
    });
  }

  // UpdateAddressModel
  UpdateAddressModel? updateAddressModel;

  void updateAddress({
    required int? addressId,
    required String name,
    required String city,
    required String region,
    required String details,
    double latitude = 30.0616863,
    double longitude = 31.3260088,
  }) {
    emit(ShopLoadingUpdateAddressesStatus());
    Diohelper.PutData(url: 'addresses/$addressId', Token: token, data: {
      'name': name,
      'city': city,
      'region': region,
      'details': details,
      'latitude': latitude,
      'longitude': longitude,
    }).then((value) {
      updateAddressModel = UpdateAddressModel.fromJson(value.data);
      getAddresses();
      if (updateAddressModel!.status) {
        getAddresses();
      }
      emit(ShopSuccessUpdateAddressesStatus(updateAddressModel!));
    }).catchError((error) {
      emit(ShopErrorUpdateAddressesStatus());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  // deleteAddress
  UpdateAddressModel? deleteAddressModel;

  void deleteAddress({required addressId}) {
    emit(ShopLoadingDeleteAddressesStatus());
    Diohelper.deleteData(
      url: 'addresses/$addressId',
      token: token,
    ).then((value) {
      deleteAddressModel = UpdateAddressModel.fromJson(value.data);
      if (deleteAddressModel!.status) getAddresses();
      emit(ShopSuccessDeleteAddressesStatus());
    }).catchError((error) {
      emit(ShopErrorDeleteAddressesStatus());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  // FAQs Data
   FAQsModel?   faqsModel ;

  void getFAQsData() {
    emit(FAQsLoadingState());
    Diohelper.getdata(
      url: 'faqs',
    ).then((value) {
      faqsModel = FAQsModel.fromJson(value.data);
      emit(FAQsSuccessState());
    }).catchError((error) {
      emit(FAQsErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  // getCategoriesDetailData

  CategoryDetailModel? categoriesDetailModel;

  void getCategoriesDetailData(int? categoryID) {
    emit(CategoryDetailsLoadingState());
    Diohelper.getdata(url: CATEGORIES_DETAIL, query: {
      'category_id': '$categoryID',
    }).then((value) {
      categoriesDetailModel = CategoryDetailModel.fromJson(value.data);
      emit(CategoryDetailsSuccessState());
    }).catchError((error) {
      emit(CategoryDetailsErrorState());
    });
  }

  /// Add Order
  AddOrderModel? addOrderModel;

  void addOrder({required int addressId, context}) {
    emit(ShopLoadingAddOrderStatus());
    Diohelper.PostData(
      url: Orders,
      data: {
        'address_id': addressId,
        'payment_method': 1,
        'use_points': false,
      },
      Token: token,
    ).then((value) {
      addOrderModel = AddOrderModel.fromJson(value.data);
      if (addOrderModel!.status) {
        getCartData();
        getOrders();
        emit(ShopSuccessAddOrderStatus(addOrderModel!));
      } else {
        getCartData();
        getOrders();
      }
    }).catchError((error) {
      emit(ShopErrorAddOrderStatus());
    });
  }

  // get Order
  GetOrderModel? orderModel;

  void getOrders() {
    emit(GetOrdersLoadingState());
    Diohelper.getdata(url: Orders, Token: token).then((orders) {
      orderModel = GetOrderModel.fromJson(orders.data);
      ordersDetails.clear();
      ordersIds.clear();
      orderModel!.data.data.forEach((element) {
        ordersIds.add(element.id);
      });
      emit(GetOrdersSuccessState(orderModel!));
      getOrdersDetails();
    }).catchError((error) {
      emit(GetOrdersErrorState(error));
      });
  }

  // getOrdersDetails
  List<int> ordersIds = [];
  OrderDetailsModel? orderItemDetails;
  List<OrderDetailsModel> ordersDetails = [];

  void getOrdersDetails() async {
    emit(OrderDetailsLoadingState());
    if (ordersIds.isNotEmpty) {
      for (var id in ordersIds) {
        await Diohelper.getdata(url: "$Orders/$id", Token: token)
            .then((orderDetails) {
          orderItemDetails = OrderDetailsModel.fromJson(orderDetails.data);
          ordersDetails.add(orderItemDetails!);
          emit(OrderDetailsSuccessState(orderItemDetails!));
        }).catchError((error) {
          emit(OrderDetailsErrorState(error));
          return;
        });
      }
    }
  }

  // cancelOrder
  CancelOrderModel? cancelOrderModel;

  void cancelOrder({required int id}) {
    emit(CancelOrderLoadingState());
    Diohelper.getdata(url: "orders/$id/cancel", Token: token).then((value) {
      cancelOrderModel = CancelOrderModel.fromJson(value.data);
      getOrders();
      emit(CancelOrderSuccessState(cancelOrderModel!));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(CancelOrderErrorState(error));
    });
  }
}
