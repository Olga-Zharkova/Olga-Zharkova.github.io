import 'package:flutter/material.dart';
import 'package:untitled1/pages/main_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class AddRecord extends StatefulWidget {
  const AddRecord({Key? key}) : super(key: key);

  @override
  State<AddRecord> createState() => _AddRecordState();
}


class _AddRecordState extends State<AddRecord> {
  String addRecord = "";

  //Подключения к бд
  void movieFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    movieFirebase();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red[50],
        appBar: AppBar(
          leading: BackButton(
            onPressed: (){
              if (addRecord == "" || addRecord == " "){
                Navigator.pushNamed(context, '/notepad');
              }
              else{
                FirebaseFirestore.instance.collection('notepad').add({'record': addRecord});
                Navigator.pushNamed(context, '/notepad');
              }
              addRecord = "";
            },
          ),
          backgroundColor: Colors.red[200],
          actions: [
            //кнопка сохранения записи
            Container(
              alignment : Alignment.centerLeft,
              height: 45.0,
              width: 45.0,
              child:
              FloatingActionButton(
                  backgroundColor: Colors.red[200],
                  elevation: 0,
                  onPressed: (){
                    if (addRecord == "" || addRecord == " "){
                      Navigator.pushNamed(context, '/notepad');
                    }
                    else{
                      FirebaseFirestore.instance.collection('notepad').add({'record': addRecord});
                      Navigator.pushNamed(context, '/notepad');
                    }
                    addRecord = "";
                  },
                  child: Icon(
                    Icons.save,
                    color: Colors.red[900],
                    size: 25,
                  )
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 20)),
            //кнопка удаления записи
            Container(
              alignment : Alignment.centerLeft,
              height: 45.0,
              width: 45.0,
              child:
              FloatingActionButton(
                  backgroundColor: Colors.red[200],
                  elevation: 0,
                  onPressed: (){
                    Navigator.pushNamed(context, '/notepad');
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red[900],
                    size: 25,
                  )
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 30)),
          ],
        ),
        //контейнер для работы с целой областью экрана
        body: FractionallySizedBox(
          widthFactor: 1,
          child:
          TextField(
            onChanged: (String value){
              addRecord = value;
            },
            autofocus: true,
            maxLines: 100,
            minLines: 1,
            //настройки
            decoration: InputDecoration(
              //убираем границу снизу
              border: InputBorder.none,
              //отступы от краев
              contentPadding: EdgeInsets.only(left: 5, top: 5, right: 5),
            ),
            // стиль введенного текста
            style: TextStyle(
              fontSize: 24,
              color: Colors.red[900],
              fontFamily: 'RobotoMono',
              fontWeight: FontWeight.w600,
            ),
          ),
        )
    );
  }
}