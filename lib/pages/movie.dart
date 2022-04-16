import 'package:flutter/material.dart';
import 'package:untitled1/pages/main_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Movie extends StatefulWidget {
  const Movie({Key? key}) : super(key: key);

  @override
  State<Movie> createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  String addMovie = "";
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
    //Вызов подключения к бд
    movieFirebase();

  }

  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: Text('Избранные фильмы',
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
      // Вывод всех имеющихся записей
      body: StreamBuilder(
        stream:  FirebaseFirestore.instance.collection('movie').snapshots(),
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
                                snapshot.data?.docs[index].get('movie'),
                                style: TextStyle(
                                  fontFamily: 'RobotoMono',
                                  color: Colors.red[500],
                                  fontSize: 20,
                                )
                            ),
                          ),
                          trailing:
                          //кнопка состояния просмотра фильма
                          Container(
                            alignment : Alignment.centerLeft,
                            height: 28.0,
                            width: 28.0,
                            child:
                            FloatingActionButton(
                              elevation: 1,
                              //child: (_buttonColor = Colors.blue),
                              onPressed: (){
                                //FirebaseFirestore.instance.collection('movie').doc(snapshot.data!.docs[index].get('status'));
                                if (snapshot.data?.docs[index].get('status') == false)
                                {
                                  // snapshot.data?.docs[index].get('status') == false
                                  FirebaseFirestore.instance.collection('movie').doc(snapshot.data!.docs[index].id).update({'status': true});
                                  // _buttonColor = Colors.green;
                                }
                                else{
                                  FirebaseFirestore.instance.collection('movie').doc(snapshot.data!.docs[index].id).update({'status': false});
                                  //_buttonColor = Colors.red;
                                }
                              },
                              //текст на кнопке в зависимости от состояния
                              child: Center(child:
                              Text(textButtonStatus = snapshot.data?.docs[index].get('status') == false? "--" : "v",
                                style: TextStyle(
                                  fontSize: 24,
                                  //color: Colors.red,
                                  fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              //цвет фона в зависимости от сотояния
                              backgroundColor: _buttonColor = snapshot.data?.docs[index].get('status') == false? Colors.red : Colors.green,
                            ),
                          )
                      ),
                    ),
                    //удалению по свайпу
                    onDismissed: (direction) {
                      FirebaseFirestore.instance.collection('movie').doc(
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
            showDialog(context: context, builder: (BuildContext context)
            {
              //всплывающее окно для ввода записи
              return AlertDialog(
                //Заголовок всплывающего окна для ввода записи
                title: Text ('Добавить',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Введенный текст
                content: TextField(
                  onChanged: (String value){
                    addMovie = value;
                  },
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red[900],
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                actions: [
                  //Кнопка сохранения введенной записи
                  ElevatedButton(
                    onPressed: () {
                      //проверка на отсутствие введенной информации
                      if (addMovie == ""){
                        Navigator.of(context).pop();
                      }
                      else{
                        FirebaseFirestore.instance.collection('movie').add({'movie': addMovie,'status': false});
                        Navigator.of(context).pop();
                      }
                      addMovie = "";
                    },
                    child: Text('Сохранить',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                        )),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade50),
                      overlayColor: MaterialStateProperty.all(Colors.white),
                      minimumSize: MaterialStateProperty.all(const Size(60, 40)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),),),
                    ),
                  )
                ],
              );
            });
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
