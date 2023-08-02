import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('You have an error! ${snapshot.error.toString()}');
            return Text('Something went wrong');
          } else if (snapshot.hasData) {
            return MyHomePage(title: 'Hute');
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
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
  int _counter = 0;
  String tempVal_1 = "0";
  String tempVal_2 = "0";
  String humidVal_1 = "0";
  String humidVal_2 = "0";

  void _fetchValue() {
    // ignore: deprecated_member_use
    DatabaseReference _humid_1 =
        FirebaseDatabase.instance.ref().child("board1/hum");
    DatabaseReference _temp_1 =
        FirebaseDatabase.instance.ref().child("board1/temp");
    DatabaseReference _humid_2 =
        FirebaseDatabase.instance.ref().child("board2/hum");
    DatabaseReference _temp_2 =
        FirebaseDatabase.instance.ref().child("board2/temp");

    setState(() {
      _humid_1.onValue.listen(
        (event) {
          humidVal_1 = event.snapshot.value.toString();
          print(humidVal_1.toString());
        },
      );
      _temp_1.onValue.listen(
        (event) {
          tempVal_1 = event.snapshot.value.toString();
        },
      );
      _humid_2.onValue.listen(
        (event) {
          humidVal_2 = event.snapshot.value.toString();
          print(humidVal_2.toString());
        },
      );
      _temp_2.onValue.listen(
        (event) {
          tempVal_2 = event.snapshot.value.toString();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Board 1",
                  style: TextStyle(fontSize: 25),
                ),
                alignment: Alignment.topLeft,
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Card(
                  elevation: 20,
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Temperature: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            tempVal_1 + "\u2103",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 40),
                          ),
                        ),
                        //Icon(Icons.ac_unit),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Card(
                  elevation: 20,
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Humidity: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            humidVal_1 + "%",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                        ),
                        //Icon(Icons.ac_unit),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Board 2",
                  style: TextStyle(fontSize: 25),
                ),
                alignment: Alignment.topLeft,
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Card(
                  elevation: 20,
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Temperature: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            tempVal_2 + "\u2103",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 40),
                          ),
                        ),
                        //Icon(Icons.ac_unit),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Card(
                  elevation: 20,
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Humidity: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            humidVal_2 + "%",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                        ),
                        //Icon(Icons.ac_unit),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                height: 50,
                child: ElevatedButton(
                  onPressed: _fetchValue,
                  child: Text("Get Data"),
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
