import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/Greet.dart';
import 'package:flutter_ui/InputDeco_design.dart';
import 'package:flutter_ui/OTP.dart';
import 'package:flutter_ui/index.dart';
import 'package:awesome_dropdown/awesome_dropdown.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String name,email,phone;
  late String _email, _password;
  final auth = FirebaseAuth.instance;

  //TextController to read text entered in text field
  TextEditingController _controller = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(

        appBar: AppBar(
        title: const Text("Register",textAlign: TextAlign.center),
    backgroundColor: Colors.transparent,
    leading: GestureDetector(
    onTap: (){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Initial()),
    );
    },
    child: const Icon(
    Icons.arrow_back
    ),
    ),
    ),

      body: Center(
        child: SingleChildScrollView(
          child: Form(
            autovalidate: true,
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:15,left: 10,right: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: buildInputDecoration(Icons.person,"Full Name"),
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                    onSaved: (value){
                      name = value!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration:buildInputDecoration(Icons.email,"Email"),
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return 'Please a Enter';
                      }
                      if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                        return 'Please a valid Email';
                      }
                      return null;
                    },
                    onSaved: (value){
                      email = value!;
                    },
                    onChanged: (value) {
                      setState(() {
                        _email = value.trim();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:buildInputDecoration(Icons.phone,"Phone No"),

                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return 'Please enter phone no ';
                      }
                      return null;
                    },
                    onSaved: (value){
                      phone = value!;
                    },controller: _controller,
                  ),
                ),


                Container(
                  child: AwesomeDropDown(

                    dropDownList:["--Select College--","Thakur College of Engineering and Technology","Veermata Jijabai Technological Institute ","Vivekanand Education Societys Institute Of Technology","Don Bosco Institute of Technology","Indian Institute of Technology"],
                    dropDownIcon:Icon(Icons.keyboard_arrow_down) ,
                    elevation: 3,
                    padding: 5,
                    dropDownOverlayBGColor: Colors.black87,
                    dropDownBGColor: Colors.blueGrey,
                  ),

                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  child: AwesomeDropDown(

                    dropDownList:["--Select Branch--","Computer","Civil","Mechanical","Electronics"],
                    dropDownIcon:Icon(Icons.keyboard_arrow_down) ,
                    elevation: 3,
                    padding: 5,
                    dropDownOverlayBGColor: Colors.black87,
                    dropDownBGColor: Colors.blueGrey,
                  ),

                ),
                const SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
                  child: TextFormField(
                    controller: password,
                    keyboardType: TextInputType.text,
                    decoration:buildInputDecoration(Icons.lock,"Password"),
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return 'Please a Enter Password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _password = value.trim();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
                  child: TextFormField(
                    controller: confirmpassword,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration:buildInputDecoration(Icons.lock,"Confirm Password"),
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return 'Please re-enter password';
                      }
                      print(password.text);
                      print(confirmpassword.text);
                      if(password.text!=confirmpassword.text){
                        return "Password does not match";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: Row(
                    children: [
                      RaisedButton(
                        color: Colors.redAccent,
                        onPressed: (){

                          if(_formkey.currentState!.validate())
                          {
                            print("successful");
                            return;
                          }else{
                            print("UnSuccessfull");
                          }
                        },

                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: BorderSide(color: Colors.blue,width: 2)
                        ),
                        textColor:Colors.white,child: Text("verify"),

                      ),
                      RaisedButton(
                        color: Colors.redAccent,
                        onPressed: (){
                          auth.createUserWithEmailAndPassword(email: _email, password: _password).then((_){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OTPScreen(_controller.text)));
                          });
                        },

                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: BorderSide(color: Colors.blue,width: 2)
                        ),
                        textColor:Colors.white,child: Text("Submit"),

                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}




