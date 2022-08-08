import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:portemonnaie/presentation/widget/bottomAppBarWithButton.dart';
import 'package:portemonnaie/presentation/widget/moneyCard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;
  static DateTime currentTime = DateTime.now();
  static String date = formatDate(currentTime, [dd,'/',mm,'/',yy]);

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
          title: Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween, 
            children: [
            const Text('Мы не Рокфеллеры пока!\nМы сэкономим и на соли ...',
                style: TextStyle(fontSize: 16.0, wordSpacing: 4)),
            Text(date)
          ]),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: false,
            tabs: <Widget>[
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
      body:
      TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(
            child: ListView(
              children: const <Widget>[MoneyCard()],
            ),
          ),
          Center(
            child: Text("It's rainy here"),
          ),
          Center(
            child: Text("It's sunny here"),
          ),
        ],
      ),
       
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Добавить траты',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBarWithButton(),
    );
  }
}
