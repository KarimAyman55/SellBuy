

import '../../../models/add_order_data.dart';
import '../../../models/post_addresses.dart';
import '../../../models/search_model.dart';
import '../../../models/shop_login_model.dart';
import '../../../models/updateaddress_model.dart';

abstract class ShopStatus {}

class ShopInitialStatus extends ShopStatus {}

class EditPressedState extends ShopStatus {}

class ShopLoadingStatus extends ShopStatus {}

class ShopSuccessStatus extends ShopStatus {}

class ShopErrorStatus extends ShopStatus {}

class ChangeTabs extends ShopStatus {}

class ShopCategoriesSuccessStatus extends ShopStatus {}

class ShopCategoriesErrorStatus extends ShopStatus {}

class ShopLoadingProfileStatus extends ShopStatus {}

class ShopSuccessProfileStatus extends ShopStatus {
  final ShopLoginModel shopHomeModel;

  ShopSuccessProfileStatus(this.shopHomeModel);
}

class ShopErrorProfileStatus extends ShopStatus {}

class ShopLoadingUpdateUserStatus extends ShopStatus {}

class ShopSuccessUpdateUserStatus extends ShopStatus {
  ShopLoginModel user;

  ShopSuccessUpdateUserStatus(this.user);
}

class ShopErrorUpdateUserStatus extends ShopStatus {}

class SignOut extends ShopStatus {}

abstract class SearchStatus {}

class ShopSearchInitialStatus extends SearchStatus {}

class ShopLoadingSearchStatus extends SearchStatus {}

class ShopSuccessSearchStatus extends SearchStatus {
  final SearchModel searchModel;

  ShopSuccessSearchStatus(this.searchModel);
}

class ShopErrorSearchStatus extends SearchStatus {}


class ShopChangeFavoritesState extends ShopStatus {}

class ShopSuccessChangeFavouriteStatus extends ShopStatus {}

class ShopErrorChangeFavouriteStatus extends ShopStatus {}


class ShopLoadingGetFavouriteDataStatus extends ShopStatus {}

class ShopSuccessGetFavouriteDataStatus extends ShopStatus {}

class ShopErrorGetFavouriteDataStatus extends ShopStatus {}

class ShopLoadingGetHomProductDataStatus extends ShopStatus {}

class ShopSuccessGetHomProductDataStatus extends ShopStatus {}

class ShopErrorGetHomProductDataStatus extends ShopStatus {}


class ChangeIndicatorState extends ShopStatus {}

class ShopChangeCartsState extends ShopStatus {}

class ShopSuccessChangeCartsStatus extends ShopStatus {}

class ShopErrorChangeCartsStatus extends ShopStatus {}

class ShopLoadingGetCartsDataStatus extends ShopStatus {}

class ShopSuccessGetCartsDataStatus extends ShopStatus {}

class ShopErrorGetCartsDataStatus extends ShopStatus {}

class PlusQuantity extends ShopStatus {}

class MinusQuantity extends ShopStatus {}


class LoadingGetCountCarts extends ShopStatus {}

class SuccessGetCountCarts extends ShopStatus {}

class ErrorGetCountCarts extends ShopStatus {}

class ShopLoadingPostAddressesStatus extends ShopStatus {}

class ShopSuccessPostAddressesStatus extends ShopStatus {
  AddAddressModel addAddressModel;

  ShopSuccessPostAddressesStatus(this.addAddressModel);
}

class ShopErrorPostAddressesStatus extends ShopStatus {}

class ShopLoadingGetAddressesStatus extends ShopStatus {}

class ShopSuccessGetAddressesStatus extends ShopStatus {}

class ShopErrorGetAddressesStatus extends ShopStatus {}

class ShopLoadingUpdateAddressesStatus extends ShopStatus {}

class ShopSuccessUpdateAddressesStatus extends ShopStatus {
  UpdateAddressModel updateAddressModel;

  ShopSuccessUpdateAddressesStatus(this.updateAddressModel);
}

class ShopErrorUpdateAddressesStatus extends ShopStatus {}


class ShopLoadingDeleteAddressesStatus extends ShopStatus {}

class ShopSuccessDeleteAddressesStatus extends ShopStatus {}

class ShopErrorDeleteAddressesStatus extends ShopStatus {}

class FAQsLoadingState extends ShopStatus {}

class FAQsSuccessState extends ShopStatus {}

class FAQsErrorState extends ShopStatus {}

class CategoryDetailsLoadingState extends ShopStatus {}

class CategoryDetailsSuccessState extends ShopStatus {}

class CategoryDetailsErrorState extends ShopStatus {}

class ShopLoadingAddOrderStatus extends ShopStatus {}

class ShopSuccessAddOrderStatus extends ShopStatus {
  AddOrderModel addOrderModel;

  ShopSuccessAddOrderStatus(this.addOrderModel);
}

class ShopErrorAddOrderStatus extends ShopStatus {}

class GetOrdersLoadingState extends ShopStatus {}

class GetOrdersSuccessState extends ShopStatus {
  final GetOrderModel getOrderModel;

  GetOrdersSuccessState(this.getOrderModel);
}

class GetOrdersErrorState extends ShopStatus {
  final String error;

  GetOrdersErrorState(this.error);
}

class OrderDetailsLoadingState extends ShopStatus {}

class OrderDetailsSuccessState extends ShopStatus {
  final OrderDetailsModel orderDetailsModel;

  OrderDetailsSuccessState(this.orderDetailsModel);
}

class OrderDetailsErrorState extends ShopStatus {
  final String error;

  OrderDetailsErrorState(this.error);
}

class CancelOrderLoadingState extends ShopStatus {}

class CancelOrderSuccessState extends ShopStatus {
  final CancelOrderModel cancelOrderModel;

  CancelOrderSuccessState(this.cancelOrderModel);
}

class CancelOrderErrorState extends ShopStatus {
  final String error;

  CancelOrderErrorState(this.error);
}
