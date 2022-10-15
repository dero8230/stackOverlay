import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/add_money_widget.dart';
import '../views/repay_money_widget.dart';
import '../views/send_money_widget.dart';

class HomePageController extends GetxController {
  HomePageController(this.updat);
  final itemsDataFilling = <Widget>[].obs;
  final itemsDataPopped = <Widget>[].obs;
  Rx<double> initialSliderValue = 150000.0.obs;
  Rx<bool> toggleBankBool = false.obs;
  Rx<int> itemsDataLength = 0.obs;
  GlobalKey<ScaffoldState>? homeKey;
  final Function() updat;
  @override
  void onInit() {
    addInitialDataToStack();
    itemsDataLength.value = itemsDataFilling.length;
    super.onInit();
  }

  addInitialDataToStack() {
    itemsDataFilling.add(const AddMoneyToWallet());
    itemsDataFilling.add(RepayMoneyWidget());
    itemsDataFilling.add(SendMoneyWidget());
  }

  removeAboveStackItem(int index, BuildContext context) {
    if (index == itemsDataFilling.length - 1) return;
    int i = itemsDataLength.value - 1;
    final homeContext = homeKey!.currentContext;
    while (i > index) {
      itemsDataPopped.add(itemsDataFilling[i]);
      itemsDataLength.value -= 1;
      i--;
      update();
      (context as Element).markNeedsBuild();
      (homeContext as Element).markNeedsBuild();
      updat.call();
    }
    print("removeAboveStackItem:  ${itemsDataLength.value}");
  }

  updateBankToggle(var boolValue) {
    toggleBankBool.value = boolValue;
  }
}
