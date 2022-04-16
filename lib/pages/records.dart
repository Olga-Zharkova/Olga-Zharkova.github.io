import 'package:flutter/material.dart';
import 'package:untitled1/pages/main_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Records extends StatefulWidget {
  const Records({Key? key}) : super(key: key);

  @override
  State<Records> createState() => _RecordsState();
}


class _RecordsState extends State<Records> {
  String addRecord = "";
  late Color _buttonColor;
  String? textButtonStatus;

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
            if (addRecord == ""){
              Navigator.of(context).pop();
            }
            else{
              FirebaseFirestore.instance.collection('notepad').add({'record': addRecord});
              Navigator.of(context).pop();
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
                  if (addRecord == ""){
                    Navigator.of(context).pop();
                  }
                  else{
                    FirebaseFirestore.instance.collection('notepad').add({'record': addRecord});
                    Navigator.of(context).pop();
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