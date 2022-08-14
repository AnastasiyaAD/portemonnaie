import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:portemonnaie/domain/model/buy/typeBuy.dart';
import 'dart:math' as math;
class TypeBuyCard extends StatefulWidget {
  int index;
  TypeBuyCard({required this.index, Key? key}) : super(key: key);

  @override
  State createState() => _TypeBuyCardState();
}

class _TypeBuyCardState extends State<TypeBuyCard> {
  late int index;
  var typeBuyBox = Hive.box<TypeBuy>('typeBuy');

  @override
  void initState() {
    super.initState();
    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () {
          debugPrint('Card tapped.');
        },
        child: Container(
          height: 100,
          color: Colors.white,
          child: Row(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Expanded(
                    flex: 2,
                    child: Icon(Icons.image ,size:36, color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.6),),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: ListTile(
                          title: Text(typeBuyBox.getAt(index)!.name),
                          subtitle: const Text("\nВсего за месяц 9999.99 €\nВ неделю: 9999.99 €"),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon:  const Icon(Icons.settings),
                              onPressed: (){
                                debugPrint('settings');
                              },
                            ),
                            const SizedBox(width: 8,)
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
