import 'package:hive/hive.dart';
 
part 'shop.g.dart';
@HiveType(typeId: 0)
class Shop {
  @HiveField(0)
  final String name;

  Shop({
    required this.name,
  });
}
