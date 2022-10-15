import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project_app/controller/home_page_controller.dart';
import 'package:test_project_app/views/bottom_bar_widget.dart';

import 'CategoriesScroller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  final animatedListKey = GlobalKey<AnimatedListState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final padding = 70.0;
  int animationDuration = 1500;

  Future<bool> _onWillPop() async {
    print("onPop Called");
    // controller.removeAboveStackItem(controller.itemsDataFilling.length -2 >= 0 ? controller.itemsDataFilling.length -2 : 0, animatedListKey);
    return false;
  }

  List<Widget> _buildList(HomePageController controller) {
    print("buildList Called");
    final widgets = <Widget>[];
    for (int i = 0; i < controller.itemsDataFilling.length; i++) {
      final alignment = itemsAlignment(i, controller);
      final item = Padding(
        padding: EdgeInsets.only(top: (padding * i)),
        child: AnimatedAlign(
            alignment: alignment,
            duration: Duration(milliseconds: animationDuration),
            child: controller.itemsDataFilling[i]),
      );
      widgets.add(item);
    }
    return widgets;
  }

  Alignment itemsAlignment(int index, HomePageController controller) {
    print("itemsAlignment: ${controller.itemsDataFilling.length} $index");
    final i = index + 1;
    if (index >= controller.itemsDataLength.value) {
      return const Alignment(0, 20);
    }
    return Alignment.topCenter;
  }

  @override
  Widget build(BuildContext context) {
    final HomePageController controller = Get.put(HomePageController(() {
      setState(() {});
    }));
    final Size size = MediaQuery.of(context).size;
    controller.homeKey = scaffoldKey;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xff121419),
        key: scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xff121419),
          leading: const Icon(
            Icons.cancel,
            color: Colors.grey,
          ),
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(Icons.search, color: Colors.black),
            //   onPressed: () {},
            // ),
            IconButton(
              icon: const Icon(Icons.question_mark_rounded, color: Colors.grey),
              onPressed: () {},
            )
          ],
        ),
        body: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            SizedBox(
              height: size.height,
              // child: Stack(
              //   children: <Widget>[
              //     // Expanded(
              //     //   child:
              //     //   Obx(() => AnimatedList(
              //     //     key: animatedListKey,
              //     //     initialItemCount: controller.itemsDataFilling.length,
              //     //     // physics: const NeverScrollableScrollPhysics(),
              //     //     //  clipBehavior: Clip.none,
              //     //     // scrollDirection: Axis.vertical,
              //     //     shrinkWrap: true,
              //     //     itemBuilder: (context, index, animation) => widgetListItem(context, index, animation),
              //     //   ),
              //     //   ),
              //     // ),
              //
              //   ],
              child: Stack(
                children: _buildList(controller),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomBarWidget(animatedListKey),
            )
          ],
        ),
      ),
    );
    // return Scaffold(body: addMoneyToWallet());
  }

  /*Widget widgetListItem(BuildContext context, int index, animation) {
    return
        // ScaleTransition(scale: animation,
        SlideTransition(
      position: animation.drive(
        Tween(begin: const Offset(0.0, 3.0), end: const Offset(0.0, 0.0)),
      ),
      // Simply display the letter.
      //controller.removeAboveStackItem(index, animatedListKey);
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          print("tap on index $index");
          // controller.removeAboveStackItem(index, animatedListKey);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Align(
            // heightFactor: 0.2,
            //   heightFactor: 0.1,
            alignment: Alignment.topCenter,
            child: (index >= controller.itemsDataFilling.length)
                ? Container()
                : controller.itemsDataFilling[index],
          ),
        ),
        // child: Positioned(
        //   top: 20,
        //   child: (index >= controller.itemsDataFilling.length) ? Container() : controller.itemsDataFilling[index]),
        // child: ColumnSuper(
        //   innerDistance: -20,
        //   children: [
        // (index >= controller.itemsDataFilling.length) ? Container() : controller.itemsDataFilling[index]
        //   ],
        // ),
      ),
    );
  }*/
}
