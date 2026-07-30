import 'package:clinic_app/constant.dart';
import 'package:clinic_app/widget/custom_button.dart';
import 'package:clinic_app/widget/custom_form_textField.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String id = 'LoginPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: kPrimaryColor,
      
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            //key: formKey,
            child: ListView(
              children: [
                SizedBox(height: 75),
                Image.asset('lib/assets/images/logo.png', height: 150),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "تسجيل الدخول",
                      style: TextStyle(
                        fontSize: 32,
                        color: Color(0xffAE7733),
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 75),
            
                const SizedBox(height: 20),
                CustomTextFiled(
                  hint: 'البريدالالكتروني',
                  /*onChange: (data) {
                    email = data;
                  },
                  */
                ),
                SizedBox(height: 15),
                CustomTextFiled(
              
                  hint: 'كلمة المرور',
                  /*onChange: (data) {
                    password = data;
                  },
                  */
                ),
                SizedBox(height: 30),
                CustomButton(
              namebutton: 'تسجيل الدخول',
             /* onTap: () async {
              if(formKey.currentState!.validate())
                
              {  IsLoad=true;
              setState(() {
                
              });
                 try {
                  await registerUser();
            
                 Navigator.pushNamed(context, ChatPage.id,arguments: email);
                 
                } on FirebaseAuthException catch (ex) {
                  if (ex.code == 'weak-password') {
             ShowSnackbar(context,'The password provided is too weak, please try again.');
                  
                  } else if (ex.code == 'email-already-in-use') {
             ShowSnackbar(context,'The account already exists for that email.');
                   
                  }
                   else {
             ShowSnackbar(context,ex.message ?? ex.code);
                  
                  }
                }catch(ex)
                  {
                     ShowSnackbar(context,'There was an error.');
                  }
                  IsLoad=false;

                  setState(() {
                    
                  });
              }
              }
              */
            ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ليس لديك حساب? ',
                      style: TextStyle(color: Colors.black87),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
            
                      child: Text(
                        'انشاء حساب',
                        style: TextStyle(color:Color(0xffAE7733), fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Spacer(flex: 3),
              ],
            ),
          ),
        ),
    );
  }
}