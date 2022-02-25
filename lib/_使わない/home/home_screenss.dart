import 'package:flutter/material.dart';
import 'package:money_calc_app/component/appbar/app_bar_item.dart';
import 'package:money_calc_app/component/bottom_item/bottom_navigation_bar_items.dart';
import 'package:money_calc_app/component/home_screen/floating_action_button_items.dart';
import 'package:money_calc_app/component/home_screen/list_item.dart';
import 'package:money_calc_app/component/home_screen/no_list.dart';
import 'package:money_calc_app/constants/app_color.dart';
import 'package:money_calc_app/database/todo_bloc.dart';
import 'package:money_calc_app/model/todo.dart';
import 'package:money_calc_app/screen/home_screen/children/item_idea/idea_1.dart';
import 'package:money_calc_app/screen/home_screen/children/money_item.dart';
import 'package:provider/provider.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import '../../screen/home_screen/children/menu_item.dart';
import '../../screen/home_screen/children/list_item/tab_bar.dart';
import '../../screen/home_screen/home_screen_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController(), tag: '');
    final _bloc = Provider.of<TodoBloc>(context, listen: false);
    final deviceWidth = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
    return Obx(
      () => Scaffold(
        key: _key,
        drawer: NavBar(
          onTapHome: controller.onTapHome,
          onTapNotification: controller.onTapNotification,
          onTapStar: controller.onTapStar,
          onTapSetting: controller.onTapSetting,
          onTapChangePhoto: () {},
          onTapChangeName: controller.onTapChangeName,
          userName: controller.userName.value,
          //AdItem: AdWidget(ad: controller.banner.value),
        ),
        drawerEdgeDragWidth: 0,
        backgroundColor: AppColor.grey3,
        appBar: (controller.todoList.isNotEmpty)
            ? PreferredSize(
                preferredSize: Size.fromHeight(deviceWidth / 13),
                child: AppBarItem(
                  color: AppColor.red2,
                  icon: IconButton(
                    //onPressed: controller.toggleMenu,
                    onPressed: () => _key.currentState?.openDrawer(),
                    icon: Icon(
                      Icons.menu,
                      size: deviceWidth / 16,
                      color: AppColor.white,
                    ),
                  ),
                ),
              )
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
                                    return Column(
                                      children: [
                                        Dismissible(
                                          key: ObjectKey(
                                              controller.todoList[index]),

                                          // key: Key(controller.todoList[index]),
                                          onDismissed: (direction) {
                                            controller.removeMoney(index);
                                          },
                                          child: Idea1(
                                            title: controller.todoList[index],
                                            day: todo.dueDate.toString(),
                                            isSex: controller.isSex.value,
                                          ),
                                        ),
                                      ],
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
