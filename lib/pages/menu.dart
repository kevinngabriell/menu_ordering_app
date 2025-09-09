import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:menu_ordering_app/controller/cart_controller.dart';
import 'package:menu_ordering_app/data/menu_data.dart';
import 'package:menu_ordering_app/pages/cart.dart';
import 'package:menu_ordering_app/widgets/currency.dart';

class MenuOrder extends StatefulWidget {
  const MenuOrder({super.key});

  @override
  State<MenuOrder> createState() => _MenuOrderState();
}

class _MenuOrderState extends State<MenuOrder> {
  late final CartController cart;
  final items = MenuData.items;

  //Controller to count increment item and total price
  @override
  void initState() {
    super.initState();
    cart = Get.find<CartController>();
    cart.setPriceSource(items);
  }

  @override
  Widget build(BuildContext context) {
  var cart = Get.find<CartController>();

  return Scaffold(
    appBar: AppBar(
      title: Text("Menu"),
    ),
    body: ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index){
      final MenuItem item = items[index];
      return Card(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Padding(
          padding: EdgeInsets.all(11),
          child: Row(
            children: [
              SizedBox(
                width: 60,  
                height: 60, 
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    item.imageAsset ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),),
                    SizedBox(height: 4,),
                    Text(idr(item.price), style: TextStyle(fontWeight: FontWeight.w600),)
                   ],
                )
              ),
              GetBuilder<CartController>(
                builder: (controller) {
                  final q = controller.quantityOf(item);

                  return Row(
                    children: [
                      IconButton(
                        onPressed: q > 0 ? () => controller.decrease(item) : null,
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text(q.toString()),
                      IconButton(
                        onPressed: () => controller.increase(item),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ]
                  );
                }
              )
            ],
          ),
        ),
      );}
    ),
    bottomNavigationBar: Obx((){
      final totalQty = cart.totalQuantity;
      final totalPrice = cart.totalPrice;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => Get.to(() => const Cart()),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF8800),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            label: Text(
              totalQty > 0
                ? 'View Cart — $totalQty item(s) • ${idr(totalPrice)}' : 'View Cart',
            ),
          )
        )
      ); }) 
    );
  }
}