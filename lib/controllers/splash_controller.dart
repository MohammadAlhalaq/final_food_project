import 'package:final_food_project/controllers/fb_auth_controller.dart';
import 'package:final_food_project/navigator.dart';
import 'package:final_food_project/pages/introduction.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  /// For showing introduction screen just once
  final box = GetStorage();

  bool get showIntro => box.read('showIntro') ?? true;

  void changeBool(bool val) {
    box.write('showIntro', val);
    update();
  }

  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Get.offAll(
          () => FbAuthController().isLoggedIn()
              ? const MainNavigator()
              : const IntroductionPage(),
          transition: Transition.zoom,
        );
      },
    );

    super.onInit();
  }
}
