import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:money_calc_app/component/appbar/app_bar_item.dart';
import 'package:money_calc_app/component/bottom_item/bottom_navigation_bar_items.dart';
import 'package:money_calc_app/component/home_screen/floating_action_button_items.dart';
import 'package:money_calc_app/component/home_screen/list_item.dart';
import 'package:money_calc_app/component/home_screen/money_label.dart';
import 'package:money_calc_app/component/home_screen/no_list.dart';
import 'package:money_calc_app/database/todo_bloc.dart';
import 'package:money_calc_app/model/color.dart';
import 'package:money_calc_app/model/todo.dart';
import 'package:provider/provider.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'children/menu_item.dart';
import 'home_screen_controller.dart';
import 'package:get/get.dart';

class HomeLessScreen extends StatelessWidget {
  HomeLessScreen({
    Key? key,
    required this.flutterLocalNotificationsPlugin,
  }) : super(key: key);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController(), tag: '');
    final _bloc = Provider.of<TodoBloc>(context, listen: false);
    return SideMenu(
      key: controller.sideMenuKey,
      type: SideMenuType.slide,
      // background: Colors.orange.shade300,
      menu: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: MenuItem(
          onTapNotification: controller.onTapNotification,
          onTapStar: controller.onTapStar,
          onTapSetting: controller.onTapSetting,
        ),
      ),
      onChange: (_isOpened) => controller.onChanged(_isOpened),
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: (controller.todoList.isNotEmpty)
            ? PreferredSize(
                preferredSize: const Size.fromHeight(35.0),
                child: AppBarItem(
                  color: AppColor.red2,
                  icon: IconButton(
                    //onPressed: onTapSetting,
                    onPressed: controller.toggleMenu,
                    icon: Icon(
                      Icons.menu,
                      size: 30,
                      color: AppColor.white,
                    ),
                  ),
                ),
              )
            : PreferredSize(
                preferredSize: const Size.fromHeight(0.0),
                child: AppBarItem(color: AppColor.grey3)),
        body: (controller.todoList.isNotEmpty)
            ? Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  SafeArea(
                    child: Column(
                      children: [
                        //TODO 次のアプデにする。
                        // SizedBox(
                        //   height: 50,
                        //   child: AdWidget(ad: banner),
                        // ),
                        Container(
                          color: AppColor.red2,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, right: 10, left: 10, top: 5),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: AppColor.white,
                                  width: 5,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListTile(
                                title: Center(
                                  child: Column(
                                    children: [
                                      Obx(
                                        () => Padding(
                                          padding: const EdgeInsets.only(top: 15, bottom: 10),
                                          child: MoneyLabel(
                                            title: '合計',
                                            exp: controller.expression.value +
                                                '円',
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 15),
                                          child: MoneyLabel(
                                            title: '残り',
                                            exp: controller.expression2.value + '円',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Visibility(
                        //     visible: !isFirst, child: ResetButton(onTap: reset)),
                        const SizedBox(height: 10),
                        Expanded(
                          child: StreamBuilder<List<Todo>>(
                            stream: _bloc.todoStream,
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Todo>> snapshot) {
                              if (snapshot.hasData &&
                                  controller.todoList.isNotEmpty) {
                                return ListView.builder(
                                  itemCount: controller.todoList.length,
                                  itemBuilder: (context, index) {
                                    Todo todo = snapshot.data![index];
                                    controller.indexes.value = index;
                                    return Dismissible(
                                      key: Key(controller.todoList[index]),
                                      onDismissed: (direction) {
                                        controller.removeMoney(index);
                                      },
                                      child: ListItem(
                                        title: '￥' + controller.todoList[index],
                                        day: todo.dueDate.toString(),
                                      ),
                                    );
                                  },
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const SafeArea(child: NoList()),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButtonItems(
          onTap: () => controller.onTapAddMoney(context, _bloc),
        ),
        bottomNavigationBar: const BottomNavigationBarItems(),
      ),
    );
  }
}
