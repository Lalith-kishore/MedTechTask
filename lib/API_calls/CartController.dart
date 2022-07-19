import 'package:get/state_manager.dart';
import 'package:med_tech/Model/FetchCartModel.dart';

class CartController extends GetxController {
  var cartItems = <ProductModel>[].obs;
  var cartItemsPrice = <PriceListModel>[].obs;
  int get count => cartItems.length;
  double get totalPrice => cartItemsPrice.fold(0, (sum, item) => sum + int.parse(item.productMrp.toString()));

  addToCart(ProductModel product) {
    cartItems.add(product);
  }

  addToCartPriceDetails(PriceListModel productMrp) {
    cartItemsPrice.add(productMrp);
  }
}
