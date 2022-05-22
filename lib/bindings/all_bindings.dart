import 'package:final_food_project/controllers/discount_controller.dart';
import 'package:final_food_project/controllers/tabbar_controller.dart';
import 'package:get/get.dart';

///
import '../controllers/drawer_controller.dart';
import '../controllers/food_controller.dart';
import '../controllers/navigator_controllers.dart';
import '../controllers/splash_controller.dart';
import '../controllers/switch_controller.dart';
import '../controllers/wallet_controller.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigatorController());
    Get.lazyPut(() => TabBarController());
    Get.lazyPut(() => SwitchController());
    Get.lazyPut(() => FoodController());
    Get.lazyPut(() => WalletController());
    Get.lazyPut(() => SplashController());
    Get.lazyPut(() => MainDrawerController());
    Get.lazyPut(() => DiscountController());
  }
}
