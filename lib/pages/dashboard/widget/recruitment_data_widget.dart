import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboardsouq/pages/orderDetails/order_details.dart';
import 'package:flutter/material.dart';
import 'package:dashboardsouq/common/app_colors.dart';
import 'package:dashboardsouq/common/app_responsive.dart';

class RecruitmentDataWidget extends StatefulWidget {
  @override
  _RecruitmentDataWidgetState createState() => _RecruitmentDataWidgetState();
}

class _RecruitmentDataWidgetState extends State<RecruitmentDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "الطلبات",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.7,
            padding: EdgeInsets.all(10),
            child:  StreamBuilder(
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
                        if(data['isDone'].toString()=="false"){
                          return GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OrderDetails(order:data)));
                            },
                            child: Card(
                              color: Colors.white,
                              child: ListTile(
                                trailing:GestureDetector(child: Icon(Icons.check,color: Colors.red,),onTap: ()async{
                                  FirebaseFirestore.instance.collection("Order").doc(document.id).update({"isDone":true});
                                },),
                                title: Text(data["userName"],style: TextStyle(
                                    color: Colors.black
                                ),),
                                leading: Text(data["totalPrice"].toString(),style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold
                                ),),
                                subtitle: Text(data["phoneNumber"],style: TextStyle(
                                    color: Colors.black
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
          )
        ],
      ),
    );
  }
}
