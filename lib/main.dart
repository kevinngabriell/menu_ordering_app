import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:menu_ordering_app/controller/cart_controller.dart';
import 'package:menu_ordering_app/pages/menu.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          initialRoute: '/home',
          initialBinding: BindingsBuilder(() {
            Get.put<CartController>(CartController(), permanent: true);
          }),
          getPages: [
            GetPage(name: '/home', page: () => MenuOrder()),
          ],
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
              child: widget!,
            );
          },
        );
      },
    )
  );
}
