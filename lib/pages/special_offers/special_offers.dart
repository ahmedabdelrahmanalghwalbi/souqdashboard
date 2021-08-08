import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SpecialOffers extends StatefulWidget {
  @override
  _SpecialOffersState createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  String productName='';
  double price=0.0;
  String description='';
  String category='';
  String subCategory='';
  List<String>productImagesUrls=[];
  int rating=5;
  List<String>productSizes=[];
  List<String>productColors=[];
  String productVendor='';
  String productVendorInformation='';
  double discount=0.0;
  String searchCategory="";
  List<dynamic> categorySection=[];
  bool categoryImageLoading=false;
  String uploadedImageUrl="";
  String singleSize="";
  String singleColor="";
  bool isLoading=false;
  Future getImage() async {
    setState(() {
      categoryImageLoading=true;
    });
    FilePickerResult result;
    result =(await FilePicker.platform.pickFiles(
        type: FileType.image
    ))!;
    if(result !=null){
      setState(() {
        categoryImageLoading=true;
      });
      Uint8List? uploadedFile =result.files.single.bytes;
      String fileName=result.files.single.name;
      firebase_storage.Reference reference=firebase_storage.FirebaseStorage.instance.ref().child(Uuid().v1());
      final firebase_storage.UploadTask uploadTask =reference.putData(uploadedFile!);
      uploadTask.whenComplete(()async{
        String imageUrl = await uploadTask.snapshot.ref.getDownloadURL();
        setState(() {
          uploadedImageUrl =imageUrl;
        });
      });
      setState(() {
        categoryImageLoading=false;
      });
    }
    setState(() {
      categoryImageLoading=false;
    });
  }

  createProduct()async{
    setState(() {
      isLoading=true;
    });
    await FirebaseFirestore.instance.collection("SpecialOffersOrders").add({
      'name':productName,
      'description':description,
      'category':category,
      'price':price,
      'subCategory':subCategory,
      'images':productImagesUrls,
      'rating':rating,
      'sizes':productSizes,
      'colors':productColors,
      'vendor':productVendor,
      'vendorInformation':productVendorInformation,
      'discount':discount
    }).then((value){
      print("^^^^^^^^^^^^^^^^^^^ the product $productName Added Successfully");
      setState(() {
        isLoading=false;
      });
    }).catchError((ex){
      print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Failed To Add product $productName $ex");
      setState(() {
        isLoading=false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("العروض الخاصة"),
      ),
      body:
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("SpecialOffersOrders").snapshots(),
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
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Image.network(data['images'][0]),
                              ),
                              tileColor: Colors.white,
                              hoverColor: Colors.orange[200],
                              title: Text(data['name']),
//                    subtitle: new Text(data['company']),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  )),
              Expanded(child: Container(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    //product name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('أدخل أسم المنتج',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'cairo',
                            color: Colors.orange
                        ),),
                        SizedBox(height: 5,),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: " أسم المنتج",
                              hintStyle: TextStyle(
                                  color: Colors.black
                              ),
                              fillColor: Colors.orange[200],
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange
                                  )
                              )
                          ),
                          onChanged: (val){
                            setState(() {
                              productName=val;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    //product price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('أدخل سعر المنتج',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'cairo',
                            color: Colors.orange
                        ),),
                        SizedBox(height: 5,),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: " أدخل السعر ",
                              hintStyle: TextStyle(
                                  color: Colors.black
                              ),
                              fillColor: Colors.orange[200],
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange
                                  )
                              )
                          ),
                          onChanged: (val){
                            setState(() {
                              price=double.parse(val);
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    //product description
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('أدخل وصف المنتج',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'cairo',
                            color: Colors.orange
                        ),),
                        SizedBox(height: 5,),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: " أدخل الوصف ",
                              hintStyle: TextStyle(
                                  color: Colors.black
                              ),
                              fillColor: Colors.orange[200],
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange
                                  )
                              )
                          ),
                          onChanged: (val){
                            setState(() {
                              description=val;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    //product Category
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('أدخل فئة المنتج',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'cairo',
                            color: Colors.orange
                        ),),
                        SizedBox(height: 5,),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: " أدخل الفئة ",
                              hintStyle: TextStyle(
                                  color: Colors.black
                              ),
                              fillColor: Colors.orange[200],
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange
                                  )
                              )
                          ),
                          onChanged: (val){
                            setState(() {
                              searchCategory=val;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    //product subCategory
                    Container(
                      padding: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height/4,
                      color: Colors.white,
                      child:  StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection("Category").snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Center(child: Text('Something went wrong'));
                          }

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: Text("Loading"));
                          }
                          return ListView(
                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                              if(data['name'].toString().contains(searchCategory)){
                                return Card(
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        category=data["name"];
                                        categorySection=data["subCategories"];
                                      });
                                      print(data["subCategories"].toString());
                                      print("this is category sectiond ${categorySection}");
                                      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
                                    },
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        child: Image.network(data['imageUrl']),
                                      ),
                                      tileColor: Colors.white,
                                      hoverColor: Colors.orange[200],
                                      title: Text(data['name']),
                                    ),
                                  ),
                                );
                              }else{
                                return Container();
                              }
                            }).toList(),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30,),
                    //section in selected category
                    Container(
                      padding: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height/4,
                      color: Colors.white,
                      child: categorySection.length==0?Center(
                        child: Text("لا يوجد اقسام بداخل تلك الفئة",style: TextStyle(
                            color: Colors.black
                        ),textAlign: TextAlign.center,),
                      ):ListView.builder(itemBuilder: (context,index){
                        return ListTile(
                          onTap: (){
                            setState(() {
                              subCategory=categorySection[index]["title"];
                              print(categorySection[index]["title"]);
                            });
                          },
                          title: Text(categorySection[index]["title"]),
                          leading: CircleAvatar(
                            child: Image.network(categorySection[index]["image"]),
                          ),
                        );
                      },itemCount: categorySection.length,),
                    ),
                    SizedBox(height: 30,),
                    //Images of the Product
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      height: 300,
                      color: Colors.orange[200],
                        child: Row(
                          children: [
                            Expanded(child:productImagesUrls.length!=0?Container(
                              color:Colors.white,
                              child: ListView.builder(itemBuilder: (context,index){
                                return Container(
                                  height: 100,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          image: NetworkImage(productImagesUrls[index]),
                                          fit: BoxFit.contain
                                      )
                                  ),
                                );
                              },itemCount: productImagesUrls.length,),
                            ):Container(
                              margin: EdgeInsets.only(right: 15),
                              color: Colors.orange[200],
                              child: Center(
                                child: Text("لا يوجد صور",style: TextStyle(
                                    color: Colors.black
                                ),),
                              ),
                            ),),
                            Expanded(child:Container(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('أختار الصورة',style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'cairo',
                                    color: Colors.orange
                                ),),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top:30.0,bottom: 30,left: 20,right: 20),
                                    child:GestureDetector(
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: uploadedImageUrl == ""? Colors.orange:Colors.lightGreenAccent,
                                          borderRadius: BorderRadius.circular(10),
//                            border: Border.all(color: Colors.blueAccent),
                                        ),
                                        child: Column(
                                          children: [
                                            categoryImageLoading?Center(child: CircularProgressIndicator(color: Colors.white,),):Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Icon(Icons.camera_alt,color: Colors.white,),
                                                SizedBox(width: 10,),
                                                Text('أختار صورة',style: TextStyle(
                                                    fontFamily: "cairo",
                                                    fontWeight: FontWeight.bold
                                                ),),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: ()async{
                                        try{
                                          getImage();
                                        }catch(ex){
                                          print("^^^^^^^^^^^^^^^^^^^^^^ exception in uploading image ${ex}");
                                        }
                                      },
                                    )
                                ),
                                ElevatedButton(style:ElevatedButton.styleFrom(
                                    shadowColor: Colors.orange[100],
                                    primary: Colors.orange
                                ),onPressed: (){
                                  if(uploadedImageUrl !=""){
                                    setState(() {
                                      productImagesUrls.add(uploadedImageUrl);
                                      uploadedImageUrl="";
                                      print(uploadedImageUrl.toString());
                                    });
                                  }
                                }, child: Text('حفظ الصورة',textAlign: TextAlign.center,style: TextStyle(
                                    color: Colors.black
                                ),),),
                              ],
                            ),))
                          ],
                        ),
                    ),
                    SizedBox(height: 30,),
                    // rating the product
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('أدخل التقيم',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'cairo',
                            color: Colors.orange
                        ),),
                        SizedBox(height: 5,),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: " أدخل التقيم ",
                              hintStyle: TextStyle(
                                  color: Colors.black
                              ),
                              fillColor: Colors.orange[200],
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange
                                  )
                              )
                          ),
                          onChanged: (val){
                            setState(() {
                              rating=int.parse(val);
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    //sizes of the Product
                   Container(
                      margin: EdgeInsets.only(right: 15),
                      padding: EdgeInsets.all(10),
                      height: 300,
                        child: Row(
                          children: [
                            Expanded(child:productSizes.length!=0?Container(
                              color:Colors.white,
                              child: ListView.builder(itemBuilder: (context,index){
                                return ListTile(
                                  leading: CircleAvatar(
                                    child: Center(child: Text(index.toString(),textAlign: TextAlign.center,)),
                                  ),
                                  title: Text(productSizes[index].toString()),
                                );
                              },itemCount: productSizes.length,),
                            ):Container(
                              margin: EdgeInsets.only(right: 15),
                              color: Colors.orange[200],
                              child: Center(
                                child: Text("لا يوجد مقاسات",style: TextStyle(
                                    color: Colors.black
                                ),),
                              ),
                            ),),
                            Expanded(child:Container(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('أدخل المقاس',style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'cairo',
                                        color: Colors.orange
                                    ),),
                                    SizedBox(height: 5,),
                                    TextFormField(
                                      decoration: InputDecoration(
                                          hintText: " أسم المقاس",
                                          hintStyle: TextStyle(
                                              color: Colors.black
                                          ),
                                          fillColor: Colors.orange[200],
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.orange
                                              )
                                          )
                                      ),
                                      onChanged: (val){
                                        setState(() {
                                          singleSize=val;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30,),
                                ElevatedButton(style:ElevatedButton.styleFrom(
                                    shadowColor: Colors.orange[100],
                                    primary: Colors.orange
                                ),onPressed: (){
                                  if(singleSize !=""){
                                    setState(() {
                                      productSizes.add(singleSize);
                                      singleSize="";
                                      print(singleSize.toString());
                                    });
                                  }
                                }, child: Text('حفظ المقاس',textAlign: TextAlign.center,style: TextStyle(
                                    color: Colors.black
                                ),),),
                              ],
                            ),))
                          ],
                        ),
                    ),
                    SizedBox(height: 30,),
                    //colors of the Product
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      padding: EdgeInsets.all(10),
                      height: 300,
                        child: Row(
                          children: [
                            Expanded(child:productColors.length!=0?Container(
                              color:Colors.white,
                              child: ListView.builder(itemBuilder: (context,index){
                                return ListTile(
                                  leading: CircleAvatar(
                                    child: Center(child: Text(index.toString(),textAlign: TextAlign.center,)),
                                  ),
                                  title: Text(productColors[index].toString()),
                                );
                              },itemCount: productColors.length,),
                            ):Container(
                              margin: EdgeInsets.only(right: 15),
                              color: Colors.orange[200],
                              child: Center(
                                child: Text("لا يوجد ألوان",style: TextStyle(
                                    color: Colors.black
                                ),),
                              ),
                            ),),
                            Expanded(child:Container(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('أدخل اللون',style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'cairo',
                                        color: Colors.orange
                                    ),),
                                    SizedBox(height: 5,),
                                    TextFormField(
                                      decoration: InputDecoration(
                                          hintText: " أسم اللون",
                                          hintStyle: TextStyle(
                                              color: Colors.black
                                          ),
                                          fillColor: Colors.orange[200],
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.orange
                                              )
                                          )
                                      ),
                                      onChanged: (val){
                                        setState(() {
                                          singleColor=val;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30,),
                                ElevatedButton(style:ElevatedButton.styleFrom(
                                    shadowColor: Colors.orange[100],
                                    primary: Colors.orange
                                ),onPressed: (){
                                  if(singleColor !=""){
                                    setState(() {
                                      productColors.add(singleColor);
                                      singleColor="";
                                      print(singleColor.toString());
                                    });
                                  }
                                }, child: Text('حفظ اللون',textAlign: TextAlign.center,style: TextStyle(
                                    color: Colors.black
                                ),),),
                              ],
                            ),))
                          ],
                        ),
                    ),
                    SizedBox(height: 30,),
                    //Vendor name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('أدخل أسم المورد',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'cairo',
                            color: Colors.orange
                        ),),
                        SizedBox(height: 5,),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: " أسم المورد",
                              hintStyle: TextStyle(
                                  color: Colors.black
                              ),
                              fillColor: Colors.orange[200],
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange
                                  )
                              )
                          ),
                          onChanged: (val){
                            setState(() {
                              productVendor=val;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    //vendor information
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('أدخل معلومات عن المورد',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'cairo',
                            color: Colors.orange
                        ),),
                        SizedBox(height: 5,),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: " أدخل المعلومات",
                              hintStyle: TextStyle(
                                  color: Colors.black
                              ),
                              fillColor: Colors.orange[200],
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange
                                  )
                              )
                          ),
                          onChanged: (val){
                            setState(() {
                              productVendorInformation=val;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    //product discount
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('أدخل نسبة الخصم',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'cairo',
                            color: Colors.orange
                        ),),
                        SizedBox(height: 5,),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: " أدخل النسبة ",
                              hintStyle: TextStyle(
                                  color: Colors.black
                              ),
                              fillColor: Colors.orange[200],
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orange
                                  )
                              )
                          ),
                          onChanged: (val){
                            setState(() {
                              discount=double.parse(val);
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    //submit button
                    GestureDetector(
                      onTap: (){
                        productName!=""&&
                            price!=0.0&&
                            description!=''&&
                            category!=""&&
                            subCategory!=""&&
                            productImagesUrls.length!=0&&
                            productVendor!=''&&
                            productVendorInformation!=''?createProduct():print("please provide all values");
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:productName!=""&&
                              price!=0.0&&
                              description!=''&&
                              category!=""&&
                              subCategory!=""&&
                              productImagesUrls.length!=0&&
                              productVendor!=''&&
                              productVendorInformation!=''?Colors.blueAccent.withOpacity(.3):Colors.grey.withOpacity(.7),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        padding: EdgeInsets.only(top: 10,bottom: 10),
                        child: Center(
                            child:isLoading?CircularProgressIndicator(color: Colors.white,):Text(" أنشاء الفئة",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),)
                        ),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),

    );
  }
}
