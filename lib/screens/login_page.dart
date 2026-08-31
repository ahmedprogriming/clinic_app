import 'package:clinic_app/constant.dart';

import 'package:clinic_app/helper/custom_showscanr.dart';
import 'package:clinic_app/screens/cubits/login_cubit/login_cubit.dart';
import 'package:clinic_app/screens/cubits/patients_cubit/patients_cubit.dart';
import 'package:clinic_app/screens/dashboard_page.dart';
import 'package:clinic_app/screens/ragester_page.dart';
import 'package:clinic_app/widget/custom_button.dart';
import 'package:clinic_app/widget/custom_form_textField.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  static const String id = 'LoginPage';
  String? email;

  String? password;

  bool? isLoad = false;
bool _rememberMe = false;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoad = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<PatientsCubit>(context).getpatients();
          Navigator.pushNamed(context, DashboardPage.id, arguments: email);
          isLoad = false;
        } else if (state is LoginFailure) {
          ShowSnackbar(context, state.errMessage);
          isLoad = false;
        }
      },
      builder: (context, state) {
        _rememberMe=state.rememberMe;
        return ModalProgressHUD(
          inAsyncCall: isLoad!,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        // Align everything to the right for RTL layout consistency
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // The Arabic text label
                          Text(
                            'تذكرني',
                            style: TextStyle(
                              color:
                                  kFontColor, // Matching your font color constant
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ), // Small space between text and box
                          // The styled Checkbox
                          SizedBox(
                            height: 24, // Keep it compact
                            width: 24,
                            child: Checkbox(
                              value: _rememberMe,

                              // Match design: Gold when active, subtle border when inactive
                              activeColor: gold, // Uses your gold constant
                              checkColor: cream, // Contrast color when checked
                              // Custom border styling to match input fields
                              side: const BorderSide(
                                color: Color(
                                  0xFFC1AD94,
                                ), // Matches the subtle icon color
                                width: 1.5,
                              ),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  4,
                                ), // Slightly rounded corners
                              ),

                              onChanged: (bool? newValue) {
                             
                                 context.read<LoginCubit>().selectedRemmberme(newValue!);
                               
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ), // Spacing before the main login button
                    CustomButton(
                      namebutton: 'تسجيل الدخول',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(
                            context,
                          ).LoginAuth(email!, password!);
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
      },
    );
  }
}
