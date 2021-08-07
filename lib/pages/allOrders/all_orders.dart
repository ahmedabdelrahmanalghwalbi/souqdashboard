import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboardsouq/pages/orderDetails/order_details.dart';
import 'package:flutter/material.dart';

class AllOrders extends StatefulWidget {
  @override
  _AllOrdersState createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  String searchOrder='';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
        backgroundColor: Colors.black,
        title: Text("جميع الطلبات"),
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
                      searchOrder=val;
                    });
                  },
                  enabled: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'ابحث عن الطلب',
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
                    stream: FirebaseFirestore.instance.collection("Order").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if (snapshot.hasError) {
                        return  Text('يوجد خطأ في تحميل الطلبات',textAlign: TextAlign.center,style: TextStyle(
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
                              if(data["phoneNumber"].toString().contains(searchOrder)){
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OrderDetails(order: data,)));
                                  },
                                  child: Card(
                                    child: ListTile(
                                      trailing:GestureDetector(child: Icon(Icons.delete,color: Colors.red,),onTap: ()async{
                                        FirebaseFirestore.instance.collection("Order").doc(document.id).delete();
                                      },),
                                      title: Text(data["userName"],style: TextStyle(
                                          color: Colors.white
                                      ),),
                                      subtitle: Text(data["phoneNumber"],style: TextStyle(
                                          color: Colors.white
                                      ),),
                                    ),
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
