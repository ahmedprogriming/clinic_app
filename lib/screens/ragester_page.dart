import 'package:clinic_app/constant.dart';
import 'package:clinic_app/widget/custom_button.dart';
import 'package:clinic_app/widget/custom_form_textField.dart';
import 'package:flutter/material.dart';

class RagesterPage extends StatelessWidget {
  const RagesterPage({super.key});

   static String id = 'RagesterPage';

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
                SizedBox(height: 40),
                Image.asset('lib/assets/images/logo.png', height: 150),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "انشاء حساب",
                      style: TextStyle(
                        fontSize: 32,
                        color:kFontColor,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                 CustomTextFiled(
                  hint: 'أسم المستخدم',
                  textdecoration: TextDecoration.none,
                  /*onChange: (data) {
                    email = data;
                  },
                  */
                ),
            
                const SizedBox(height: 20),
                CustomTextFiled(
                  hint: 'البريد الالكتروني',
                  /*onChange: (data) {
                    email = data;
                  },
                  */
                ),
                SizedBox(height: 15),
                CustomTextFiled(
                  obsecureText: true,
                  hint: 'كلمة المرور',
                  /*onChange: (data) {
                    password = data;
                  },
                  */
                ),
                  SizedBox(height: 15),
                CustomTextFiled(
                   obsecureText: true,
                  hint: 'تأكيد كلمة المرور',
                  /*onChange: (data) {
                    password = data;
                  },
                  */
                ),
                SizedBox(height: 30),
                CustomButton(
              namebutton: 'تسجيل ',
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'LoginPage');
                      },
                      child: Text(
                      'تسجيل الدخول',
                        style: TextStyle(color:kFontColor, fontWeight: FontWeight.bold ),
                      ),
                    ),
                    Text(
                       'هل لديك حساب بالفعل؟',
                     
                      style: TextStyle(color:Colors.black87),
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