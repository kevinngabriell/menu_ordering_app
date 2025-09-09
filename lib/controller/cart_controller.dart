
import 'package:get/get.dart';
import 'package:menu_ordering_app/data/menu_data.dart';

class CartController extends GetxController {
  final RxMap<String, int> _qty = <String, int>{}.obs;
  final RxMap<String, int> _priceById = <String, int>{}.obs;

  Map<String, int> get qty => _qty;

  void setPriceSource(List<MenuItem> items) {
    for (final it in items) {
      _priceById[it.id] = it.price;
    }
  }

  int _priceOf(String id) => _priceById[id] ?? 0;

  int get totalQuantity => _qty.values.fold(0, (a, b) => a + b);

  int get totalPrice => _qty.entries.fold(0, (sum, e) => sum + (e.value * _priceOf(e.key)));

  int subtotalFor(MenuItem item) => ( _qty[item.id] ?? 0 ) * item.price;

  void increase(MenuItem item) {
    _qty[item.id] = (_qty[item.id] ?? 0) + 1;
    update();
  }

  void decrease(MenuItem item) {
    final current = _qty[item.id] ?? 0;
    if (current <= 1) {
      _qty.remove(item.id);
    } else {
      _qty[item.id] = current - 1;
    }
    update();
  }

  void remove(MenuItem item) {
    _qty.remove(item.id);
    update();
  }

  int quantityOf(MenuItem item) => _qty[item.id] ?? 0;

  bool isInCart(MenuItem item) => quantityOf(item) > 0;

  List<String> get itemIdsInCart =>
      _qty.entries.where((e) => e.value > 0).map((e) => e.key).toList(growable: false);
}
