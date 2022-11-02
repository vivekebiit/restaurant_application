import 'package:flutter/material.dart';
import 'package:restaurant_application/utils/strings.dart';
import 'package:restaurant_application/widget/menu_row_item.dart';

class MenuCartScreen extends StatefulWidget {
  MenuCartScreen({Key? key, required this.menu}) : super(key: key);

  var menu;

  @override
  State<MenuCartScreen> createState() => _MenuCartScreenState();
}

class _MenuCartScreenState extends State<MenuCartScreen> {
  List cartItem = [];

  double totalAmount = 0;

  @override
  void initState() {
    super.initState();
    cartItem = widget.menu;
    for (int index = 0; index < cartItem.length; index++) {
      var item = cartItem[index];
      totalAmount = totalAmount + item['qty'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.toolbarCartName)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: cartItem.length,
                itemBuilder: ((context, index) {
                  var item = cartItem[index];
                  return Card(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RowItem(
                            menuName: item['itemsName'],
                            price: item['price'],
                          ),
                          Visibility(
                            visible: cartItem[index]['qty'] == 0 ? false : true,
                            child: Row(
                              children: [
                                TextButton(
                                    onPressed: cartItem[index]['qty'] == 0
                                        ? null
                                        : () {
                                            int count =
                                                cartItem[index]['qty'] - 1;
                                            cartItem[index]['qty'] = count;
                                            if (count == 0) {}
                                            setState(() {});
                                          },
                                    child: const Text('-')),
                                Text(item['qty'].toString()),
                                TextButton(
                                    onPressed: () {
                                      int count = cartItem[index]['qty'] + 1;
                                      cartItem[index]['qty'] = count;
                                      setState(() {});
                                    },
                                    child: const Text('+'))
                              ],
                            ),
                          ),
                          Visibility(
                              visible:
                                  cartItem[index]['qty'] > 0 ? false : true,
                              child: TextButton(
                                  onPressed: () {
                                    int count = cartItem[index]['qty'] + 1;
                                    cartItem[index]['qty'] = count;
                                    setState(() {});
                                  },
                                  child: const Text('Add')))
                        ]),
                  );
                })),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: [
                const Text('Total'),
                Text(totalAmount.toString()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
