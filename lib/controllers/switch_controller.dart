import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class SwitchController extends GetxController {
  var currentSaladIndex = 0;

  void changeIndex(int index) {
    currentSaladIndex = index;
  }
}
