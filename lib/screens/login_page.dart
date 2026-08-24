import 'package:clinic_app/constant.dart';
import 'package:clinic_app/helper/custom_auth.dart';
import 'package:clinic_app/helper/custom_showscanr.dart';
import 'package:clinic_app/screens/dashboard_page.dart';
import 'package:clinic_app/screens/ragester_page.dart';
import 'package:clinic_app/widget/custom_button.dart';
import 'package:clinic_app/widget/custom_form_textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;

  bool? IsLoad = false;

  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: IsLoad!,
      child: Scaffold(
        backgroundColor: kPrimaryColor,

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
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
                        color: kFontColor,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 75),

                const SizedBox(height: 20),
                CustomTextFiled(
                  hint: 'البريدالالكتروني',
                  onChange: (data) {
                    email = data;
                  },
                ),
                SizedBox(height: 15),
                CustomTextFiled(
                   showPasswordIcon: true,
                  obsecureText: true,
                  hint: 'كلمة المرور',
                  onChange: (data) {
                    password = data;
                  },
                ),
                SizedBox(height: 30),
                CustomButton(
                  namebutton: 'تسجيل الدخول',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      IsLoad = true;
                      setState(() {});
                      try {
                        await LoginAuth(email!, password!);

                        Navigator.pushNamed(
                          context,
                          DashboardPage.id,
                          arguments: email,
                        );
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'invalid-credential') {
                          ShowSnackbar(
                            context,
                            'البريد الإلكتروني أو كلمة المرور غير صحيحة',
                          );
                        } else if (ex.code == 'invalid-email') {
                          ShowSnackbar(context, 'البريد الإلكتروني غير صحيح');
                        } else if (ex.code == 'user-disabled') {
                          ShowSnackbar(context, 'هذا الحساب تم تعطيله');
                        } else if (ex.code == 'network-request-failed') {
                          ShowSnackbar(
                            context,
                            'حدث خطأ في الاتصال بالإنترنت، يرجى المحاولة مرة أخرى.',
                          );
                        } else {
                          ShowSnackbar(context, ex.message ?? ex.code);
                        }
                      } catch (ex) {
                        ShowSnackbar(context, 'حدث خطأ، حاول مرة أخرى');
                      }
                      IsLoad = false;

                      setState(() {});
                    }
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RagesterPage.id);
                        },

                        child: Text(
                          'انشاء حساب',
                          style: TextStyle(
                            color: kFontColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'ليس لديك حساب؟ ',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
