import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();//inicializa cada uno de los widgets que va a aplicar para cada uno de las base de adtos 
  Firebase.initializeApp().then((value) {runApp(FireBaseFlutter());});
  //runApp(FireBaseFlutter());

}


void getUsuario () async {
  List estadiosLista =[];
  CollectionReference collectionReference =  FirebaseFirestore.instance.collection('estadios');
  QuerySnapshot estadios = await collectionReference.get();
  if (estadios.docs.isNotEmpty) {
    for (var docu in estadios.docs){
      print(docu.data());            
      estadiosLista.add(docu.data());

    }
  } 
}

class FireBaseFlutter extends StatelessWidget {
  //const FireBaseFlutter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AppFlute(),

    );
  }
}

class AppFlute extends StatefulWidget {
  AppFlute({Key? key}) : super(key: key);

  @override
  State<AppFlute> createState() => _AppFluteState();
}

class _AppFluteState extends State<AppFlute> {
  @override
  void initState() {
    
    super.initState();
    getUsuario();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter demo"),
      ),
      body: Center(
        child: Text('Hello Wordl'),
      )
    );
    
  }
}