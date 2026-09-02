import 'package:clinic_app/constant.dart';
import 'package:clinic_app/helper/custom_auth.dart';
import 'package:clinic_app/helper/custom_showscanr.dart';
import 'package:clinic_app/screens/cubits/patients_cubit/patients_cubit.dart';
import 'package:clinic_app/screens/dashboard_page.dart';
import 'package:clinic_app/screens/login_page.dart';
import 'package:clinic_app/widget/custom_button.dart';
import 'package:clinic_app/widget/custom_form_textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RagesterPage extends StatefulWidget {
  const RagesterPage({super.key});

  static String id = 'RagesterPage';

  @override
  State<RagesterPage> createState() => _RagesterPageState();
}

class _RagesterPageState extends State<RagesterPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  String? email;

  String? password;
  String? confirmPassword;
  String? username;

  bool IsLoad = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: IsLoad,
      child: Scaffold(
        backgroundColor: kPrimaryColor,

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
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
                        color: kFontColor,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                CustomTextFiled(
                  hint: 'أسم المستخدم',
                  textdecoration: TextDecoration.none,
                  onChange: (data) {
                    username = data;
                  },
                ),

                const SizedBox(height: 20),
                CustomTextFiled(
                  hint: 'البريد الالكتروني',

                  onChange: (data) {
                    email = data;
                  },
                ),
                SizedBox(height: 15),
                CustomTextFiled(
                  obsecureText: true,
                  hint: 'كلمة المرور',
                  showPasswordIcon: true,
                  onChange: (data) {
                    password = data;
                  },
                ),
                SizedBox(height: 15),
                CustomTextFiled(
                  obsecureText: true,
                  showPasswordIcon: true,
                  hint: 'تأكيد كلمة المرور',
                  onChange: (data) {
                    confirmPassword = data;
                  },
                ),
                SizedBox(height: 30),

                CustomButton(
                  namebutton: 'تسجيل ',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      IsLoad = true;
                      setState(() {});
                      if (password != confirmPassword) {
                        showSnackbar(context, 'كلمتا المرور غير متطابقتين');
                        IsLoad = false;
                        setState(() {});
                        return;
                      }
                      try {
                        await regesterUser(email!, password!, username!);
                        BlocProvider.of<PatientsCubit>(context).getpatients();
                        Navigator.pushNamed(
                          context,
                          DashboardPage.id,
                          arguments: email,
                        );
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'weak-password') {
                          showSnackbar(
                            context,
                            'كلمة المرور ضعيفة، يرجى اختيار كلمة مرور أقوى.',
                          );
                        } else if (ex.code == 'email-already-in-use') {
                          showSnackbar(
                            context,
                            'هذا البريد الإلكتروني مسجل بالفعل، يرجى استخدام بريد آخر.',
                          );
                        } else if (ex.code == 'invalid-email') {
                          showSnackbar(
                            context,
                            'البريد الإلكتروني غير صحيح، يرجى التأكد منه.',
                          );
                        } else if (ex.code == 'operation-not-allowed') {
                          showSnackbar(
                            context,
                            'إنشاء الحساب بهذا النوع من تسجيل الدخول غير مفعل.',
                          );
                        } else if (ex.code == 'network-request-failed') {
                          showSnackbar(
                            context,
                            'حدث خطأ في الاتصال بالإنترنت، يرجى المحاولة مرة أخرى.',
                          );
                        } else {
                          showSnackbar(context, ex.message ?? ex.code);
                        }
                      } catch (ex) {
                        showSnackbar(context, 'حدث خطأ، حاول مرة أخرى');
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
                          Navigator.pushNamed(context, LoginPage.id);
                        },
                        child: Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            color: kFontColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'هل لديك حساب بالفعل؟',

                      style: TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
                //  Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
