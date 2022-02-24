import 'package:flutter/material.dart';
import 'package:money_calc_app/component/appbar/app_bar_item.dart';
import 'package:money_calc_app/component/bottom_item/bottom_navigation_bar_items.dart';
import 'package:money_calc_app/component/home_screen/floating_action_button_items.dart';
import 'package:money_calc_app/component/home_screen/list_item.dart';
import 'package:money_calc_app/component/home_screen/no_list.dart';
import 'package:money_calc_app/constants/app_color.dart';
import 'package:money_calc_app/database/todo_bloc.dart';
import 'package:money_calc_app/model/todo.dart';
import 'package:money_calc_app/screen/home_screen/children/list_item_android.dart';
import 'package:money_calc_app/screen/home_screen/children/money_item.dart';
import 'package:provider/provider.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'children/menu_item.dart';
import 'home_screen_controller.dart';
import 'package:get/get.dart';

class HomeScreenAndroid extends StatelessWidget {
  const HomeScreenAndroid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController(), tag: '');
    final _bloc = Provider.of<TodoBloc>(context, listen: false);
    final deviceWidth = MediaQuery.of(context).size.width;
    return SideMenu(
      key: controller.sideMenuKey,
      type: SideMenuType.slide,
      maxMenuWidth: deviceWidth,
      closeIcon: Icon(
        Icons.close,
        size: deviceWidth / 10,
        color: Colors.white,
      ),
      menu: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Obx(
          () => MenuItem(
            onTapHome: controller.onTapHome,
            onTapNotification: controller.onTapNotification,
            onTapStar: controller.onTapStar,
            onTapSetting: controller.onTapSetting,
            onTapChangePhoto: () {},
            onTapChangeName: controller.onTapChangeName,
            userName: controller.userName.value,
            //AdItem: AdWidget(ad: controller.banner.value),
          ),
        ),
      ),
      onChange: (_isOpened) => controller.onChanged(_isOpened),
      child: Obx(
        () => Scaffold(
          backgroundColor: AppColor.grey3,
          appBar: (controller.todoList.isNotEmpty)
              ? PreferredSize(
                  preferredSize: Size.fromHeight(deviceWidth / 13),
                  child: AppBarItem(
                    color: AppColor.red2,
                    icon: IconButton(
                      onPressed: controller.toggleMenu,
                      icon: Icon(
                        Icons.menu,
                        size: deviceWidth / 16,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                )
              // ? PreferredSize(
              //     preferredSize: const Size.fromHeight(0.0),
              //     child: AppBarItem(color: AppColor.red2))
              : PreferredSize(
                  preferredSize: const Size.fromHeight(40.0),
                  child: AppBarItem(color: AppColor.grey3)),
          body: (controller.todoList.isNotEmpty)
              ? Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    SafeArea(
                      child: Column(
                        children: [
                          Obx(
                            () => MoneyItem(
                              sumMoney: controller.expression.value,
                              restMoney: controller.expression2.value,
                            ),
                          ),
                          Expanded(
                            child: Obx(
                              () => ListView.builder(
                                itemCount: controller.todoList.length,
                                //itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  //Todo todo = snapshot.data![index];
                                  // print(snapshot.data![index]);
                                  return Column(
                                    children: [
                                      // index % 10 == 0
                                      //     ? Container(
                                      //         color: Colors.red,
                                      //         height: 64.0,
                                      //         width: double.infinity,
                                      //         child: AdmobBanner(
                                      //           adUnitId: AdMobService()
                                      //               .getBannerAdUnitId(),
                                      //           adSize: AdmobBannerSize(
                                      //             width: MediaQuery.of(context).size.width.toInt(),
                                      //             height: AdMobService().getHeight(context).toInt(),
                                      //             name: 'SMART_BANNER',
                                      //           ),
                                      //         ),
                                      //       )
                                      //     : const SizedBox(),
                                      Dismissible(
                                        key: ObjectKey(
                                            controller.todoList[index]),
                                        onDismissed: (direction) {
                                          controller.removeMoney(index);
                                        },
                                        child: ListItemAndroid(
                                          title:
                                              '￥' + controller.todoList[index],
                                          day: '',
                                          //day: 'ss',
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const SafeArea(child: NoList()),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButtonItems(
            onTap: () => controller.onTapAddMoney(context, _bloc),
          ),
          bottomNavigationBar: const BottomNavigationBarItems(),
        ),
      ),
    );
  }
}
