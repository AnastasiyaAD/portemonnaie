import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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
  var typeBuyBox = Hive.box<TypeBuy>('typeBuy');

  @override
  void initState() {
    super.initState();
    index = widget.index;
    date = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListBuyPage(indexType: index, date: date)),
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
                                            style:
                                                const TextStyle(fontSize: 18.0))
                                      ]))),
                          subtitle: const Text(
                              "\nВсего за месяц 9999.99 €\nВ неделю: 9999.99 €"),
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
  }
}
