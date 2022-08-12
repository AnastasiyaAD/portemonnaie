import 'package:hive/hive.dart';
 
part 'currency.g.dart';

@HiveType(typeId: 2)
class Currency {
  @HiveField(0)
  final String name;

  Currency({
    required this.name,
  });
}