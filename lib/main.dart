import 'package:flutter/material.dart';
import 'package:untitled1/pages/main_user.dart';
import 'package:untitled1/pages/movie.dart';
import 'package:untitled1/pages/notepad.dart';
import 'package:untitled1/pages/plan.dart';
import 'package:untitled1/pages/addRecord.dart';
import 'package:untitled1/pages/editRecord.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void movieFirebase() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

void main() {
  movieFirebase();
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.red[100],
    ),
    initialRoute: '/',
    routes: {
      '/':(contex) => MainUser(),
      '/movie': (contex) => Movie(),
      '/notepad': (contex) => Notepad(),
      '/notepad/addRecord': (conntex) => AddRecord(),
      //'/notepad/editRecord': (conntex) => EditRecord(id: 'jjj',),
      '/plan': (conntex) => Plan(),
    },
  ));
}

