import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('テストアプリ')),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return OutlinedButton(
      child: Text("サブコレクション追加"),
      onPressed: () async {
        print("########## onPressed start");
        CollectionReference cref = FirebaseFirestore.instance.collection('root');
        QuerySnapshot qs = await cref.get();
        String nextID = qs.docs.length.toString();
        print('########## nextID: ' + nextID);
        cref.doc(nextID).set({'name':'dummy'}); // (1)ドキュメントを作る
        cref.doc(nextID).collection('sub').doc().set({'email': 'dummy@gmail.com'}); // (2)サブコレクションを作る
        print("########## onPressed end");
      },
    );
  }
}
