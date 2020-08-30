import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/models/product.dart';
import 'package:virtual_store/models/product_manager.dart';
import 'package:virtual_store/models/user_manager.dart';
import 'package:virtual_store/screens/base/base_screen.dart';
import 'package:virtual_store/screens/login/login_screen.dart';
import 'package:virtual_store/screens/product_detail/product_screen.dart';
import 'package:virtual_store/screens/signup/signup_screen.dart';

void main() async {
  runApp(MyApp());

  //.add -> id unico no firebase
  //Firestore.instance.collection('pedidos').add({"preco": 199.99,"user": "Thiago"});

  //.document -> cria um documento de nome estipulado, setdata num mesmo documento nao insere um novo igual, mas sim atualiza o existente.
  //Firestore.instance.collection('pedidos').document('#000001').setData({"preco": 349.99,"user": "ThiagoDantas"});

  //updadedata irá somente atualizar o campo q foi alterado.
  //Firestore.instance.collection('pedidos').document('#000001').updateData({"user": "Thiago Dantas2"});

  //buscando um documento
  //DocumentSnapshot ds = await Firestore.instance.collection('pedidos').document('#000001').get();
  //print(ds.data);
  //print(ds.data['user']);

  //.snapshots().listen -> vai observar a base do firebase, qnd tiver algum dado sendo alterado, e chamada a ação do listen.
  //Firestore.instance.collection('pedidos').document('#000001').snapshots().listen((event) {
  //  print(event.data);
  //});

  //pegar todos os documentos de uma coleçao
  //QuerySnapshot qs = await Firestore.instance.collection('pedidos').getDocuments();
  //for(DocumentSnapshot document in qs.documents){
  //  print(document.data);
  //}

  //Observar mudança numa coleçao e chamar a ação codificada no listen
  Firestore.instance.collection('pedidos').snapshots().listen((snapshot) {
    for (DocumentSnapshot document in snapshot.documents) {
      print(document.data);
    }
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=> UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_)=> ProductManager(),
          lazy: false,
        )
      ],
      child: MaterialApp(
        title: 'Loja Virtual',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: Color.fromARGB(255, 4, 125, 141),
          appBarTheme: AppBarTheme(elevation: 0),
          //primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: BaseScreen(),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/base':
              return MaterialPageRoute(builder: (_) => BaseScreen());

            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());

            case '/product':
              return MaterialPageRoute(builder: (_) => ProductScreen(product: settings.arguments as Product,));

            case '/signup':
              return MaterialPageRoute(builder: (_) => SignUpScreen());

            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
