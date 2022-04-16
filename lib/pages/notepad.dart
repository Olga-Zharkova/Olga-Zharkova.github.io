import 'package:flutter/material.dart';
import 'package:untitled1/pages/main_user.dart';
import 'package:untitled1/pages/editRecord.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Notepad extends StatefulWidget {
  const Notepad({Key? key}) : super(key: key);


  @override
  State<Notepad> createState() => _NotepadState();
}

class _NotepadState extends State<Notepad> {
  String? addNotepad;
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
            Navigator.pushNamed(context, '/');
          },
        ),
        title: Text('Блокнот',
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
      body: StreamBuilder(
        stream:  FirebaseFirestore.instance.collection('notepad').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          //if (!snapshot.hasData) return Text('Нет записей');
          return ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index){
                return Dismissible(
                    key: Key(snapshot.data!.docs[index].id),
                    //карточка
                    child: Card(
                      //тень
                      elevation: 10,
                      //строка = карточке
                      child: ListTile(
                        //Вывод всех записей
                          title:
                          Container(
                            alignment : Alignment.centerLeft,
                            height: 50.0,
                            child:
                            Text(
                                snapshot.data?.docs[index].get('record'),
                                style: TextStyle(
                                  fontFamily: 'RobotoMono',
                                  color: Colors.red[500],
                                  fontSize: 20,
                                )
                            ),
                          ),
                          trailing:
                          //кнопка настройки записи (переход в другой класс)
                          Container(
                            alignment : Alignment.centerLeft,
                            height: 50.0,
                            width: 40.0,
                            child:
                            FloatingActionButton(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              //child: (_buttonColor = Colors.blue),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditRecord(id: snapshot.data!.docs[index].id)),
                                //arguments: {'id': snapshot.data!.docs[index].id}
                                    );
                              },
                              //текст на кнопке в зависимости от состояния
                              child: Icon(
                                Icons.settings,
                                color: Colors.red,
                                size: 25,
                            )
                              //цвет фона в зависимости от сотояния
                            ),
                          )
                      ),
                    ),
                    //удалению по свайпу
                    onDismissed: (direction) {
                      FirebaseFirestore.instance.collection('notepad').doc(
                          snapshot.data!.docs[index].id).delete();
                    }
                );
              }
          );
        },
      ),
      //кнопка + расположение вдоль экрана
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      //кнопка добавления записи на странице
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/notepad/addRecord');
            },
          //Иконка для добавления записи
          elevation: 10.0, // тень
          backgroundColor: Colors.red[50],
          child: Icon(
            Icons.add,
            color: Colors.red,
            size: 30,
          )
        ),
      );
  }
}


