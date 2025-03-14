import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:hive/hive.dart';
import 'package:portemonnaie/domain/model/buy/typeBuy.dart';
import 'package:portemonnaie/presentation/page/buyPage.dart';
import 'package:portemonnaie/presentation/widget/bottomAppBarWithButton.dart';
import 'package:portemonnaie/presentation/widget/moneyCard.dart';
import 'package:portemonnaie/presentation/widget/settingCard.dart';
import 'package:portemonnaie/presentation/widget/typeBuyCard.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;
  late DateTime selectedDate;
  static DateTime currentTime = DateTime.now();
  static String date = formatDate(currentTime, [dd, '/', mm, '/', yy]);
  var typeBuyBox = Hive.box<TypeBuy>('typeBuy');
  bool showButton = true;
  int tab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    selectedDate = currentTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(161, 134, 100, 235),
        automaticallyImplyLeading: false,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Cегодня хороший день',
              style: TextStyle(fontSize: 17.0, wordSpacing: 4)),
          Text(date)
        ]),
        bottom: TabBar(
          onTap: (value) {
            setState(() {
              showButton = value != 2;
              tab = value;
            });
          },
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.auto_graph_rounded),
            ),
            Tab(
              icon: Icon(Icons.auto_stories_rounded),
            ),
            Tab(
              icon: Icon(Icons.brightness_5_sharp),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(
            child: ListView(
              children: <Widget>[
                // const MoneyCard(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formatDate(selectedDate, [mm, '.', yyyy]),
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      onPressed: () {
                        showMonthPicker(
                          context: context,
                          firstDate: DateTime(2022, 8),
                          lastDate: DateTime(DateTime.now().year + 1, 9),
                          initialDate: selectedDate,
                          locale: const Locale("ru"),
                        ).then((date) {
                          if (date != null) {
                            setState(() {
                              selectedDate = date;
                            });
                          }
                        });
                      },
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ],
                ),
                ...typeBuyBox.keys.map((key) => TypeBuyCard(
                      index: key,
                      date: selectedDate,
                    )),
              ],
            ),
          ),
          const Center(
            child: Text("Список покупок"),
          ),
          Center(
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 15),
                Center(
                    child: Text(
                  "Настройки",
                  style: Theme.of(context).textTheme.titleLarge,
                )),
                const SizedBox(height: 15),
                const Align(
                    alignment: Alignment.bottomCenter, child: SettingCard()),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: showButton
          ? FloatingActionButton(
              onPressed: () {
                switch (tab) {
                  case 0:
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BuyPage()))
                        .then((value) {
                      setState(() {});
                    });
                    break;
                  case 1:
                    break;
                }
              },
              tooltip: 'Добавить',
              child: const Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      bottomNavigationBar: const BottomAppBar(
        color: Color.fromARGB(161, 134, 100, 235),
      ),
    );
  }
}
