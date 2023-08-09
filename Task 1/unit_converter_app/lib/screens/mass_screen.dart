import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// enum FromOptions { sq_Km, Sq_Hm }

class MassScreen extends StatefulWidget {
  const MassScreen({super.key});

  @override
  State<MassScreen> createState() => _MassScreenState();
}

class _MassScreenState extends State<MassScreen> {
  int? _value = 0;
  // String _getText = "Sq Kilometer";
  final TextEditingController _textEditingController0 = TextEditingController();
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
  int? _checkFormField;
  List<String> optionsTexts = [
    "Kilogram",
    "Pound",
    "Gram",
    "Milligram",
    "Microgram",
  ];

  double? _result;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _textEditingController0.dispose();
    _textEditingController1.dispose();
    _textEditingController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Mass Converter"),
        ),
        body: Wrap(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: TextFormField(
                    controller: _textEditingController0,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter Units to Convert"),
                    style: const TextStyle(color: Colors.purple),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        controller: _textEditingController1,
                        style: const TextStyle(color: Colors.purple),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "From",
                          suffixIcon: IconButton(
                            onPressed: () {
                              _checkFormField = 1;
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 300,
                                      width: MediaQuery.of(context).size.width,
                                      child: SingleChildScrollView(
                                        child: _areaOption(context),
                                      ),
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                //Switch button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      String temp = _textEditingController1.text;
                      _textEditingController1.text =
                          _textEditingController2.text;
                      _textEditingController2.text = temp;
                    },
                    child: const Icon(Icons.compare_arrows_sharp),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: TextFormField(
                    controller: _textEditingController2,
                    style: const TextStyle(color: Colors.purple),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "To",
                      suffixIcon: IconButton(
                        onPressed: () {
                          _checkFormField = 2;
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                  child: SingleChildScrollView(
                                    child: _areaOption(context),
                                  ),
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                        ),
                      ),
                    ),
                  ),
                ),
                //Result text
                StatefulBuilder(builder: (context, setState) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 35, left: 0),
                    child: SizedBox(
                      child: Text(
                        (_result == null)
                            ? "The result is: "
                            : "The result is: $_result",
                        style: const TextStyle(
                            color: Colors.purple,
                            letterSpacing: 2,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                }),

                //COnvert button
                Padding(
                  padding: const EdgeInsets.only(
                    top: 80,
                    left: 30,
                    right: 30,
                  ),
                  child: SizedBox(
                    height: 40,
                    width: 145,
                    child: ElevatedButton(
                        onPressed: () {
                          _calculate();
                          log("$_result");
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder()),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.compare_arrows_sharp,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("CONVERT"),
                          ],
                        )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _calculate() {
    setState(() {
      if (_textEditingController1.text == optionsTexts[0] &&
          _textEditingController2.text == optionsTexts[0]) {
        _result = double.parse(_textEditingController0.text);
      } else if (_textEditingController1.text == optionsTexts[0] &&
          _textEditingController2.text == optionsTexts[1]) {
        _result = double.parse(_textEditingController0.text) * 2.2046;
      } else if (_textEditingController1.text == optionsTexts[0] &&
          _textEditingController2.text == optionsTexts[2]) {
        _result = double.parse(_textEditingController0.text) * 1000;
      } else if (_textEditingController1.text == optionsTexts[0] &&
          _textEditingController2.text == optionsTexts[3]) {
        _result = double.parse(_textEditingController0.text) * 1000000;
      } else if (_textEditingController1.text == optionsTexts[0] &&
          _textEditingController2.text == optionsTexts[4]) {
        _result = double.parse(_textEditingController0.text) * 100000000;
      } //2nd
      else if (_textEditingController1.text == optionsTexts[1] &&
          _textEditingController2.text == optionsTexts[0]) {
        _result = double.parse(_textEditingController0.text) * 0.4536;
      } else if (_textEditingController1.text == optionsTexts[1] &&
          _textEditingController2.text == optionsTexts[1]) {
        _result = double.parse(_textEditingController0.text) * 1;
      } else if (_textEditingController1.text == optionsTexts[1] &&
          _textEditingController2.text == optionsTexts[2]) {
        _result = double.parse(_textEditingController0.text) * 453.5924;
      } else if (_textEditingController1.text == optionsTexts[1] &&
          _textEditingController2.text == optionsTexts[3]) {
        _result = double.parse(_textEditingController0.text) * 453592.37;
      } else if (_textEditingController1.text == optionsTexts[1] &&
          _textEditingController2.text == optionsTexts[4]) {
        _result = double.parse(_textEditingController0.text) * 453592370;
      } //3rd
      else if (_textEditingController1.text == optionsTexts[2] &&
          _textEditingController2.text == optionsTexts[0]) {
        _result = double.parse(_textEditingController0.text) * 0.001;
      } else if (_textEditingController1.text == optionsTexts[2] &&
          _textEditingController2.text == optionsTexts[1]) {
        _result = double.parse(_textEditingController0.text) * 0.0022;
      } else if (_textEditingController1.text == optionsTexts[2] &&
          _textEditingController2.text == optionsTexts[2]) {
        _result = double.parse(_textEditingController0.text) * 1;
      } else if (_textEditingController1.text == optionsTexts[2] &&
          _textEditingController2.text == optionsTexts[3]) {
        _result = double.parse(_textEditingController0.text) * 1000;
      } else if (_textEditingController1.text == optionsTexts[2] &&
          _textEditingController2.text == optionsTexts[4]) {
        _result = double.parse(_textEditingController0.text) * 1000000;
      } //4th
      else if (_textEditingController1.text == optionsTexts[3] &&
          _textEditingController2.text == optionsTexts[0]) {
        _result = double.parse(_textEditingController0.text) * 0.000001;
      } else if (_textEditingController1.text == optionsTexts[3] &&
          _textEditingController2.text == optionsTexts[1]) {
        _result = double.parse(_textEditingController0.text) * 0.000002204;
      } else if (_textEditingController1.text == optionsTexts[3] &&
          _textEditingController2.text == optionsTexts[2]) {
        _result = double.parse(_textEditingController0.text) * 0.001;
      } else if (_textEditingController1.text == optionsTexts[3] &&
          _textEditingController2.text == optionsTexts[3]) {
        _result = double.parse(_textEditingController0.text) * 1;
      } else if (_textEditingController1.text == optionsTexts[3] &&
          _textEditingController2.text == optionsTexts[4]) {
        _result = double.parse(_textEditingController0.text) * 1000;
      } //5th
      else if (_textEditingController1.text == optionsTexts[4] &&
          _textEditingController2.text == optionsTexts[0]) {
        _result = double.parse(_textEditingController0.text) * 0.000000001;
      } else if (_textEditingController1.text == optionsTexts[4] &&
          _textEditingController2.text == optionsTexts[1]) {
        _result = double.parse(_textEditingController0.text) * 0.0000000022;
      } else if (_textEditingController1.text == optionsTexts[4] &&
          _textEditingController2.text == optionsTexts[2]) {
        _result = double.parse(_textEditingController0.text) * 0.000001;
      } else if (_textEditingController1.text == optionsTexts[4] &&
          _textEditingController2.text == optionsTexts[3]) {
        _result = double.parse(_textEditingController0.text) * 0.001;
      } else if (_textEditingController1.text == optionsTexts[4] &&
          _textEditingController2.text == optionsTexts[4]) {
        _result = double.parse(_textEditingController0.text) * 1;
      }
    });
  }

  Widget _areaOption(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        children: [
          RadioListTile(
              value: 1,
              groupValue: _value,
              title: Text(optionsTexts[0]),
              activeColor: Colors.blue,
              onChanged: (int? val) {
                setState(() {
                  _value = val;

                  (_checkFormField == 1)
                      ? _textEditingController1.text = optionsTexts[0]
                      : _textEditingController2.text = optionsTexts[0];
                });
              }),
          RadioListTile(
              value: 2,
              groupValue: _value,
              title: Text(optionsTexts[1]),
              activeColor: Colors.blue,
              onChanged: (int? val) {
                setState(() {
                  _value = val;

                  (_checkFormField == 1)
                      ? _textEditingController1.text = optionsTexts[1]
                      : _textEditingController2.text = optionsTexts[1];
                  // log("value: $_value");
                });
              }),
          RadioListTile(
              value: 3,
              groupValue: _value,
              title: Text(optionsTexts[2]),
              activeColor: Colors.blue,
              onChanged: (int? val) {
                setState(() {
                  _value = val;

                  (_checkFormField == 1)
                      ? _textEditingController1.text = optionsTexts[2]
                      : _textEditingController2.text = optionsTexts[2];
                });
              }),
          RadioListTile(
              value: 4,
              groupValue: _value,
              title: Text(optionsTexts[3]),
              activeColor: Colors.blue,
              onChanged: (int? val) {
                setState(() {
                  _value = val;

                  (_checkFormField == 1)
                      ? _textEditingController1.text = optionsTexts[3]
                      : _textEditingController2.text = optionsTexts[3];
                });
              }),
          RadioListTile(
              value: 5,
              groupValue: _value,
              title: Text(optionsTexts[4]),
              activeColor: Colors.blue,
              onChanged: (int? val) {
                setState(() {
                  _value = val;

                  (_checkFormField == 1)
                      ? _textEditingController1.text = optionsTexts[4]
                      : _textEditingController2.text = optionsTexts[4];
                });
              }),
        ],
      );
    });
  }
}
