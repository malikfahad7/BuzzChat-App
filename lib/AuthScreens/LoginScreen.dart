import 'package:buzzchat/Colors.dart';
import 'package:buzzchat/Constants.dart';
import 'package:buzzchat/Toast_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'OtpScreen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String verify = "";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  var phoneController = TextEditingController();
  bool loading = false;
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
              Text('Please enter your phone number to continue', style: TextStyle(fontSize: getheight(context)*0.015),),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left : getheight(context)*0.015, right: getheight(context)*0.015, top: getheight(context)*0.035,
                      bottom: getheight(context)*0.03),

                      child: TextFormField(
                         keyboardType: TextInputType.number,
                        validator: (value){
                          if(value!.isEmpty){
                            return ('Phone number required');
                          }
                        },
                        key: ValueKey('Phone'),
                        controller: phoneController,
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
                        if(_formkey.currentState!.validate()){
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '+${phoneController.text}',
                            verificationCompleted: (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent: (String verificationId, int? resendToken) {
                              LoginScreen.verify = verificationId;
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen()));
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {},
                          ).then((value) {
                            setState(() {
                              loading = false;
                            });
                          }).onError((error, stackTrace) {
                            toastMessage(error.toString(), Colors.red);
                            setState(() {
                              loading=false;
                            });
                          });
                        }
                        else{
                          setState(() {
                            loading=false;
                            phoneController.clear();
                          });
                        }
                      },
                      child: Container(
                        height: getheight(context)*0.06,
                        width: getwidth(context)*0.8,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(getheight(context)*0.01)
                        ),
                        child: Center(
                          child: loading? CircularProgressIndicator(color: Colors.white,): Text('Send the Code', style: TextStyle(
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
}
