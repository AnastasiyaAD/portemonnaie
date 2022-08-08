import 'package:meta/meta.dart';

class Buy {
    final String name;
    final int storeID;
    final int typeID;
    final int currencyID;
    final double discount;
    final double price; 
    final DateTime date;

  Buy({
    required this.name,
    required this.storeID,
    required this.typeID,
    required this.currencyID,
    required this.discount,
    required this.price,
    required this.date,
  });
}