import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

List estadiosLista =[];

void main() {
  WidgetsFlutterBinding.ensureInitialized();//inicializa cada uno de los widgets que va a aplicar para cada uno de las base de adtos 
  Firebase.initializeApp().then((value) {runApp(FireBaseFlutter());});
  //runApp(FireBaseFlutter());

}


void getEstadios () async {  
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
    getEstadios();
    
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Estadios Firebase"),
      ),
      body: Center(
        child: //Text('Hello Wordl'),
           ListView.builder(
              itemCount: estadiosLista != null ? estadiosLista.length : 0,
              itemBuilder: (_, int index) {
                print(estadiosLista[index]['nombre']);
                //DocumentReference docRef = FirebaseFirestore.instance.doc(estadiosLista[index]['equipo']);                
                return GestureDetector(
                  onTap: () async {                    
                    print(estadiosLista[index]['equipo']);
                    DocumentReference docRef = FirebaseFirestore.instance.doc(estadiosLista[index]['equipo'].toString());
                    
                  },
                  child: Card(
                  elevation: 2.0,
                  child: Column(                    
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // Text(itempk.num),
                      SizedBox(height:20),
                       Container(
                         padding: EdgeInsets.all(2.0),
                         height: 250,
                         width: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage( estadiosLista[index]['img']),
                                fit: BoxFit.cover),
                          ),
                       ),
                      SizedBox(height:10),
                      Text("Nombre:" + estadiosLista[index]['nombre']),
                      SizedBox(height:10),
                      Text("Capacidad: " + estadiosLista[index]['capacidad'].toString()),
                      
                      
                      // SizedBox(height:5),
                      // Text("Color de piel: " + itempk.skin_color),
                      // SizedBox(height:5),
                      // Text("Año de nacimiento: " + itempk.birth_year),
                       SizedBox(height:15),
                    ],
                  ),

                ),
                ); 
                //  ListTile(
                //   leading: Icon(Icons.list),
                //   title: Text(estadiosLista[index]['nombre']),

                //   );
                
              },
        ),
      )
    );
    
    
      
  }

  
}
