import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class NavigatorController extends GetxController {
  var currentIndex = 0;

  void changeNavBarIndex(int index) {
    currentIndex = index;
    update(["change NavBar Index"]);
  }
}
