import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:portemonnaie/domain/model/buy/shop.dart';
import 'package:portemonnaie/presentation/widget/addNamePopup.dart';

class BuyForm extends StatefulWidget {
  const BuyForm({super.key});

  @override
  BuyFormState createState() {
    return BuyFormState();
  }
}

class BuyFormState extends State<BuyForm> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyShop = GlobalKey<FormState>();
  var shopBox = Hive.box<Shop>('shop');
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    List<String> genderItems = [
      'Male',
      'Female',
    ];
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Название
              TextFormField(
                decoration: InputDecoration(
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
              const SizedBox(height: 30),
              //Магазин
              DropdownButtonFormField2(
                key: _formKeyShop,
                decoration: InputDecoration(
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
              const SizedBox(height: 30),

              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                },
                child: const Text('Submit Button'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
