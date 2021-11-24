import 'dart:async';
import 'package:connectedtshirt/main.dart';
import 'package:firebase_database/firebase_database.dart';


//Create the class database
class Database
{

  //Reference about firestore
  final DatabaseReference _messagesRef =
  FirebaseDatabase.instance.reference().child('Data');


  //Methode that send the data to firebase
  void sendData(dataTemp data) {
    print('Send data');
    _messagesRef.push().set(data.toJson());
  }

}