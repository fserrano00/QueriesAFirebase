import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class querieExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final CollectionReference chatsCollection =
      FirebaseFirestore.instance.collection('chats');

  Future<void> agregarChatEjemplo() async {
    await chatsCollection.add({
      'nombre': 'Chat de ejemplo',
      'usuarios': ['userId1', 'userId2'],
      'lastModified': DateTime.now(),
      'messages': [
        {
          'senderId': 'userId1',
          'message': '¡Hola!',
          'timestamp': DateTime.now(),
        }
      ],
    });
  }

  Future<List<DocumentSnapshot>> getExistingChats(String currentUserId) async {
    QuerySnapshot querySnapshot = await chatsCollection
        .where('usuarios', arrayContains: currentUserId)
        .get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await agregarChatEjemplo();
              },
              child: Text('Agregar Chat de Ejemplo'),
            ),
            ElevatedButton(
              onPressed: () async {
                List<DocumentSnapshot> chats =
                    await getExistingChats('userId1');
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Chats para el usuario'),
                      content: Container(
                        width: double.maxFinite,
                        height: 300,
                        child: ListView.builder(
                          itemCount: chats.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(chats[index].id),
                              subtitle: Text(
                                'Last modified: ${chats[index]['lastModified'].toString()}',
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text('Obtener Chats'),
            ),
          ],
        ),
      ),
    );
  }
}
