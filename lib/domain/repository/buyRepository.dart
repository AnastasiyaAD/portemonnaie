import 'package:meta/meta.dart';
import 'package:portemonnaie/domain/model/buy/buy.dart';

abstract class BuyRepository {
  Future<Buy> getBuy({
    @required DateTime date,
  });
}