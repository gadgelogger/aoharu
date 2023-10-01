import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Query<Map<String, dynamic>> _usersRef = FirebaseFirestore.instance
      .collection('confessions')
      .orderBy('time', descending: false);

  List<DocumentSnapshot> _users = [];

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  Future<void> _getUsers() async {
    QuerySnapshot querySnapshot = await _usersRef.get();
    setState(() {
      _users = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: 500,
            height: 300,
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: 160,
                    width: 280,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(34),
                      ),
                      child: const Column(
                        children: [Text('Atom'), Text('好きです。付き合ってください。')],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 200,
                  child: SizedBox(
                    height: 100,
                    width: 250,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(34),
                      ),
                      elevation: 10,
                      child: const Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Atom'),
                              Text(_users[index]['confession'])
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 150,
                      left: 200,
                      child: SizedBox(
                        height: 100,
                        width: 250,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(34),
                          ),
                          elevation: 10,
                          child: const Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('いいね👍'),
                                  Icon(Icons.account_circle_outlined)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('うんうん'),
                                  Icon(Icons.account_circle_outlined)
                                ],
                              ),
                              Icon(Icons.chat)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
