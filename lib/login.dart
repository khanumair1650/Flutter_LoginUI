import 'package:flutter/material.dart';
import 'package:flutter_ui/Greet.dart';
import 'package:flutter_ui/InputDeco_design.dart';
import 'package:flutter_ui/index.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String name,email,phone;
  bool is_Hidden =true;

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
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 15,left: 10,right: 10),
                    child: TextFormField(
                      obscureText:is_Hidden,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>Greet()),
                            );
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