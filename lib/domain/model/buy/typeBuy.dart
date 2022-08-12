import 'package:hive/hive.dart';
 
part 'typeBuy.g.dart';

@HiveType(typeId: 1)
class TypeBuy {
  @HiveField(0)
  final String name;

  TypeBuy({
    required this.name,
  });
}