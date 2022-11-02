import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_application/menu/menu_cart_screen.dart';
import 'package:restaurant_application/utils/strings.dart';

import '../widget/menu_row_item.dart';

class MenuListScreen extends StatefulWidget {
  const MenuListScreen({Key? key}) : super(key: key);

  @override
  State<MenuListScreen> createState() => _MenuListScreenState();
}

class _MenuListScreenState extends State<MenuListScreen> {
  List menuItem = [];
  List addCartItem = [];
  int totalItem = 0;

  var menuListItem =
      """[{ "itemsName": "The Mixed Green Salad 01", "price" : 10.23, "qty":0 },
      { "itemsName": "The Mixed Green Salad 01", "price" : 10.23, "qty":0 },
      { "itemsName": "The Mixed Green Salad 01", "price" : 10.23, "qty":0 }
      ]""";

  @override
  void initState() {
    super.initState();
    menuItem = jsonDecode(menuListItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: Column(
        children: [
          const Text(AppStrings.menuCategoryName),
          Expanded(
            child: ListView.builder(
                itemCount: menuItem.length,
                itemBuilder: ((context, index) {
                  var item = menuItem[index];
                  return GestureDetector(
                    onTap: () {
                      goToCart(context);
                    },
                    child: Card(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RowItem(
                              menuName: item['itemsName'],
                              price: item['price'],
                            ),
                            Visibility(
                              visible:
                                  menuItem[index]['qty'] == 0 ? false : true,
                              child: Row(
                                children: [
                                  TextButton(
                                      onPressed: menuItem[index]['qty'] == 0
                                          ? null
                                          : () {
                                              int count =
                                                  menuItem[index]['qty'] - 1;
                                              totalItem = totalItem - 1;
                                              menuItem[index]['qty'] = count;
                                              if (count == 0) {}
                                              setState(() {});
                                            },
                                      child: const Text('-')),
                                  Text(item['qty'].toString()),
                                  TextButton(
                                      onPressed: () {
                                        int count = menuItem[index]['qty'] + 1;
                                        menuItem[index]['qty'] = count;
                                        totalItem = totalItem + count;
                                        setState(() {});
                                      },
                                      child: const Text('+'))
                                ],
                              ),
                            ),
                            Visibility(
                                visible:
                                    menuItem[index]['qty'] > 0 ? false : true,
                                child: TextButton(
                                    onPressed: () {
                                      int count = menuItem[index]['qty'] + 1;
                                      menuItem[index]['qty'] = count;
                                      setState(() {});
                                    },
                                    child: const Text('Add')))
                          ]),
                    ),
                  );
                })),
          ),
          Visibility(
            visible: totalItem > 0,
            child: Row(
              children: [
                Text('${totalItem.toString()} Items'),
                TextButton(
                    onPressed: () {
                      goToCart(context);
                    },
                    child: const Text('Place Order')),
              ],
            ),
          )
        ],
      ),
    );
  }

  void goToCart(BuildContext context) {
    for (int index = 0; index < menuItem.length; index++) {
      var item = menuItem[index];
      if (item['qty'] > 0) {
        addCartItem.add(item);
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MenuCartScreen(
          menu: addCartItem,
        ),
      ),
    );
  }
}
