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

late CollectionReference cref;

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    cref = FirebaseFirestore.instance.collection('root');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('テストアプリ')),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: cref.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        print("########## Firestore Access start");
        snapshot.data!.docs.forEach((elem) {
          print(elem.id);
          print(elem.get('email'));
        });
        print("########## Firestore Access end");

        return Text('test');
      },
    );
  }
}
