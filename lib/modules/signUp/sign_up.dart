import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop/layout/homeLayout.dart';
import 'package:my_shop/modules/logIn/log_in.dart';
import 'package:my_shop/modules/signUp/cubit/signUpStates.dart';
import 'package:my_shop/shared/components/constance.dart';
import 'package:my_shop/shared/network/local/cache_helper.dart';
import 'cubit/signUpCubit.dart';

class SignUp extends StatelessWidget {
  var emailSignUpController = TextEditingController();
  var phoneSignUpController = TextEditingController();
  var passwordSignUpController = TextEditingController();
  var nameSignUpController = TextEditingController();
  var passwordAgainSignUpController = TextEditingController();
  var FormKey = GlobalKey<FormState>();
  Widget textOrCircular = Text("SignUp  :)",style: TextStyle(color: Colors.white,fontSize: 20),);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.teal,
        ),
      ),
      body: BlocProvider(
        create: (BuildContext context) =>SignUpCubit(),
        child: BlocConsumer<SignUpCubit,SignUpStates>(
        builder: (context,state)=>SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 25,),
                    Text("SignUp Your Free Account :)",style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                    SizedBox(height: 5,),

                    Form(
                      key: FormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameSignUpController,
                            validator: (val){
                              if(val!.isEmpty){
                                return "This field must not be empty";
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.teal,
                              ),
                              labelStyle: TextStyle(color: Colors.teal),
                              labelText: "Your Name",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.teal
                                  )
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 25,),
                          TextFormField(
                            controller: emailSignUpController,
                            validator: (val){
                              if(val!.isEmpty){
                                return "This field must not be empty";
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.teal,
                              ),
                              labelStyle: TextStyle(color: Colors.teal),
                              labelText: "Email",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.teal
                                  )
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 25,),
                          TextFormField(
                            controller: phoneSignUpController,
                            validator: (val){
                              if(val!.isEmpty){
                                return "This field must not be empty";
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Colors.teal,
                              ),
                              labelStyle: TextStyle(color: Colors.teal),
                              labelText: "Phone",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.teal
                                  )
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height: 25,),
                          TextFormField(
                            controller: passwordSignUpController,
                            validator: (val){
                              if(val!.isEmpty){
                                return "This field must not be empty";
                              }
                            },
                            obscureText: SignUpCubit.get(context).obsecureText,
                            decoration: InputDecoration(

                              prefixIcon: Icon(
                                Icons.lock_open_rounded,
                                color: Colors.teal,
                              ),
                              labelStyle: TextStyle(color: Colors.teal),
                              labelText: "Password",

                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.teal
                                  )
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 25,),
                          TextFormField(
                            controller: passwordAgainSignUpController,
                            validator: (val){
                              if(val!.isEmpty){
                                return "This field must not be empty";
                              }else if(val != passwordSignUpController.text){
                                return "The password is not the same";
                              }
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock_open_rounded,
                                color: Colors.teal,
                              ),
                              labelStyle: TextStyle(color: Colors.teal),
                              labelText: "Confirm Password",
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.white
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.teal
                                  )
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 35,),
                    MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      minWidth: 150,
                      height: 50,
                      onPressed: (){
                        if(FormKey.currentState!.validate())
                        SignUpCubit.get(context).userSignUp(
                          Password: passwordSignUpController.text,
                          Email: emailSignUpController.text,
                          phone: phoneSignUpController.text,
                          name: nameSignUpController.text);
                      },
                      child: textOrCircular,color: Colors.teal,),
                    SizedBox(height: 35,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?",style: TextStyle(fontSize: 17),),
                        TextButton(child: Text("Log In",style: TextStyle(color: Colors.teal,fontSize: 17),),onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogIn()));
                        },),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
          listener: (context,state){
          if(state is SignUpInitialState)
            textOrCircular = CircularProgressIndicator(color:Colors.white);
              else
                textOrCircular = Text("Thank you :)",style: TextStyle(color: Colors.white,fontSize: 20),);

          if(state is SignUpSuccessState){
            if(SignUpCubit.get(context).userSignUpData!.status == true){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(SignUpCubit.get(context).userSignUpData!.message),backgroundColor: Colors.green,duration: Duration(seconds: 2),));
              CacheHelper.saveData('token', SignUpCubit.get(context).userSignUpData!.data!.token);
              Token = SignUpCubit.get(context).userSignUpData!.data!.token;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeLayout()));
            }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(SignUpCubit.get(context).userSignUpData!.message),backgroundColor: Colors.red,duration: Duration(seconds: 2),));
            }
          }
          },
        ),
      ),
    );
  }
}
