import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:portemonnaie/domain/model/buy/buy.dart';
import 'package:portemonnaie/domain/model/buy/shop.dart';
import 'dart:math' as math;

class BuyCard extends StatefulWidget {
  int index;
  BuyCard({required this.index, Key? key}) : super(key: key);
  @override
  State createState() => _BuyCardState();
}

class _BuyCardState extends State<BuyCard> {
  late int index;
  var buyBox = Hive.box<Buy>('buy');
  var shopBox = Hive.box<Shop>('shop');
  @override
  void initState() {
    super.initState();
    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    String shop = shopBox.getAt(buyBox.getAt(index)!.storeID)!.name;
    double width = MediaQuery.of(context).size.width;
    return Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(0.6),
        ),
        height: 120,
        child: Column(children: [
          Container(
              width: width - 60,
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(shop, style: const TextStyle(fontSize: 22.0)),
                        Text("${buyBox.getAt(index)!.price} €",
                            style: const TextStyle(fontSize: 18.0)),
                      ]))),
        ]));
  }
}
