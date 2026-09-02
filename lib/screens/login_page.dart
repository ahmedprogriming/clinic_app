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

class LoginPage extends StatefulWidget {
  static const String id = 'LoginPage';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  bool _rememberMe = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkSavedData();
  }

  Future<void> _checkSavedData() async {
    final data = await context.read<LoginCubit>().loadSavedCredentials();
    if (data['rememberMe'] == true && (data['email'] ?? '').isNotEmpty) {
      emailController.text = data['email'];
      email = data['email'];
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          BlocProvider.of<PatientsCubit>(context).getpatients();
          Navigator.pushReplacementNamed(
            context,
            DashboardPage.id,
            arguments: emailController.text.trim(),
          );
        } else if (state is LoginFailure) {
          showSnackbar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        _rememberMe = state.rememberMe;
        final bool isLoading = state is LoginLoading;

        return Scaffold(
          backgroundColor: kPrimaryColor,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // شعار العيادة داخل دائرة بتأثير ناعم
                          Center(
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(
                                  0xffFDF9F1,
                                ), // نفس لون خلفية الشعار بالضبط
                                boxShadow: [
                                  BoxShadow(
                                    color: gold.withValues(alpha: 0.15),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Transform.scale(
                                  scale:
                                      1.6, // تكبير الشعار الداخلي لملء الفراغ المربع وقص الأطراف الزائدة
                                  child: Image.asset(
                                    'lib/assets/icons/clinic_logo5.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // العناوين
                          const Text(
                            "مرحباً بك مجدداً",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff211A16),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "سجّل الدخول لمتابعة إدارة جلسات العيادة",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: fontc),
                          ),
                          const SizedBox(height: 32),

                          // حاوية الحقول
                          Container(
                            padding: const EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                CustomTextFiled(
                                  hint: 'البريد الإلكتروني',
                                  controller: emailController,
                                   prefixIcon: Icons.email_outlined,
                                  onChange: (data) => email = data,
                                ),
                                const SizedBox(height: 16),
                                CustomTextFiled(
                                  showPasswordIcon: true,
                                  controller: passwordController,
                                  obsecureText: true,
                                  hint: 'كلمة المرور',
                                  prefixIcon: Icons.lock_outline_rounded,
                                  onChange: (data) => password = data,
                                ),
                                const SizedBox(height: 14),

                                // تذكرني
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: Checkbox(
                                              value: _rememberMe,
                                              activeColor: gold,
                                              checkColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              side: BorderSide(
                                                color: gold.withValues(
                                                  alpha: 0.7,
                                                ),
                                                width: 1.5,
                                              ),
                                              onChanged: (val) {
                                                context
                                                    .read<LoginCubit>()
                                                    .toggleRememberMe(
                                                      val ?? false,
                                                    );
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'تذكرني',
                                            style: TextStyle(
                                              color: fontc,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // زر الدخول
                                CustomButton(
                                  namebutton: isLoading
                                      ? 'جاري التحقق...'
                                      : 'تسجيل الدخول',
                                  buttonColor: gold,
                                  onTap: isLoading
                                      ? null
                                      : () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            BlocProvider.of<LoginCubit>(
                                              context,
                                            ).loginAuth(
                                              emailController.text.trim(),
                                              passwordController.text.trim(),
                                            );
                                          }
                                        },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 28),

                          // الانتقال لإنشاء حساب
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  RagesterPage.id,
                                ),
                                child: Text(
                                  'إنشاء حساب جديد',
                                  style: TextStyle(
                                    color: darkGold,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'ليس لديك حساب؟',
                                style: TextStyle(color: fontc, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
