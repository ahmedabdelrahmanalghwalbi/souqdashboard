import 'dart:html';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late File image;
  String name='';
  String subCategoryTitle='';
  String uploadedSubCategoryImageUrl="";
  String description='';
  List<Map<dynamic,dynamic>>subCategories=[];
  String uploadedImageUrl="";
  bool isLoading=false;
  bool subCategoryImageLoading=false;
  bool categoryImageLoading=false;

  Future getImageSubCategory() async {
    setState(() {
      subCategoryImageLoading=true;
    });
    FilePickerResult result;
    result =(await FilePicker.platform.pickFiles(
        type: FileType.image
    ))!;
    if(result !=null){
      setState(() {
        subCategoryImageLoading=true;
      });
      Uint8List? uploadedFile =result.files.single.bytes;
      String fileName=result.files.single.name;
      firebase_storage.Reference reference=firebase_storage.FirebaseStorage.instance.ref().child(Uuid().v1());
      final firebase_storage.UploadTask uploadTask =reference.putData(uploadedFile!);
      uploadTask.whenComplete(()async{
        String imageUrl = await uploadTask.snapshot.ref.getDownloadURL();
        setState(() {
          uploadedSubCategoryImageUrl =imageUrl;
        });
      });
      setState(() {
        subCategoryImageLoading=false;
      });
    }
    setState(() {
      subCategoryImageLoading=false;
    });
  }

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
  createCategory()async{
    setState(() {
      isLoading=true;
    });
    await FirebaseFirestore.instance.collection("Category").add({
      'name':name,
      'imageUrl':uploadedImageUrl,
      'description':description,
      'subCategories':subCategories
    }).then((value){
      print("^^^^^^^^^^^^^^^^^^^ Category $name Added Successfully");
      setState(() {
        isLoading=false;
      });
    }).catchError((ex){
      print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Failed To Add Category $name $ex");
      setState(() {
        isLoading=false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category"),
        centerTitle: true,
      ),
      body: Row(
        children: [
          ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          ////////////////////////////////////////////////////////////////////////////////////////////////////
          //left part
          Expanded(child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("Category").snapshots(),
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
                        child: Image.network(data['imageUrl']),
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

          ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          ////////////////////////////////////////////////////////////////////////////////////////////////////////////
          //right part
          Expanded(child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Category title text form field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('أدخل عنوان الفئة',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'cairo',
                      color: Colors.orange
                    ),),
                    SizedBox(height: 5,),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: " أدخل العنوان ",
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
                          name=val;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                //description text Form field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('أدخل وصف الفئة',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'cairo',
                      color: Colors.orange
                    ),),
                    SizedBox(height: 5,),
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.orange[200],
                          hintText: "أدخل الوصف ",
                          hintStyle: TextStyle(
                            color: Colors.black
                          ),
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
                //select image row
                Padding(
                  padding: EdgeInsets.only(top:30.0,bottom: 30,left: 20,right: 20),
                  child: uploadedImageUrl == ""? GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.orange,
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
                      ):Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.lightGreenAccent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.lightGreenAccent),
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
                ),
                //List view of sub categories in the category
                ///////////////////////////////////////////////////////////////////
                Padding(padding: EdgeInsets.all(10),child: Container(
                  margin: EdgeInsets.only(right: 15),
                  padding: EdgeInsets.all(10),
                  height: 300,
                  child: Expanded(
                    child: Row(
                      children: [
                        Expanded(child:subCategories.length!=0?Container(
                          color:Colors.white,
                          child: ListView.builder(itemBuilder: (context,index){
                              return ListTile(title:Text(subCategories[index]["title"]),leading: CircleAvatar(
                                backgroundColor: Colors.orange[200],
                                child: Center(
                                  child: Text('$index',style: TextStyle(
                                    color: Colors.black
                                  ),),
                                ),
                              ),);
                          },itemCount: subCategories.length,),
                        ):Container(
                          margin: EdgeInsets.only(right: 15),
                          color: Colors.orange[200],
                          child: Center(
                            child: Text("لا يوجد أقسام",style: TextStyle(
                                color: Colors.black
                            ),),
                          ),
                        ),),
                        Expanded(child:Container(child: Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('أدخل عنوان القسم',style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cairo',
                                color: Colors.orange
                            ),),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.orange[200],
                                  hintText: "أدخل عنوان القسم ",
                                  hintStyle: TextStyle(
                                      color: Colors.black
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.orange
                                      )
                                  )
                              ),
                              onChanged: (val){
                                setState(() {
                                  subCategoryTitle=val;
                                });
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(top:30.0,bottom: 30,left: 20,right: 20),
                              child: uploadedSubCategoryImageUrl == ""? GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(10),
//                            border: Border.all(color: Colors.blueAccent),
                                  ),
                                  child: Column(
                                    children: [
                                      subCategoryImageLoading?Center(child: CircularProgressIndicator(color: Colors.white,),):Row(
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
                                    getImageSubCategory();
                                  }catch(ex){
                                    print("^^^^^^^^^^^^^^^^^^^^^^ exception in uploading image $ex");
                                  }
                                },
                              ):Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.lightGreenAccent,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.lightGreenAccent),
                                ),
                                child: Column(
                                  children:  [
                                    subCategoryImageLoading?Center(child: CircularProgressIndicator(color: Colors.white,),):Row(
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
                            ),
                            ElevatedButton(style:ElevatedButton.styleFrom(
                              shadowColor: Colors.orange[100],
                              primary: Colors.orange
                            ),onPressed: (){
                              if(subCategoryTitle!=""&&uploadedSubCategoryImageUrl!=""){
                                setState(() {
                                  subCategories.add({"title":subCategoryTitle,"image":uploadedSubCategoryImageUrl});
                                  uploadedSubCategoryImageUrl="";
                                  print(subCategories);
                                });
                              }
                            }, child: Text('حفظ القسم',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.black
                            ),),),
                          ],
                        ),))
                      ],
                    ),
                  ),
                ),),
                ///////////////////////////////////////////////////////////////////
                //submit button
                GestureDetector(
                  onTap: (){
                    name!=""&&description!=""&& uploadedImageUrl!=""&&subCategories.length!=0?createCategory():print("please provide all values");
                    setState(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:name!=""&&description!=""&&uploadedImageUrl!=""&&subCategories.length!=0?Colors.blueAccent.withOpacity(.3):Colors.grey.withOpacity(.7),
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
          )),
        ],
      ),
    );
  }
}
