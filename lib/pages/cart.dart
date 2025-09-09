import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:menu_ordering_app/controller/cart_controller.dart';
import 'package:menu_ordering_app/data/menu_data.dart';
import 'package:menu_ordering_app/widgets/currency.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final cart = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8.h,
        child: GetBuilder<CartController>(builder: (c) {
          
          final itemsInCart = MenuData.items.where((it) => c.quantityOf(it) > 0).toList(growable: false);
        
          if (itemsInCart.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }
        
          return ListView.builder(
            itemCount: itemsInCart.length + 1,
            itemBuilder: (context, index) {
              if (index < itemsInCart.length) {
                final item = itemsInCart[index];
                return ListTile(
                  leading: SizedBox(
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
                  title: Text(item.name),
                  subtitle: Text('${idr(item.price)} x ${c.quantityOf(item)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(idr(c.subtotalFor(item))),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => c.remove(item),
                      ),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(idr(c.totalPrice),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      ElevatedButton(
                        onPressed: c.totalQuantity == 0
                            ? null
                            : () {
                                Get.snackbar('Checkout', 'Order checkout completed!');
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8800),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Checkout'),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        }),
      ),
    
    );
  }
}