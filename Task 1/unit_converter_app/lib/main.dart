import 'package:flutter/material.dart';
import 'package:unit_converter_app/screens/area_screen.dart';
import 'package:unit_converter_app/screens/frequency_screen.dart';
import 'package:unit_converter_app/screens/length_screen.dart';
import 'package:unit_converter_app/screens/mass_screen.dart';
import 'package:unit_converter_app/screens/speed_screen.dart';
import 'package:unit_converter_app/screens/temperature_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 154, 5, 180)),
          cardColor: Colors.black,
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.black,
          cardTheme: const CardTheme(color: Color.fromARGB(255, 85, 82, 82))),
      home: const MyHomePage(title: 'Unit Converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Wrap(
          children: [
            // main column
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    // main row1
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const AreaScreen()));
                          },
                          child: SizedBox(
                            height: 140,
                            width: 190,
                            child: Card(
                              //sub column1
                              child: Column(
                                children: [
                                  Image.asset('assets/images/area.png'),
                                  const Text(
                                    "Area",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //sub column2
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SpeedScreen()));
                          },
                          child: SizedBox(
                            height: 140,
                            width: 190,
                            child: Card(
                              child: Column(
                                children: [
                                  Image.asset('assets/images/speed.png'),
                                  const Text(
                                    "Speed",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //main row 2
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    // main row2
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LengthScreen()));
                          },
                          child: SizedBox(
                            height: 140,
                            width: 190,
                            child: Card(
                              //sub column1
                              child: Column(
                                children: [
                                  Image.asset('assets/images/length.png'),
                                  const Text(
                                    "Length",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //sub column2
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const TemperatureScreen()));
                          },
                          child: SizedBox(
                            height: 140,
                            width: 190,
                            child: Card(
                              child: Column(
                                children: [
                                  Image.asset('assets/images/temperature.png'),
                                  const Text(
                                    "Temperature",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // main row 3
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    // main row3
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const FrequencyScreen()));
                          },
                          child: SizedBox(
                            height: 140,
                            width: 190,
                            child: Card(
                              //sub column1
                              child: Column(
                                children: [
                                  Image.asset('assets/images/frequency.png'),
                                  const Text(
                                    "Frequency",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //sub column2
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const MassScreen()));
                          },
                          child: SizedBox(
                            height: 140,
                            width: 190,
                            child: Card(
                              child: Column(
                                children: [
                                  Image.asset('assets/images/mass.png'),
                                  const Text(
                                    "Mass",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
