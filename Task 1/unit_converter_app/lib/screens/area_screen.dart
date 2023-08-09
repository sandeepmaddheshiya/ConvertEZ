import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// enum FromOptions { sq_Km, Sq_Hm }

class AreaScreen extends StatefulWidget {
  const AreaScreen({super.key});

  @override
  State<AreaScreen> createState() => _AreaScreenState();
}

class _AreaScreenState extends State<AreaScreen> {
  int? _value = 0;
  // String _getText = "Sq Kilometer";
  final TextEditingController _textEditingController0 = TextEditingController();
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();
  int? _checkFormField;
  List<String> optionsTexts = [
    "Sq Kilometer",
    "Sq Hectometer",
    "Sq Decameter",
    "Sq Meter",
    "Sq Decimeter",
    "Sq Centimeter",
    "Hectare",
    "Sq Mile",
    "Sq Yard",
    "Sq Foot",
    "Sq Inch",
    "Sq Acre"
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
          title: const Text("Area Converter"),
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
                                      height: 400,
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
                                  height: 400,
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
        _result = double.parse(_textEditingController0.text) * 100;
      } else if (_textEditingController1.text == optionsTexts[0] &&
          _textEditingController2.text == optionsTexts[2]) {
        _result = double.parse(_textEditingController0.text) * 1000;
      } else if (_textEditingController1.text == optionsTexts[0] &&
          _textEditingController2.text == optionsTexts[3]) {
        _result = double.parse(_textEditingController0.text) * 1000000;
      } else if (_textEditingController1.text == optionsTexts[0] &&
          _textEditingController2.text == optionsTexts[4]) {
        _result = double.parse(_textEditingController0.text) * 100000000;
      } else if (_textEditingController1.text == optionsTexts[0] &&
          _textEditingController2.text == optionsTexts[5]) {
        _result = double.parse(_textEditingController0.text) * 10000000000;
      } else if (_textEditingController1.text == optionsTexts[0] &&
          _textEditingController2.text == optionsTexts[6]) {
        _result = double.parse(_textEditingController0.text) * 100;
      } else if (_textEditingController1.text == optionsTexts[0] &&
          _textEditingController2.text == optionsTexts[7]) {
        _result = double.parse(_textEditingController0.text) * 0.3861;
      } else if (_textEditingController1.text == optionsTexts[0] &&
          _textEditingController2.text == optionsTexts[8]) {
        _result = double.parse(_textEditingController0.text) * 1195990.0463;
      } else if (_textEditingController1.text == optionsTexts[0] &&
          _textEditingController2.text == optionsTexts[9]) {
        _result = double.parse(_textEditingController0.text) * 10763910.4167;
      } else if (_textEditingController1.text == optionsTexts[0] &&
          _textEditingController2.text == optionsTexts[10]) {
        _result = double.parse(_textEditingController0.text) * 1550003100.0062;
      } else if (_textEditingController1.text == optionsTexts[0] &&
          _textEditingController2.text == optionsTexts[11]) {
        _result = double.parse(_textEditingController0.text) * 247.1054;
      } //2nd
      else if (_textEditingController1.text == optionsTexts[1] &&
          _textEditingController2.text == optionsTexts[0]) {
        _result = double.parse(_textEditingController0.text) * 0.01;
      } else if (_textEditingController1.text == optionsTexts[1] &&
          _textEditingController2.text == optionsTexts[1]) {
        _result = double.parse(_textEditingController0.text) * 1;
      } else if (_textEditingController1.text == optionsTexts[1] &&
          _textEditingController2.text == optionsTexts[2]) {
        _result = double.parse(_textEditingController0.text) * 100;
      } else if (_textEditingController1.text == optionsTexts[1] &&
          _textEditingController2.text == optionsTexts[3]) {
        _result = double.parse(_textEditingController0.text) * 10000;
      } else if (_textEditingController1.text == optionsTexts[1] &&
          _textEditingController2.text == optionsTexts[3]) {
        _result = double.parse(_textEditingController0.text) * 1000000;
      } else if (_textEditingController1.text == optionsTexts[1] &&
          _textEditingController2.text == optionsTexts[4]) {
        _result = double.parse(_textEditingController0.text) * 100000000;
      } else if (_textEditingController1.text == optionsTexts[1] &&
          _textEditingController2.text == optionsTexts[5]) {
        _result = double.parse(_textEditingController0.text) * 1;
      } else if (_textEditingController1.text == optionsTexts[1] &&
          _textEditingController2.text == optionsTexts[6]) {
        _result = double.parse(_textEditingController0.text) * 0.0039;
      } else if (_textEditingController1.text == optionsTexts[1] &&
          _textEditingController2.text == optionsTexts[7]) {
        _result = double.parse(_textEditingController0.text) * 11959.900;
      } else if (_textEditingController1.text == optionsTexts[1] &&
          _textEditingController2.text == optionsTexts[8]) {
        _result = double.parse(_textEditingController0.text) * 107639.1042;
      } else if (_textEditingController1.text == optionsTexts[1] &&
          _textEditingController2.text == optionsTexts[9]) {
        _result = double.parse(_textEditingController0.text) * 15500031.0001;
      } else if (_textEditingController1.text == optionsTexts[1] &&
          _textEditingController2.text == optionsTexts[10]) {
        _result = double.parse(_textEditingController0.text) * 2.4711;
      } //3rd
      else if (_textEditingController1.text == optionsTexts[2] &&
          _textEditingController2.text == optionsTexts[0]) {
        _result = double.parse(_textEditingController0.text) * 0.0001;
      } else if (_textEditingController1.text == optionsTexts[2] &&
          _textEditingController2.text == optionsTexts[1]) {
        _result = double.parse(_textEditingController0.text) * 0.01;
      } else if (_textEditingController1.text == optionsTexts[2] &&
          _textEditingController2.text == optionsTexts[2]) {
        _result = double.parse(_textEditingController0.text) * 1;
      } else if (_textEditingController1.text == optionsTexts[2] &&
          _textEditingController2.text == optionsTexts[3]) {
        _result = double.parse(_textEditingController0.text) * 100;
      } else if (_textEditingController1.text == optionsTexts[2] &&
          _textEditingController2.text == optionsTexts[4]) {
        _result = double.parse(_textEditingController0.text) * 10000;
      } else if (_textEditingController1.text == optionsTexts[2] &&
          _textEditingController2.text == optionsTexts[5]) {
        _result = double.parse(_textEditingController0.text) * 1000000;
      } else if (_textEditingController1.text == optionsTexts[2] &&
          _textEditingController2.text == optionsTexts[6]) {
        _result = double.parse(_textEditingController0.text) * 0.01;
      } else if (_textEditingController1.text == optionsTexts[2] &&
          _textEditingController2.text == optionsTexts[7]) {
        _result = double.parse(_textEditingController0.text) * 0.00003861;
      } else if (_textEditingController1.text == optionsTexts[2] &&
          _textEditingController2.text == optionsTexts[8]) {
        _result = double.parse(_textEditingController0.text) * 119.599;
      } else if (_textEditingController1.text == optionsTexts[2] &&
          _textEditingController2.text == optionsTexts[9]) {
        _result = double.parse(_textEditingController0.text) * 1076.391;
      } else if (_textEditingController1.text == optionsTexts[2] &&
          _textEditingController2.text == optionsTexts[10]) {
        _result = double.parse(_textEditingController0.text) * 155000.31;
      } else if (_textEditingController1.text == optionsTexts[2] &&
          _textEditingController2.text == optionsTexts[11]) {
        _result = double.parse(_textEditingController0.text) * 0.0247;
      } //4th
      else if (_textEditingController1.text == optionsTexts[3] &&
          _textEditingController2.text == optionsTexts[0]) {
        _result = double.parse(_textEditingController0.text) * 0.000001;
      } else if (_textEditingController1.text == optionsTexts[3] &&
          _textEditingController2.text == optionsTexts[1]) {
        _result = double.parse(_textEditingController0.text) * 0.0001;
      } else if (_textEditingController1.text == optionsTexts[3] &&
          _textEditingController2.text == optionsTexts[2]) {
        _result = double.parse(_textEditingController0.text) * 0.01;
      } else if (_textEditingController1.text == optionsTexts[3] &&
          _textEditingController2.text == optionsTexts[3]) {
        _result = double.parse(_textEditingController0.text) * 1;
      } else if (_textEditingController1.text == optionsTexts[3] &&
          _textEditingController2.text == optionsTexts[4]) {
        _result = double.parse(_textEditingController0.text) * 100;
      } else if (_textEditingController1.text == optionsTexts[3] &&
          _textEditingController2.text == optionsTexts[5]) {
        _result = double.parse(_textEditingController0.text) * 10000;
      } else if (_textEditingController1.text == optionsTexts[3] &&
          _textEditingController2.text == optionsTexts[6]) {
        _result = double.parse(_textEditingController0.text) * 0.0001;
      } else if (_textEditingController1.text == optionsTexts[3] &&
          _textEditingController2.text == optionsTexts[7]) {
        _result = double.parse(_textEditingController0.text) * 0.0000003861;
      } else if (_textEditingController1.text == optionsTexts[3] &&
          _textEditingController2.text == optionsTexts[8]) {
        _result = double.parse(_textEditingController0.text) * 1.196;
      } else if (_textEditingController1.text == optionsTexts[3] &&
          _textEditingController2.text == optionsTexts[9]) {
        _result = double.parse(_textEditingController0.text) * 10.76391;
      } else if (_textEditingController1.text == optionsTexts[3] &&
          _textEditingController2.text == optionsTexts[10]) {
        _result = double.parse(_textEditingController0.text) * 1550.0031;
      } else if (_textEditingController1.text == optionsTexts[3] &&
          _textEditingController2.text == optionsTexts[11]) {
        _result = double.parse(_textEditingController0.text) * 0.000247;
      } //5th
      else if (_textEditingController1.text == optionsTexts[4] &&
          _textEditingController2.text == optionsTexts[0]) {
        _result = double.parse(_textEditingController0.text) * 0.00000001;
      } else if (_textEditingController1.text == optionsTexts[4] &&
          _textEditingController2.text == optionsTexts[1]) {
        _result = double.parse(_textEditingController0.text) * 0.000001;
      } else if (_textEditingController1.text == optionsTexts[4] &&
          _textEditingController2.text == optionsTexts[2]) {
        _result = double.parse(_textEditingController0.text) * 0.0001;
      } else if (_textEditingController1.text == optionsTexts[4] &&
          _textEditingController2.text == optionsTexts[3]) {
        _result = double.parse(_textEditingController0.text) * 0.01;
      } else if (_textEditingController1.text == optionsTexts[4] &&
          _textEditingController2.text == optionsTexts[4]) {
        _result = double.parse(_textEditingController0.text) * 1;
      } else if (_textEditingController1.text == optionsTexts[4] &&
          _textEditingController2.text == optionsTexts[5]) {
        _result = double.parse(_textEditingController0.text) * 100;
      } else if (_textEditingController1.text == optionsTexts[4] &&
          _textEditingController2.text == optionsTexts[6]) {
        _result = double.parse(_textEditingController0.text) * 0.000001;
      } else if (_textEditingController1.text == optionsTexts[4] &&
          _textEditingController2.text == optionsTexts[7]) {
        _result = double.parse(_textEditingController0.text) * 0.000000003861;
      } else if (_textEditingController1.text == optionsTexts[4] &&
          _textEditingController2.text == optionsTexts[8]) {
        _result = double.parse(_textEditingController0.text) * 0.012;
      } else if (_textEditingController1.text == optionsTexts[4] &&
          _textEditingController2.text == optionsTexts[9]) {
        _result = double.parse(_textEditingController0.text) * 0.1076391;
      } else if (_textEditingController1.text == optionsTexts[4] &&
          _textEditingController2.text == optionsTexts[10]) {
        _result = double.parse(_textEditingController0.text) * 15.500031;
      } else if (_textEditingController1.text == optionsTexts[4] &&
          _textEditingController2.text == optionsTexts[11]) {
        _result = double.parse(_textEditingController0.text) * 0.00000247;
      }
      //6th
      else if (_textEditingController1.text == optionsTexts[5] &&
          _textEditingController2.text == optionsTexts[0]) {
        _result = double.parse(_textEditingController0.text) * 0.0000000001;
      } else if (_textEditingController1.text == optionsTexts[5] &&
          _textEditingController2.text == optionsTexts[1]) {
        _result = double.parse(_textEditingController0.text) * 0.00000001;
      } else if (_textEditingController1.text == optionsTexts[5] &&
          _textEditingController2.text == optionsTexts[2]) {
        _result = double.parse(_textEditingController0.text) * 0.000001;
      } else if (_textEditingController1.text == optionsTexts[5] &&
          _textEditingController2.text == optionsTexts[3]) {
        _result = double.parse(_textEditingController0.text) * 0.0001;
      } else if (_textEditingController1.text == optionsTexts[5] &&
          _textEditingController2.text == optionsTexts[4]) {
        _result = double.parse(_textEditingController0.text) * 0.01;
      } else if (_textEditingController1.text == optionsTexts[5] &&
          _textEditingController2.text == optionsTexts[5]) {
        _result = double.parse(_textEditingController0.text) * 1;
      } else if (_textEditingController1.text == optionsTexts[5] &&
          _textEditingController2.text == optionsTexts[6]) {
        _result = double.parse(_textEditingController0.text) * 0.00000001;
      } else if (_textEditingController1.text == optionsTexts[5] &&
          _textEditingController2.text == optionsTexts[7]) {
        _result = double.parse(_textEditingController0.text) * 0.00000000003861;
      } else if (_textEditingController1.text == optionsTexts[5] &&
          _textEditingController2.text == optionsTexts[8]) {
        _result = double.parse(_textEditingController0.text) * 0.00012;
      } else if (_textEditingController1.text == optionsTexts[5] &&
          _textEditingController2.text == optionsTexts[9]) {
        _result = double.parse(_textEditingController0.text) * 0.001076391;
      } else if (_textEditingController1.text == optionsTexts[5] &&
          _textEditingController2.text == optionsTexts[10]) {
        _result = double.parse(_textEditingController0.text) * 0.15500031;
      } else if (_textEditingController1.text == optionsTexts[5] &&
          _textEditingController2.text == optionsTexts[11]) {
        _result = double.parse(_textEditingController0.text) * 0.0000000247;
      }
      //7th
      else if (_textEditingController1.text == optionsTexts[6] &&
          _textEditingController2.text == optionsTexts[0]) {
        _result = double.parse(_textEditingController0.text) * 0.01;
      } else if (_textEditingController1.text == optionsTexts[6] &&
          _textEditingController2.text == optionsTexts[1]) {
        _result = double.parse(_textEditingController0.text) * 1;
      } else if (_textEditingController1.text == optionsTexts[6] &&
          _textEditingController2.text == optionsTexts[2]) {
        _result = double.parse(_textEditingController0.text) * 100;
      } else if (_textEditingController1.text == optionsTexts[6] &&
          _textEditingController2.text == optionsTexts[3]) {
        _result = double.parse(_textEditingController0.text) * 10000;
      } else if (_textEditingController1.text == optionsTexts[6] &&
          _textEditingController2.text == optionsTexts[4]) {
        _result = double.parse(_textEditingController0.text) * 1000000;
      } else if (_textEditingController1.text == optionsTexts[6] &&
          _textEditingController2.text == optionsTexts[5]) {
        _result = double.parse(_textEditingController0.text) * 1000000000;
      } else if (_textEditingController1.text == optionsTexts[6] &&
          _textEditingController2.text == optionsTexts[6]) {
        _result = double.parse(_textEditingController0.text) * 1;
      } else if (_textEditingController1.text == optionsTexts[6] &&
          _textEditingController2.text == optionsTexts[7]) {
        _result = double.parse(_textEditingController0.text) * 0.0039;
      } else if (_textEditingController1.text == optionsTexts[6] &&
          _textEditingController2.text == optionsTexts[8]) {
        _result = double.parse(_textEditingController0.text) * 11959.9005;
      } else if (_textEditingController1.text == optionsTexts[6] &&
          _textEditingController2.text == optionsTexts[9]) {
        _result = double.parse(_textEditingController0.text) * 107639.1042;
      } else if (_textEditingController1.text == optionsTexts[6] &&
          _textEditingController2.text == optionsTexts[10]) {
        _result = double.parse(_textEditingController0.text) * 15500031.0001;
      } else if (_textEditingController1.text == optionsTexts[6] &&
          _textEditingController2.text == optionsTexts[11]) {
        _result = double.parse(_textEditingController0.text) * 2.4711;
      }
      //8th
      else if (_textEditingController1.text == optionsTexts[7] &&
          _textEditingController2.text == optionsTexts[0]) {
        _result = double.parse(_textEditingController0.text) * 2.59;
      } else if (_textEditingController1.text == optionsTexts[7] &&
          _textEditingController2.text == optionsTexts[1]) {
        _result = double.parse(_textEditingController0.text) * 258.9988;
      } else if (_textEditingController1.text == optionsTexts[7] &&
          _textEditingController2.text == optionsTexts[2]) {
        _result = double.parse(_textEditingController0.text) * 25899.8811;
      } else if (_textEditingController1.text == optionsTexts[7] &&
          _textEditingController2.text == optionsTexts[3]) {
        _result = double.parse(_textEditingController0.text) * 2589988.1103;
      } else if (_textEditingController1.text == optionsTexts[7] &&
          _textEditingController2.text == optionsTexts[4]) {
        _result = double.parse(_textEditingController0.text) * 258998811.0336;
      } else if (_textEditingController1.text == optionsTexts[7] &&
          _textEditingController2.text == optionsTexts[5]) {
        _result = double.parse(_textEditingController0.text) * 25899881103.36;
      } else if (_textEditingController1.text == optionsTexts[7] &&
          _textEditingController2.text == optionsTexts[6]) {
        _result = double.parse(_textEditingController0.text) * 258.9988;
      } else if (_textEditingController1.text == optionsTexts[7] &&
          _textEditingController2.text == optionsTexts[7]) {
        _result = double.parse(_textEditingController0.text) * 1;
      } else if (_textEditingController1.text == optionsTexts[7] &&
          _textEditingController2.text == optionsTexts[8]) {
        _result = double.parse(_textEditingController0.text) * 3097600;
      } else if (_textEditingController1.text == optionsTexts[7] &&
          _textEditingController2.text == optionsTexts[9]) {
        _result = double.parse(_textEditingController0.text) * 27878400;
      } else if (_textEditingController1.text == optionsTexts[7] &&
          _textEditingController2.text == optionsTexts[10]) {
        _result = double.parse(_textEditingController0.text) * 4014489600;
      } else if (_textEditingController1.text == optionsTexts[7] &&
          _textEditingController2.text == optionsTexts[11]) {
        _result = double.parse(_textEditingController0.text) * 640;
      }
      //9th
      else if (_textEditingController1.text == optionsTexts[8] &&
          _textEditingController2.text == optionsTexts[0]) {
        _result = double.parse(_textEditingController0.text) * 0.00000083612736;
      } else if (_textEditingController1.text == optionsTexts[8] &&
          _textEditingController2.text == optionsTexts[1]) {
        _result = double.parse(_textEditingController0.text) * 0.0001;
      } else if (_textEditingController1.text == optionsTexts[8] &&
          _textEditingController2.text == optionsTexts[2]) {
        _result = double.parse(_textEditingController0.text) * 0.0084;
      } else if (_textEditingController1.text == optionsTexts[8] &&
          _textEditingController2.text == optionsTexts[3]) {
        _result = double.parse(_textEditingController0.text) * 0.8361;
      } else if (_textEditingController1.text == optionsTexts[8] &&
          _textEditingController2.text == optionsTexts[4]) {
        _result = double.parse(_textEditingController0.text) * 83.61;
      } else if (_textEditingController1.text == optionsTexts[8] &&
          _textEditingController2.text == optionsTexts[5]) {
        _result = double.parse(_textEditingController0.text) * 8361.2736;
      } else if (_textEditingController1.text == optionsTexts[8] &&
          _textEditingController2.text == optionsTexts[6]) {
        _result = double.parse(_textEditingController0.text) * 0.0001;
      } else if (_textEditingController1.text == optionsTexts[8] &&
          _textEditingController2.text == optionsTexts[7]) {
        _result = double.parse(_textEditingController0.text) * 0.00000032283;
      } else if (_textEditingController1.text == optionsTexts[8] &&
          _textEditingController2.text == optionsTexts[8]) {
        _result = double.parse(_textEditingController0.text) * 1;
      } else if (_textEditingController1.text == optionsTexts[8] &&
          _textEditingController2.text == optionsTexts[9]) {
        _result = double.parse(_textEditingController0.text) * 9;
      } else if (_textEditingController1.text == optionsTexts[8] &&
          _textEditingController2.text == optionsTexts[10]) {
        _result = double.parse(_textEditingController0.text) * 1296;
      } else if (_textEditingController1.text == optionsTexts[8] &&
          _textEditingController2.text == optionsTexts[11]) {
        _result = double.parse(_textEditingController0.text) * 0.0002;
      }
      //10th
      else if (_textEditingController1.text == optionsTexts[9] &&
          _textEditingController2.text == optionsTexts[0]) {
        _result = double.parse(_textEditingController0.text) * 0.0000000929;
      } else if (_textEditingController1.text == optionsTexts[9] &&
          _textEditingController2.text == optionsTexts[1]) {
        _result = double.parse(_textEditingController0.text) * 0.000009290304;
      } else if (_textEditingController1.text == optionsTexts[9] &&
          _textEditingController2.text == optionsTexts[2]) {
        _result = double.parse(_textEditingController0.text) * 0.0009290;
      } else if (_textEditingController1.text == optionsTexts[9] &&
          _textEditingController2.text == optionsTexts[3]) {
        _result = double.parse(_textEditingController0.text) * 0.09290;
      } else if (_textEditingController1.text == optionsTexts[9] &&
          _textEditingController2.text == optionsTexts[4]) {
        _result = double.parse(_textEditingController0.text) * 9.2903;
      } else if (_textEditingController1.text == optionsTexts[9] &&
          _textEditingController2.text == optionsTexts[5]) {
        _result = double.parse(_textEditingController0.text) * 929.0304;
      } else if (_textEditingController1.text == optionsTexts[9] &&
          _textEditingController2.text == optionsTexts[6]) {
        _result = double.parse(_textEditingController0.text) * 0.000009290304;
      } else if (_textEditingController1.text == optionsTexts[9] &&
          _textEditingController2.text == optionsTexts[7]) {
        _result = double.parse(_textEditingController0.text) * 0.00000003587;
      } else if (_textEditingController1.text == optionsTexts[9] &&
          _textEditingController2.text == optionsTexts[8]) {
        _result = double.parse(_textEditingController0.text) * 0.1111;
      } else if (_textEditingController1.text == optionsTexts[9] &&
          _textEditingController2.text == optionsTexts[9]) {
        _result = double.parse(_textEditingController0.text) * 1;
      } else if (_textEditingController1.text == optionsTexts[9] &&
          _textEditingController2.text == optionsTexts[10]) {
        _result = double.parse(_textEditingController0.text) * 144;
      } else if (_textEditingController1.text == optionsTexts[9] &&
          _textEditingController2.text == optionsTexts[11]) {
        _result =
            double.parse(_textEditingController0.text) * 0.000022956841139;
      }
      // 11th
      else if (_textEditingController1.text == optionsTexts[10] &&
          _textEditingController2.text == optionsTexts[0]) {
        _result = double.parse(_textEditingController0.text) * 0.00000000065;
      } else if (_textEditingController1.text == optionsTexts[10] &&
          _textEditingController2.text == optionsTexts[1]) {
        _result = double.parse(_textEditingController0.text) * 0.00000006452;
      } else if (_textEditingController1.text == optionsTexts[10] &&
          _textEditingController2.text == optionsTexts[2]) {
        _result = double.parse(_textEditingController0.text) * 0.000006452;
      } else if (_textEditingController1.text == optionsTexts[10] &&
          _textEditingController2.text == optionsTexts[3]) {
        _result = double.parse(_textEditingController0.text) * 0.0006452;
      } else if (_textEditingController1.text == optionsTexts[10] &&
          _textEditingController2.text == optionsTexts[4]) {
        _result = double.parse(_textEditingController0.text) * 0.06452;
      } else if (_textEditingController1.text == optionsTexts[10] &&
          _textEditingController2.text == optionsTexts[5]) {
        _result = double.parse(_textEditingController0.text) * 6.4516;
      } else if (_textEditingController1.text == optionsTexts[10] &&
          _textEditingController2.text == optionsTexts[6]) {
        _result = double.parse(_textEditingController0.text) * 0.00000006452;
      } else if (_textEditingController1.text == optionsTexts[10] &&
          _textEditingController2.text == optionsTexts[7]) {
        _result = double.parse(_textEditingController0.text) * 0.00000000006452;
      } else if (_textEditingController1.text == optionsTexts[10] &&
          _textEditingController2.text == optionsTexts[8]) {
        _result = double.parse(_textEditingController0.text) * 0.0008;
      } else if (_textEditingController1.text == optionsTexts[10] &&
          _textEditingController2.text == optionsTexts[9]) {
        _result = double.parse(_textEditingController0.text) * 0.0069;
      } else if (_textEditingController1.text == optionsTexts[10] &&
          _textEditingController2.text == optionsTexts[10]) {
        _result = double.parse(_textEditingController0.text) * 1;
      } else if (_textEditingController1.text == optionsTexts[10] &&
          _textEditingController2.text == optionsTexts[11]) {
        _result = double.parse(_textEditingController0.text) * 0.0000001594;
      }
      // 12th
      else if (_textEditingController1.text == optionsTexts[11] &&
          _textEditingController2.text == optionsTexts[0]) {
        _result = double.parse(_textEditingController0.text) * 0.004;
      } else if (_textEditingController1.text == optionsTexts[11] &&
          _textEditingController2.text == optionsTexts[1]) {
        _result = double.parse(_textEditingController0.text) * 0.4047;
      } else if (_textEditingController1.text == optionsTexts[11] &&
          _textEditingController2.text == optionsTexts[2]) {
        _result = double.parse(_textEditingController0.text) * 40.4686;
      } else if (_textEditingController1.text == optionsTexts[11] &&
          _textEditingController2.text == optionsTexts[3]) {
        _result = double.parse(_textEditingController0.text) * 4046.8564;
      } else if (_textEditingController1.text == optionsTexts[11] &&
          _textEditingController2.text == optionsTexts[4]) {
        _result = double.parse(_textEditingController0.text) * 404685.6422;
      } else if (_textEditingController1.text == optionsTexts[11] &&
          _textEditingController2.text == optionsTexts[5]) {
        _result = double.parse(_textEditingController0.text) * 40468564.224;
      } else if (_textEditingController1.text == optionsTexts[11] &&
          _textEditingController2.text == optionsTexts[6]) {
        _result = double.parse(_textEditingController0.text) * 0.4047;
      } else if (_textEditingController1.text == optionsTexts[11] &&
          _textEditingController2.text == optionsTexts[7]) {
        _result = double.parse(_textEditingController0.text) * 0.0016;
      } else if (_textEditingController1.text == optionsTexts[11] &&
          _textEditingController2.text == optionsTexts[8]) {
        _result = double.parse(_textEditingController0.text) * 4840;
      } else if (_textEditingController1.text == optionsTexts[11] &&
          _textEditingController2.text == optionsTexts[9]) {
        _result = double.parse(_textEditingController0.text) * 43560;
      } else if (_textEditingController1.text == optionsTexts[11] &&
          _textEditingController2.text == optionsTexts[10]) {
        _result = double.parse(_textEditingController0.text) * 6272640;
      } else if (_textEditingController1.text == optionsTexts[11] &&
          _textEditingController2.text == optionsTexts[11]) {
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
          RadioListTile(
              value: 6,
              groupValue: _value,
              title: Text(optionsTexts[5]),
              activeColor: Colors.blue,
              onChanged: (int? val) {
                setState(() {
                  _value = val;

                  (_checkFormField == 1)
                      ? _textEditingController1.text = optionsTexts[5]
                      : _textEditingController2.text = optionsTexts[5];
                });
              }),
          RadioListTile(
              value: 7,
              groupValue: _value,
              title: Text(optionsTexts[6]),
              activeColor: Colors.blue,
              onChanged: (int? val) {
                setState(() {
                  _value = val;

                  (_checkFormField == 1)
                      ? _textEditingController1.text = optionsTexts[6]
                      : _textEditingController2.text = optionsTexts[6];
                });
              }),
          RadioListTile(
              value: 8,
              groupValue: _value,
              title: Text(optionsTexts[7]),
              activeColor: Colors.blue,
              onChanged: (int? val) {
                setState(() {
                  _value = val;

                  (_checkFormField == 1)
                      ? _textEditingController1.text = optionsTexts[7]
                      : _textEditingController2.text = optionsTexts[7];
                });
              }),
          RadioListTile(
              value: 9,
              groupValue: _value,
              title: Text(optionsTexts[8]),
              activeColor: Colors.blue,
              onChanged: (int? val) {
                setState(() {
                  _value = val;

                  (_checkFormField == 1)
                      ? _textEditingController1.text = optionsTexts[8]
                      : _textEditingController2.text = optionsTexts[8];
                });
              }),
          RadioListTile(
              value: 10,
              groupValue: _value,
              title: Text(optionsTexts[9]),
              activeColor: Colors.blue,
              onChanged: (int? val) {
                setState(() {
                  _value = val;

                  (_checkFormField == 1)
                      ? _textEditingController1.text = optionsTexts[9]
                      : _textEditingController2.text = optionsTexts[9];
                });
              }),
          RadioListTile(
              value: 11,
              groupValue: _value,
              title: Text(optionsTexts[10]),
              activeColor: Colors.blue,
              onChanged: (int? val) {
                setState(() {
                  _value = val;

                  (_checkFormField == 1)
                      ? _textEditingController1.text = optionsTexts[10]
                      : _textEditingController2.text = optionsTexts[10];
                });
              }),
          RadioListTile(
              value: 12,
              groupValue: _value,
              title: Text(optionsTexts[11]),
              activeColor: Colors.blue,
              onChanged: (int? val) {
                setState(() {
                  _value = val;

                  (_checkFormField == 1)
                      ? _textEditingController1.text = optionsTexts[11]
                      : _textEditingController2.text = optionsTexts[11];
                });
              }),
        ],
      );
    });
  }
}
