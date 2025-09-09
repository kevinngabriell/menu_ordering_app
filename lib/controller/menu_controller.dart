
import 'package:get/get.dart';
import '../data/menu_data.dart';
import 'cart_controller.dart';

class MenuController extends GetxController {
  final items = MenuData.items;
  late final CartController cart;

  @override
  void onInit() {
    super.onInit();
    cart = Get.find<CartController>();
    cart.setPriceSource(items);
  }

  List<MenuItem> get cartItems =>
      items.where((it) => cart.quantityOf(it) > 0).toList(growable: false);
}
