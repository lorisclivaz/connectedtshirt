import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'T-shirt connected',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'T-shirt connected'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //Variable that get all the data from the t-shirt
  String _data = "";

  //List that will stored one line of data per seconde
  late List<String> temp;

  //Variable for each part of data
  var time;
  var heartFrequency;
  var temperature;
  var humidity;


  //Methode that will connect the application with the web server in this ip (192.168.4.2) and get the data
  void getData() async {

    //Connect to the server IP
    Response response = await get(Uri.parse('http://192.168.4.2'));

    //Store the response body on the list with a split function
    temp = response.body.split(" ");


    //Increment the variables to those different variables
    time = temp[0];
    heartFrequency = temp[1];
    temperature = temp[2];
    humidity = temp[3];

    //Print on the console the data
    print("Data : "+ time.toString()+ "  "+ heartFrequency.toString()
    +"  "+ temperature.toString()+"  "+ humidity.toString());


    //We set the state of the label that show the data in real time to the application
    setState(() {

      _data = "Data : "+ time.toString()+ "  "+ heartFrequency.toString()
          +"  "+ temperature.toString()+"  "+ humidity.toString();


    });
    
  }

  //InitState methode that launch the code when the application in starting
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //We increment a timer every 2 secondes the get the data and we put the get data methode inside the timer
    Timer mytimer = Timer.periodic(Duration(seconds: 2), (timer) {

      //Methode that get all data
      getData();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }


  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You can see de t-shirt data in real time',
            ),
            Text(
              '$_data',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}


