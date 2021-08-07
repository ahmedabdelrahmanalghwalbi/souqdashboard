import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboardsouq/pages/productInfo/product_info.dart';
import 'package:flutter/material.dart';

class DisplayProducts extends StatefulWidget {
  @override
  _DisplayProductsState createState() => _DisplayProductsState();
}

class _DisplayProductsState extends State<DisplayProducts> {
  String searchProduct="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("عرض كل المنتجات"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              TextFormField(
                onChanged: (val){
                  setState(() {
                    searchProduct=val;
                  });
                },
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'ابحث عن منتج',
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
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("Product").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }
                      return ListView(
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                          if(data['name'].toString().contains(searchProduct)){
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductInfo(product: data,)));
                                },
                                child: Card(
                                  child: Container(
                                      height: MediaQuery.of(context).size.height/4,
                                      width: MediaQuery.of(context).size.width*0.9,
                                      child: Row(
                                        children: [
                                          Expanded(flex:3,child: Container(
                                              child: Image.network(data["images"][0],fit: BoxFit.contain,)),),
                                          Expanded(
                                            flex: 6,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Expanded(child: Container(child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:MainAxisAlignment.end,
                                                      children: [
                                                        Text(data["name"].toString(),style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                        SizedBox(width: 10,),
                                                        Text("أسم المنتج",style: TextStyle(
                                                            color: Colors.orange,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:MainAxisAlignment.end,
                                                      children: [
                                                        Text(data["category"].toString(),style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                        SizedBox(width: 10,),
                                                        Text("أسم الفئة",style: TextStyle(
                                                            color: Colors.orange,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                      ],
                                                    ),
                                                  ],
                                                ),),),
                                                Expanded(child: Container(child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:MainAxisAlignment.end,
                                                      children: [
                                                        Text(data["price"].toString(),style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                        SizedBox(width: 10,),
                                                        Text("السعر",style: TextStyle(
                                                            color: Colors.orange,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:MainAxisAlignment.end,
                                                      children: [
                                                        Text(data["rating"].toString(),style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                        SizedBox(width: 10,),
                                                        Text("التقيم",style: TextStyle(
                                                            color: Colors.orange,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                      ],
                                                    ),
                                                  ],
                                                ),),),
                                                Expanded(child: Container(child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:MainAxisAlignment.end,
                                                      children: [
                                                        Text(data["subCategory"].toString(),style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                        SizedBox(width: 10,),
                                                        Text("القسم",style: TextStyle(
                                                            color: Colors.orange,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:MainAxisAlignment.end,
                                                      children: [
                                                        Text(data["vendor"].toString(),style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                        SizedBox(width: 10,),
                                                        Text("المورد",style: TextStyle(
                                                            color: Colors.orange,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                      ],
                                                    ),
                                                  ],
                                                ),),),
                                              ],
                                            ),
                                          ),
                                          Expanded(flex:1,child: Container(child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              IconButton(icon:Icon(Icons.delete,color: Colors.orange,),onPressed:()async{
                                                await FirebaseFirestore.instance.collection("Product").doc(document.id).delete();
                                              },),
                                            ],
                                          ),))
                                        ],
                                      )
                                  ),
                                ),
                              ),
                            );
                          }else{
                            return Container();
                          }

                        }).toList(),
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
