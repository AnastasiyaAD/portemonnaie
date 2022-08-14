import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:portemonnaie/presentation/page/buyPage.dart';
import 'package:portemonnaie/presentation/widget/bottomAppBarWithButton.dart';
import 'package:portemonnaie/presentation/widget/moneyCard.dart';
import 'package:portemonnaie/presentation/widget/settingCard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;
  static DateTime currentTime = DateTime.now();
  static String date = formatDate(currentTime, [dd, '/', mm, '/', yy]);
  bool showButton = true;
  int tab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Мы не Рокфеллеры пока!\nМы сэкономим и на соли ...',
              style: TextStyle(fontSize: 14.0, wordSpacing: 4)),
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
          isScrollable: false,
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
              children: const <Widget>[MoneyCard()],
            ),
          ),
          const Center(
            child: Text("Список покупок"),
          ),
          Center(
            child: ListView(
              children:  <Widget>[
                const SizedBox(height: 15),
                Center(child:Text("Настройки", style: Theme.of(context).textTheme.titleLarge,)),
                const SizedBox(height: 15),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child:SettingCard()
                ),
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
                      MaterialPageRoute(builder: (context) => const BuyPage()),
                    );
                    break;
                  case 1:
                    break;
                }
              },
              tooltip: 'Добавить',
              child: const Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBarWithButton(),
    );
  }
}
