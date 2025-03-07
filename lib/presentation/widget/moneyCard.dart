import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:portemonnaie/presentation/widget/addIntPopup.dart';

class MoneyCard extends StatefulWidget {
  const MoneyCard({Key? key}) : super(key: key);
  @override
  State createState() => _MoneyCardState();
}

class _MoneyCardState extends State<MoneyCard> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  double money = 0;
  double spent = 0;
  late Future<double> _allMoney;
  Future<void> _incrementtotalSum() async {
    final SharedPreferences prefs = await _prefs;
    final double totalSum = (prefs.getDouble('totalSum') ?? 0.0);
    final double allMoney = (prefs.getDouble('allMoney') ?? 19536.0);
    setState(() {
      spent = double.parse((totalSum).toStringAsFixed(2));
      money = double.parse((allMoney).toStringAsFixed(2));
    });
  }

  Future<void> addMoney(int value) async {
    final SharedPreferences prefs = await _prefs;
    final double allMoney = (prefs.getDouble('allMoney') ?? 0.0) + value;
    setState(() {
      _allMoney = prefs.setDouble('allMoney', allMoney).then((bool success) {
        debugPrint("totalSum !!!!!!!!! $allMoney");
        return allMoney;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _incrementtotalSum();
  }

  @override
  Widget build(BuildContext context) {
    double total = double.parse((money - spent).toStringAsFixed(2));
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
                leading: const Icon(Icons.assured_workload_rounded,
                    size: 36, color: Colors.green),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text("$total €", style: const TextStyle(fontSize: 28.0)),
                  IconButton(
                    iconSize:28,
                    icon: const Icon(Icons.add_circle_rounded, color: Colors.blue),
                    onPressed: () async {
                      String value = await Navigator.push(
                          context,
                          PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, _, __) =>
                                  const AddIntPopup()));
                      if (value.isNotEmpty) {
                        int addValue = int.parse(value);
                        await addMoney(addValue);
                        await _incrementtotalSum();
                        total = double.parse((money - spent).toStringAsFixed(2));
                      }
                    },
                  )
                ]),
                subtitle: Row(
                  children: [
                    Text(
                      "$money €",
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                    Text(
                      "    - $spent €",
                      style: TextStyle(color: Colors.red.withOpacity(0.6)),
                    ),
                  ],
                )),
          ),
        ),
      ),
    ));
  }
}
