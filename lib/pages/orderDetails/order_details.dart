import 'package:dashboardsouq/pages/productInfo/product_info.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  var order;
  OrderDetails({this.order});
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("وصف الطلب"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2,
                child: ListView.builder(
                  itemCount: widget.order["products"].length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductInfo(product: widget.order["products"][index]["product"],)));
                        },
                        child: Card(
                          child: Container(
                              height: MediaQuery.of(context).size.height/4,
                              width: MediaQuery.of(context).size.width*0.9,
                              child: Row(
                                children: [
                                  Expanded(flex:3,child: Container(
                                      child: Image.network(widget.order["products"][index]["product"]["images"][0],fit: BoxFit.contain,)),),
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
                                                Text(widget.order["products"][index]["product"]["name"],style: TextStyle(
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
                                                Text(widget.order["products"][index]["product"]["category"],style: TextStyle(
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
                                                Text(widget.order["products"][index]["product"]["price"].toString(),style: TextStyle(
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
                                                Text(widget.order["products"][index]["size"].toString(),style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                                SizedBox(width: 10,),
                                                Text("المقاس المختار",style: TextStyle(
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
                                                Text(widget.order["products"][index]["color"],style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                                SizedBox(width: 10,),
                                                Text("اللون المختار",style: TextStyle(
                                                    color: Colors.orange,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:MainAxisAlignment.end,
                                              children: [
                                                Text(widget.order["products"][index]["quantity"].toString(),style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                                SizedBox(width: 10,),
                                                Text("عدد القطع",style: TextStyle(
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
                                ],
                              )
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                  Text( widget.order["phoneNumber"].toString(),style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                  SizedBox(width: 10,),
                  Text("رقم الهاتف",style: TextStyle(
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
                  Text( widget.order["flatAndBuildingNumber"].toString(),style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                  SizedBox(width: 10,),
                  Text("رقم الشقه والعماره",style: TextStyle(
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
                  Text(widget.order["countrySection"].toString(),style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                  SizedBox(width: 10,),
                  Text("الحي",style: TextStyle(
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
                  Text(widget.order["streetAndRegion"].toString(),style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                  SizedBox(width: 10,),
                  Text("الشارع والمنطقة",style: TextStyle(
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
                  Text(widget.order["userName"].toString(),style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                  SizedBox(width: 10,),
                  Text("اسم العميل",style: TextStyle(
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
                  Text(widget.order["totalPrice"].toString(),style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                  SizedBox(width: 10,),
                  Text("السعر الكلي",style: TextStyle(
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
                  Text(widget.order["orderTime"].toString(),style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                  SizedBox(width: 10,),
                  Text("وقت الطلب",style: TextStyle(
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
                  Text(widget.order["userEmail"].toString(),style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                  SizedBox(width: 10,),
                  Text("البريد الألكتروني للمستخدم",style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),),
                ],
              ),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
