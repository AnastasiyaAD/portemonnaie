import 'package:hive/hive.dart';
 
part 'buy.g.dart';

@HiveType(typeId: 3)
class Buy {
    @HiveField(0)
    late final String name;
    @HiveField(1)
    late final int storeID;
    @HiveField(2)
    late final int typeID;
    @HiveField(3)
    late final int currencyID;
    @HiveField(4)
    late final double discount;
    @HiveField(5)
    late final double price;
    @HiveField(6) 
    late final DateTime date;

  Buy({
    required this.name,
    required this.storeID,
    required this.typeID,
    required this.currencyID,
    required this.discount,
    required this.price,
    required this.date,
  });
  Map<String, dynamic> toBuyString() {
    return {
      'name': name,
      'storeID': storeID,
      'typeID': typeID,
      'currencyID': currencyID,
      'discount': discount,
      'price': price,
      'date': date,
    };
  }
}