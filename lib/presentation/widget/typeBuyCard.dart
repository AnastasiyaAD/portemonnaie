import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:portemonnaie/domain/model/buy/buy.dart';
import 'package:portemonnaie/domain/model/buy/typeBuy.dart';
import 'dart:math' as math;

import 'package:portemonnaie/presentation/page/listBuyPage.dart';

class TypeBuyCard extends StatefulWidget {
  int index;
  DateTime date;
  TypeBuyCard({required this.index, required this.date, Key? key})
      : super(key: key);

  @override
  State createState() => _TypeBuyCardState();
}

class _TypeBuyCardState extends State<TypeBuyCard> {
  late int index;
  late DateTime date;
  late double totalMonth;
  var buyBox = Hive.box<Buy>('buy');
  var typeBuyBox = Hive.box<TypeBuy>('typeBuy');

  void getTotalMonth() {
    setState(() {
      double sum = 0.0;
      for (var key in buyBox.keys) {
        if (buyBox.get(key)?.date.month == date.month &&
            buyBox.get(key)?.date.year == date.year &&
            buyBox.get(key)?.typeID == index) {
          sum += buyBox.get(key)!.price - buyBox.get(key)!.discount;
        }
      }
      totalMonth = sum;
    });
  }

  @override
  void initState() {
    super.initState();
    totalMonth = 0.0;
    index = widget.index;
    date = widget.date;
    getTotalMonth();
  }

  @override
  Widget build(BuildContext context) {
    if (totalMonth > 0) {
      return Center(
          child: Card(
        child: InkWell(
          splashColor: Colors.blue,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ListBuyPage(indexType: index, date: date)),
            );
          },
          child: Container(
            height: 150,
            color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(0.6),
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        Expanded(
                          flex: 5,
                          child: ListTile(
                            title: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(typeBuyBox.getAt(index)!.name,
                                              style: const TextStyle(
                                                  fontSize: 18.0))
                                        ]))),
                            subtitle: Text(
                                "\nВсего за месяц ${double.parse((totalMonth).toStringAsFixed(2))} €\nВ неделю: ${double.parse((totalMonth / 4).toStringAsFixed(2))}"),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.settings),
                                onPressed: () {
                                  debugPrint('settings');
                                },
                              ),
                              const SizedBox(
                                width: 8,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
    } else {
      return Container();
    }
  }
}
