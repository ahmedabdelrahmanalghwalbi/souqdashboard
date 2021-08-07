import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Advertisment extends StatefulWidget {
  @override
  _AdvertismentState createState() => _AdvertismentState();
}

class _AdvertismentState extends State<Advertisment> {
  String vendor="";
  String vendorInformation="";
  String uploadedImageUrl="";
  bool categoryImageLoading=false;
  bool isLoading = false;
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
  createAdvertisment()async{
    setState(() {
      isLoading=true;
    });
    await FirebaseFirestore.instance.collection("Advertisments").add({
      'imageUrl':uploadedImageUrl,
      'vendorInformation':vendorInformation,
      'vendor':vendor
    }).then((value){
      print("^^^^^^^^^^^^^^^^^^^ Advertisment Added Successfully");
      setState(() {
        isLoading=false;
      });
    }).catchError((ex){
      print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Failed To Add Advertisment $ex");
      setState(() {
        isLoading=false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("أضافة أعلانات"),
        centerTitle: true,
      ),
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child:Row(
          children: [
            Expanded(child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Advertisments").snapshots(),
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
                      child: Container(
                        height: 100,
                        child: Row(
                          children: [
                            Expanded(flex:3,child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:NetworkImage(data['imageUrl']),
                                  fit: BoxFit.contain
                                )
                              ),
                            )),
                            Expanded(flex:5,child: Container(
                              child: Column(
                                children: [
                                  Text(data["vendor"],style: TextStyle(
                                    color: Colors.orange
                                  ),),
                                  Text(data["vendorInformation"],style: TextStyle(
                                      color: Colors.orange
                                  ),),
                                ],
                              ),
                            )),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(onPressed: (){
                                    FirebaseFirestore.instance.collection("Advertisments").doc(document.id).delete();
                                  }, icon: Icon(Icons.delete,color:Colors.orange))
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    );
                  }).toList(),
                );
              },
            )),
            Expanded(child:ListView(
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 20,),
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
                          vendor=val;
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
                          vendorInformation=val;
                        });
                      },
                    ),
                  ],
                ),
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
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    uploadedImageUrl!=""&&vendorInformation!=""&&vendor!=""?createAdvertisment():print("please provide all values");
                    setState(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:vendor!=""&&vendorInformation!=""&&uploadedImageUrl!=""?Colors.blueAccent.withOpacity(.3):Colors.grey.withOpacity(.7),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    child: Center(
                        child:isLoading?CircularProgressIndicator(color: Colors.white,):Text(" أنشاء الأعلان",style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),)
                    ),
                  ),
                )

              ],
            ), )
          ],
        )

      )
    );
  }
}
