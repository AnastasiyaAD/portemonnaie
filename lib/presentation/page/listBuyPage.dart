import 'dart:ffi';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:portemonnaie/domain/model/buy/buy.dart';
import 'package:portemonnaie/domain/model/buy/typeBuy.dart';
import 'package:portemonnaie/presentation/widget/buyCard.dart';
import 'package:portemonnaie/presentation/widget/buyForm.dart';

class ListBuyPage extends StatefulWidget {
  int indexType;
  DateTime date;
  ListBuyPage({required this.date, required this.indexType, Key? key})
      : super(key: key);

  @override
  _ListBuyPageState createState() => _ListBuyPageState();
}

class _ListBuyPageState extends State<ListBuyPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  var buyBox = Hive.box<Buy>('buy');
  late DateTime date;
  late int indexType;

  List<int> days = [];

  void getAllUniqDay() {
    for (var item in buyBox.values) {
      if (item.date.month == date.month &&
          item.date.year == date.year &&
          item.typeID == indexType) {
        if (!days.contains(item.date.day)) {
          setState(() {
            days.add(item.date.day);
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    date = widget.date;
    indexType = widget.indexType;
    getAllUniqDay();
    _tabController = TabController(length: days.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            IconButton(
              tooltip: 'back',
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Ой, а куда все делось?)',
                    style: TextStyle(fontSize: 14.0, wordSpacing: 4))),
          ]),
          bottom: TabBar(
              controller: _tabController,
              isScrollable: false,
              tabs: List.generate(days.length, (index) {
                return Tab(
                  text: "${days[index]}.${formatDate(date, [mm, '.', yyyy])}",
                );
              })),
        ),
        body: TabBarView(
          controller: _tabController,
          children: List.generate(days.length, (index) {
            return Center(
                child: ListView(children: <Widget>[
              ...buyBox.keys.map((key) =>
                  buyBox.get(key)!.date.month == date.month &&
                          buyBox.get(key)!.date.year == date.year &&
                          buyBox.get(key)!.date.day == days[index] &&
                          buyBox.get(key)!.typeID == indexType
                      ? BuyCard(index: key)
                      : const SizedBox(width: 0))
            ]));
          }),
        ));
  }
}
