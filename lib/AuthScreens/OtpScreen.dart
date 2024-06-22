import 'package:buzzchat/AuthScreens/LoginScreen.dart';
import 'package:buzzchat/Constants.dart';
import 'package:buzzchat/Toast_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Colors.dart';
import '../HomePage.dart';
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _newKey = GlobalKey<FormState>();
  var otpController = TextEditingController();
  var nameController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;

  // Image Picker option for Bottom Sheet provided By GET...
  void ImagePickerOptions(){
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          height: getheight(context)*0.22,
          width: getwidth(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(getheight(context)*0.02), topRight: Radius.circular(getheight(context)*0.02)),
                color: Colors.white
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Text('Pic Image From'),
              //Camera Option...
              InkWell(
                onTap: (){},
                child: Container(height: getheight(context)*0.05, width: getwidth(context)*0.8,decoration: BoxDecoration(
                  color: AppColors.primary, borderRadius: BorderRadius.circular(10)
                ), child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera, color: Colors.white,),
                      SizedBox(width: 10,),
                      Text('Camera', style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),),
              ),

              //Gallery option...
              InkWell(
                onTap: (){},
                child: Container(height: getheight(context)*0.05, width: getwidth(context)*0.8,decoration: BoxDecoration(
                    color: AppColors.primary, borderRadius: BorderRadius.circular(10)
                ), child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, color: Colors.white,),
                      SizedBox(width: 10,),
                      Text('Gallery', style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),),
              ),

              //Cancel Option...
              InkWell(
                onTap: (){},
                child: Container(height: getheight(context)*0.05, width: getwidth(context)*0.8,decoration: BoxDecoration(
                    color: AppColors.primary, borderRadius: BorderRadius.circular(10)
                ), child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cancel, color: Colors.white,),
                      SizedBox(width: 10,),
                      Text('Cancel', style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),),
              ),
            ],
          ),
        ),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: getheight(context),
            width:  getwidth(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icon.jpg', height: getheight(context)*0.1,),
                Text('Phone Verification', style: TextStyle(fontWeight: FontWeight.w800, fontSize: getheight(context)*0.025),),
                Text('Please enter the 6 digit OTP Code', style: TextStyle(fontSize: getheight(context)*0.015),),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left : getheight(context)*0.1, right: getheight(context)*0.1, top: getheight(context)*0.035,
                            bottom: getheight(context)*0.03),

                        child: TextFormField(
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          validator: (value){
                            if(value!.isEmpty){
                              return ('OTP required');
                            }
                            else if(value.length!=6){
                              return ('Incomplete OTP');
                            }
                          },
                          key: ValueKey('Phone'),
                          controller: otpController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black54),
                                  borderRadius: BorderRadius.circular(getheight(context)*0.01)
                              )
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async{
                          setState(() {
                            loading=true;
                          });
                          openDialog();
                          setState(() {
                            loading = false;
                          });
    //                       if(_formkey.currentState!.validate()){
    //                         try{
    //                         PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: LoginScreen.verify, smsCode: otpController.text);
    //                         await auth.signInWithCredential(credential).then((value) {
    //                           setState(() {
    //                             loading=false;
    //                           });
    //                           openDialog();
    //                           // toastMessage('Verification Completed', Colors.lightGreen);
    //                           // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
    //                         }).onError((error, stackTrace) {
    //                           toastMessage(error.toString(), Colors.red);
    //                         });
    //                       }
    //                       catch(e){
    //                         setState(() {
    //                           loading = false;
    //                         });
    //                       }
    // }
    //                       else{
    //                         setState(() {
    //                           loading=false;
    //
    //                         });
    //                       }
                        },
                        child: Container(
                          height: getheight(context)*0.06,
                          width: getwidth(context)*0.8,
                          decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(getheight(context)*0.01)
                          ),
                          child: Center(
                            child: loading? CircularProgressIndicator(color: Colors.white,): Text('Verify Phone Number', style: TextStyle(
                                fontSize: getheight(context)*0.018, color: Colors.white
                            ),),
                          ),
                        ),
                      )
                    ],
                  ),

                ),

              ],
            )
        ),
      ),
    ));
  }
  void openDialog() => showDialog(context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
     content: Padding(
       padding:  EdgeInsets.only(top: getheight(context)*0.03),
       child: Container(
         height: getheight(context)*0.55,
         width: getwidth(context)*0.8,
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 60, // size of the avatar
                  backgroundImage: AssetImage('assets/icon.jpg'), // path to your default image
                  backgroundColor: Colors.transparent, // background color
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      ImagePickerOptions();
                    },
                    child: CircleAvatar(
                      radius: 20, // size of the camera icon circle
                      backgroundColor: AppColors.primary, // background color of the circle
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
             Padding(
               padding: EdgeInsets.only(left : getheight(context)*0.0015, right: getheight(context)*0.0015, top: getheight(context)*0.035,
                   bottom: getheight(context)*0.01),
               child: TextField(
                 maxLength: 15,
                 keyboardType: TextInputType.text,
                 controller: nameController,
                 decoration: InputDecoration(
                   label: Text('Name'),
                     enabledBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.black87),
                         borderRadius: BorderRadius.circular(getheight(context)*0.01)
                     )
                 ),
               ),
             ),

            //Continue button for Dialog Box....
            InkWell(
              onTap: (){
                if(nameController.text.isEmpty){
                  toastMessage('Field required', Colors.red);
                }
              },
              child: Container(
                height: getheight(context)*0.06,
                width: getwidth(context)*0.6,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(getheight(context)*0.01)
                ),
                child: Center(
                  child: loading? CircularProgressIndicator(color: Colors.white,): Text('Continue', style: TextStyle(
                      fontSize: getheight(context)*0.018, color: Colors.white
                  ),),
                ),
              ),
            ),

          ],
        ),
       ),
     ),
      )
  );
}
