import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoneyCard extends StatefulWidget {
  const MoneyCard({Key? key}) : super(key: key);
  @override
  State createState() => _MoneyCardState();
}

class _MoneyCardState extends State<MoneyCard> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int money = 19536;
  double spent = 0;
  Future<void> _incrementtotalSum() async {
    final SharedPreferences prefs = await _prefs;
    final double totalSum = (prefs.getDouble('totalSum') ?? 0.0);
    setState(() {
      spent = totalSum;
    });
  }
  @override
  void initState() {
    super.initState();
    _incrementtotalSum();
  }
  @override
  Widget build(BuildContext context) {
    double total = 19536 - spent;
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
                leading: const Icon(Icons.assured_workload_rounded ,size:36, color: Colors.green),
                title: Text("$total €", style: const TextStyle( fontSize: 28.0)),
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
                )
              ),
            ),
          ),
        ),
      )
    );
  }
}
