import 'package:date_format/date_format.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:portemonnaie/domain/model/buy/shop.dart';
import 'package:portemonnaie/domain/model/buy/typeBuy.dart';
import 'package:portemonnaie/domain/model/currency.dart';
import 'package:portemonnaie/presentation/widget/addNamePopup.dart';

class BuyForm extends StatefulWidget {
  const BuyForm({super.key});

  @override
  BuyFormState createState() {
    return BuyFormState();
  }
}

class BuyFormState extends State<BuyForm> {
  TextEditingController dateinput = TextEditingController(); 
  final _formKey = GlobalKey<FormState>();
  final _formKeyShop = GlobalKey<FormState>();
  final _formKeyTypeBuy = GlobalKey<FormState>();
  final _formKeyCurrency = GlobalKey<FormState>();
  var shopBox = Hive.box<Shop>('shop');
  var typeBuyBox = Hive.box<TypeBuy>('typeBuy');
  var currencyBox = Hive.box<Currency>('currency');
  static DateTime currentTime = DateTime.now();
  static String date = formatDate(currentTime, [dd,'/',mm,'/',yy]);
  @override
  void initState() {
    dateinput.text = date;
    super.initState();
  }
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    List<String> genderItems = [
      'Male',
      'Female',
    ];
    return Scaffold(
      body: 
      Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                //Название
                TextFormField(
                  decoration: InputDecoration(
                    icon: const Icon(Icons.bakery_dining_rounded),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    hintText: 'Название',
                    hintStyle: const TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                //Магазин
                DropdownButtonFormField2(
                  key: _formKeyShop,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.shopping_bag_rounded,size: 23),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  isExpanded: true,
                  hint: const Text(
                    'Выбери магазин',
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 60,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: [
                    DropdownMenuItem<String>(
                      enabled: false,
                      value: "",
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Добавить магазин "),
                            IconButton(
                              icon: const Icon(
                                Icons.add_circle_outline_rounded,
                                color: Colors.blue,
                              ),
                              onPressed: () async {
                                String value = await Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        opaque: false,
                                        pageBuilder:
                                            (BuildContext context, _, __) =>
                                                const AddNamePopup()));
                                if (value.isNotEmpty) {
                                  shopBox.put(
                                      shopBox.values.length, Shop(name: value));
                                    setState(() {});
                                  // debugPrint(
                                  //     'AddNamePopup:!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ${shopBox.values.}');
                                }
                              },
                            )
                          ]),
                    ),
                    ...shopBox.values.map((item) =>
                    DropdownMenuItem<String>(
                      value: item.name,
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                    .toList(),
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'А как же магазин?!';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    //Do something when changing the item if you want.
                  },
                  onSaved: (value) {
                    selectedValue = value.toString();
                  },
                ),
                const SizedBox(height: 15),
                //Тип товара
                DropdownButtonFormField2(
                  key: _formKeyTypeBuy,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.checkroom_rounded,size: 23,),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  isExpanded: true,
                  hint: const Text(
                    'Выбери тип товара',
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 60,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: [
                    DropdownMenuItem<String>(
                      enabled: false,
                      value: "",
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Добавить тип товара "),
                            IconButton(
                              icon: const Icon(
                                Icons.add_circle_outline_rounded,
                                color: Colors.blue,
                              ),
                              onPressed: () async {
                                String value = await Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        opaque: false,
                                        pageBuilder:
                                            (BuildContext context, _, __) =>
                                                const AddNamePopup()));
                                if (value.isNotEmpty) {
                                  typeBuyBox.put(
                                      typeBuyBox.values.length, TypeBuy(name: value));
                                    setState(() {});
                                }
                              },
                            )
                          ]),
                    ),
                    ...typeBuyBox.values.map((item) =>
                    DropdownMenuItem<String>(
                      value: item.name,
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                    .toList(),
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'А как же тип товара?!';
                    }
                    return null;
                  },
                  onChanged: (value) {
                  },
                  onSaved: (value) {
                    selectedValue = value.toString();
                  },
                ),
                const SizedBox(height: 15),
                //Валюта
                DropdownButtonFormField2(
                  key: _formKeyCurrency,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.currency_exchange_rounded, size: 23,),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  isExpanded: true,
                  hint: const Text(
                    'Выбери валюту',
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 60,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: [
                    DropdownMenuItem<String>(
                      enabled: false,
                      value: "",
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Добавить валюту "),
                            IconButton(
                              icon: const Icon(
                                Icons.add_circle_outline_rounded,
                                color: Colors.blue,
                              ),
                              onPressed: () async {
                                String value = await Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        opaque: false,
                                        pageBuilder:
                                            (BuildContext context, _, __) =>
                                                const AddNamePopup()));
                                if (value.isNotEmpty) {
                                  currencyBox.put(
                                      typeBuyBox.values.length, Currency(name: value));
                                    setState(() {});
                                }
                              },
                            )
                          ]),
                    ),
                    ...currencyBox.values.map((item) =>
                    DropdownMenuItem<String>(
                      value: item.name,
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                    .toList(),
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'А как же валюта?!';
                    }
                    return null;
                  },
                  onChanged: (value) {
                  },
                  onSaved: (value) {
                    selectedValue = value.toString();
                  },
                ),
                const SizedBox(height: 15),
                //Скидка
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.percent_rounded,size: 23),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    hintText: 'Скидка',
                    hintStyle: const TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                //Цена
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.euro_symbol_rounded,size: 23 ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    hintText: 'Цена',
                    hintStyle: const TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                //Дата
                TextFormField(
                  controller: dateinput,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.calendar_today,size: 23),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    hintText: 'Дата',
                    hintStyle: const TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), 
                      lastDate: DateTime(2101)
                  );
                  
                  if(pickedDate != null ){
                      String formattedDate = formatDate(pickedDate, [dd,'/',mm,'/',yy]);
                      setState(() {
                         dateinput.text = formattedDate;
                      });
                  }
                },
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      
                    }
                  },
                  child: const Text('Сохранить'),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
