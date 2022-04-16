import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:untitled1/pages/movie.dart';
import 'package:untitled1/pages/notepad.dart';
import 'package:untitled1/pages/plan.dart';

class  MainUser extends StatefulWidget {
  const MainUser({Key? key}) : super(key: key);

  @override
  State<MainUser> createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  void movieFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    //Вызов подключения к бд
    movieFirebase();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: Text('Hello',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.red[50],
            fontFamily: 'SyneMono',
           )
        ),
        centerTitle: true,
        backgroundColor: Colors.red[200],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(top: 100)),
              Text('Страница выбора',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red[500],
                  fontWeight: FontWeight.w700,
                  fontSize: 34,
                  fontFamily: 'PTSansNarrow',
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(left: 15)),
              Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 50)),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/movie');
                    },
                    icon: Icon(Icons.slow_motion_video_outlined),
                    label: Text('Избранные фильмы'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      overlayColor: MaterialStateProperty.all(Colors.red.shade200),
                      minimumSize: MaterialStateProperty.all(const Size(250, 70)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),),),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                        fontSize: 18,
                        fontFamily: 'RobotoMono',
                        fontWeight: FontWeight.w600,
                      ),),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 30)),
                  ElevatedButton.icon(onPressed: () {
                    Navigator.pushNamed(context, '/notepad');
                  },
                    icon: Icon(Icons.app_registration),
                    label: Text ('Блокнот'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      overlayColor: MaterialStateProperty.all(Colors.red.shade200),
                      minimumSize: MaterialStateProperty.all(const Size(250, 70)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),),),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                        fontSize: 18,
                        fontFamily: 'RobotoMono',
                        fontWeight: FontWeight.w600,
                      ),),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 30)),
                  ElevatedButton.icon(onPressed: () {
                    Navigator.pushNamed(context, '/plan');
                  },
                    icon: Icon(Icons.event_note_outlined),
                    label: Text ('Планер'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      overlayColor: MaterialStateProperty.all(Colors.red.shade200),
                      minimumSize: MaterialStateProperty.all(const Size(250, 70)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),),),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                        fontSize: 18,
                        fontFamily: 'RobotoMono',
                        fontWeight: FontWeight.w600,
                      ),),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.red[50],
        child: Icon(
          Icons.settings,
          color: Colors.red,
          size: 50.0,
        )
      ),
    );
  }
}

