import 'package:hive/hive.dart';
 
part 'buy.g.dart';

@HiveType(typeId: 3)
class Buy {
    @HiveField(0)
    final String name;
    @HiveField(1)
    final int storeID;
    @HiveField(2)
    final int typeID;
    @HiveField(3)
    final int currencyID;
    @HiveField(4)
    final double discount;
    @HiveField(5)
    final double price;
    @HiveField(6) 
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