import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  String searchUser='';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
        backgroundColor: Colors.black,
        title: Text("المستخدمين"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(12, 10, 8, 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.shade400,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 1,
                      ),
                    ]),
                child: TextFormField(
                  onChanged: (val){
                    setState(() {
                      searchUser=val;
                    });
                  },
                  enabled: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'ابحث عن ستخدم',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.85,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                      color: Colors.white
                  ),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("Users").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if (snapshot.hasError) {
                        return  Text('يوجد خطأ في تحميل الفئات',textAlign: TextAlign.center,style: TextStyle(
                            color: Colors.orange
                        ),);
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator(color: Colors.orange,));
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                            scrollDirection: Axis.vertical,
                            children:snapshot.data!.docs.map<Widget>((document){
                              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                              if(data['name'].toString().contains(searchUser)){
                                return Card(
                                  child: ListTile(
                                    trailing:GestureDetector(child: Icon(Icons.delete,color: Colors.red,),onTap: ()async{
                                      FirebaseFirestore.instance.collection("Users").doc(document.id).delete();
                                    },),
                                    title: Text(data["name"],style: TextStyle(
                                      color: Colors.white
                                    ),),
                                    subtitle: Text(data["email"],style: TextStyle(
                                      color: Colors.white
                                    ),),
                                  ),
                                );
                              }else{
                                return Container();
                              }
                            }).toList()
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
