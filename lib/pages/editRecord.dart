import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:untitled1/pages/main_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class EditRecord extends StatefulWidget {
  final String id;
  const EditRecord({Key? key, required this.id//
   }) : super(key: key);

  //Navigator.push(SecondScreen(content_id:id));
  @override
  State<EditRecord> createState() => _EditRecordState();
}


class _EditRecordState extends State<EditRecord> {
  String editRecord = "";
  String ishText = "";
  String ishText1 = "";
  String ttext = "";
  //String? pop;

  //Подключения к бд
  void movieFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    print(widget.id);
    super.initState();
    movieFirebase();
  }

  Widget build(BuildContext context) {
    //print(FirebaseFirestore.reference().child("path/to/user/record/email").once()).value;
    //FirebaseDatabase.instance.instance.collection('notepad').equalTo(record.uid);
    //FirebaseDatabase.instance.reference().child("path/to/user/record/email").once()).value

    //ishText= FirebaseFirestore.instance.collection('notepad').where('id', isEqualTo: widget.id).get() as String;
    //ishText= FirebaseFirestore.instance.collection('notepad').where('id', isEqualTo: widget.id).value as String;
    //ishText1=ishText.data['record'];
    //= FirebaseFirestore.instance.collection('notepad').add({'record': addRecord});
    //ishText = snapshot.data?.docs[index].get('record'),
    ishText = "  ";
    //ttext = ishText.characters({record});
    print(ishText);
    return Scaffold(
      //key: Key(snapshot.data!.docs[index].id),
        backgroundColor: Colors.red[50],
        appBar: AppBar(
          backgroundColor: Colors.red[200],
          leading: BackButton(
            onPressed: (){
              if (editRecord == "" || editRecord == " "){
                Navigator.pushNamed(context, '/notepad');
              }
              else{
                FirebaseFirestore.instance.collection('notepad').doc(widget.id).update({'record': editRecord});
                Navigator.pushNamed(context, '/notepad');
              }
              editRecord = "";
            },
          ),
          actions: [
            //кнопка редактирования записи
            Container(
              alignment : Alignment.centerLeft,
              height: 50.0,
              width: 45.0,
              child:
              // кнопка сохранения изменений (редактирования)
              FloatingActionButton(
                  backgroundColor: Colors.red[200],
                  elevation: 0,
                  onPressed: (){
                    if (editRecord == "" || editRecord == " "){
                      Navigator.pushNamed(context, '/notepad');
                    }
                    else{
                      FirebaseFirestore.instance.collection('notepad').doc(widget.id).update({'record': editRecord});
                      Navigator.pushNamed(context, '/notepad');
                    }
                    editRecord = "";
                  },
                  child: Icon(
                    Icons.edit,
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
              //кнопка удаления записи
              FloatingActionButton(
                  backgroundColor: Colors.red[200],
                  elevation: 0,
                  onPressed: (){
                    FirebaseFirestore.instance.collection('notepad').doc(widget.id).delete();
                    Navigator.pushNamed(context, '/notepad');
                    editRecord = "";
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
          TextFormField(
            //initialValue: FirebaseFirestore.instance.collection('notepad').where('id', isEqualTo: widget.id).get(),
            initialValue: ishText,
            //initialValue: "ishText",
            onChanged: (String value){
              //print(FirebaseFirestore.instance.collection('notepad').where('id', isEqualTo: widget.id).get());
              //добавить исходные данные
              editRecord = value;
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