import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatefulWidget {
  var product;
  ProductInfo({this.product});
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("وصف المنتج"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("صور المنتج",style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),),
              SizedBox(height: 10,),
              //images
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/4,
                child:ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.product['images'].length,
                  itemBuilder: (context,index){
                    return Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      width: MediaQuery.of(context).size.width/4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blueGrey
                      ),
                      child: Image.network(widget.product['images'][index],fit: BoxFit.contain,),
                    );
                  },
                )
              ),
              SizedBox(height: 20,),
              //sizes
              Text("مقاسات المنتج",style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),),
              SizedBox(height: 10,),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.05,
                  child:ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.product['sizes'].length,
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        width: MediaQuery.of(context).size.width/4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blueGrey
                        ),
                        child: Center(
                          child: Text(widget.product['sizes'][index],style: TextStyle(

                          ),),
                        )
                      );
                    },
                  )
              ),
              SizedBox(height: 20,),
              Text("ألوان المنتج",style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),),
              SizedBox(height: 10,),
              //colors
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.05,
                  child:ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.product['colors'].length,
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        width: MediaQuery.of(context).size.width/4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blueGrey
                        ),
                        child: Center(
                          child: Text(widget.product['colors'][index],style: TextStyle(

                          ),),
                        ),
                      );
                    },
                  )
              ),
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  Text(widget.product["name"].toString(),style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                  SizedBox(width: 10,),
                  Text("أسم المنتج",style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  Text(widget.product["category"].toString(),style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                  SizedBox(width: 10,),
                  Text("أسم الفئة",style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  Text(widget.product["price"].toString(),style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                  SizedBox(width: 10,),
                  Text("السعر",style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  Text(widget.product["rating"].toString(),style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                  SizedBox(width: 10,),
                  Text("التقيم",style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  Text(widget.product["subCategory"].toString(),style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25

                  ),),
                  SizedBox(width: 10,),
                  Text("القسم",style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 25

                  ),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  Text(widget.product["vendor"].toString(),style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                  SizedBox(width: 10,),
                  Text("المورد",style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    fontSize: 25
                  ),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  Text(widget.product["description"].toString(),style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                  SizedBox(width: 10,),
                  Text("الوصف",style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  Text(widget.product["vendorInformation"].toString(),style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                  SizedBox(width: 10,),
                  Text("معلومات عن المورد",style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  Text(widget.product["productCode"].toString(),style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                  SizedBox(width: 10,),
                  Text("كود المنتج",style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                ],
              ),
              SizedBox(height: 40,),
              Text("التعليقات عن المنتج",style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/4,
                padding: EdgeInsets.all(20),
                child:  StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("Review").snapshots(),
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
                        if(data['productName'].toString().contains(widget.product['name'])){
                          return Card(
                            color: Colors.blueGrey,
                            child: ListTile(
                              trailing: IconButton(
                                icon: Icon(Icons.delete,color: Colors.orange,),
                                onPressed: ()async{
                                  await FirebaseFirestore.instance.collection("Review").doc(document.id).delete();
                                },),
                              leading: CircleAvatar(
                                  child: Center(
                                    child: Row(
                                      children: [
                                        SizedBox(width: 1,),
                                        Text(data["rating"].toString()),
                                        Icon(Icons.star,color: Colors.yellow,)
                                      ],
                                    ),
                                  )
                              ),
                              tileColor: Colors.white,
                              hoverColor: Colors.orange[200],
                              title: Text(data['userEmail']),
                              subtitle: new Text(data['description']),
                            ),
                          );
                        }else{
                          return Container();
                        }
                      }).toList(),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
