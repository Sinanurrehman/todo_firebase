import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_firebase/screens/add_task.dart';
import 'package:todo_firebase/screens/description.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid = '';
  @override
  void initState() {
    getuid();
    super.initState();
  }

  getuid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User user = await auth.currentUser!;
    setState(() {
      uid = user.uid;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TODO"), actions: [
        IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout))
      ]),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Task')
              .doc(uid)
              .collection('mytask')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final docs = snapshot.data?.docs;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: docs!.length,
                itemBuilder: (context, Index) {
                  var time = (docs[Index]['timestamp'] as Timestamp).toDate();
                  //.toString();
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Description(
                                  title: docs[Index]['title'],
                                  description: docs[Index]['description'])));
                    },
                    child: Card(
                      margin: EdgeInsets.only(bottom: 10),
                      color: Colors.purple,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(docs[Index]['title'],
                                      style: GoogleFonts.roboto(fontSize: 25))),
                              SizedBox(height: 10),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text(
                                    DateFormat.yMd().add_jm().format(time)),
                              )
                            ],
                          ),
                          Container(
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection("Task")
                                    .doc(uid)
                                    .collection('mytask')
                                    .doc(docs[Index]['time'])
                                    .delete();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddTask()));
          }),
    );
  }
}
