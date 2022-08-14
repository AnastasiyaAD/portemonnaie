import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:portemonnaie/domain/model/buy/buy.dart';
import 'package:portemonnaie/domain/model/buy/shop.dart';

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
    return Center(
        child: Card(
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () {
          debugPrint('Card tapped.');
        },
        child: SizedBox(
          height: 100,
          child: Center(
            child: ListTile(
                title: Text(buyBox.getAt(index)!.name, style: const TextStyle(fontSize: 18.0)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Магазин: $shop",
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                    Text(
                      "Цена: ${buyBox.getAt(index)!.price} €",
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                    Text(
                      "Скидка: ${buyBox.getAt(index)!.discount} €",
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ],
                )),
          ),
        ),
      ),
    ));
  }
}
