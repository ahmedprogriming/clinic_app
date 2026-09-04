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
import 'package:shared_preferences/shared_preferences.dart';

class RagesterPage extends StatefulWidget {
  const RagesterPage({super.key});

  static String id = 'RagesterPage';

  @override
  State<RagesterPage> createState() => _RagesterPageState();
}

class _RagesterPageState extends State<RagesterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!formKey.currentState!.validate()) return;

    if (passwordController.text != confirmPasswordController.text) {
      showSnackbar(context, 'كلمتا المرور غير متطابقتين', type: SnackBarType.error);
      return;
    }

    setState(() => isLoading = true);

    try {
      await regesterUser(
        emailController.text.trim(),
        passwordController.text.trim(),
        nameController.text.trim(),
      );
      if (!mounted) return;
      BlocProvider.of<PatientsCubit>(context).getpatients();
      Navigator.pushReplacementNamed(
        context,
        DashboardPage.id,
        arguments: emailController.text.trim(),
      );
      // حفظ حالة "is_first_time" في SharedPreferences
final prefs = await SharedPreferences.getInstance();
await prefs.setBool('is_first_time', false);
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        showSnackbar(context, 'كلمة المرور ضعيفة، يرجى اختيار كلمة مرور أقوى.', type: SnackBarType.error);
      } else if (ex.code == 'email-already-in-use') {
        showSnackbar(
          context,
          'هذا البريد الإلكتروني مسجل بالفعل، يرجى استخدام بريد آخر.',
          type: SnackBarType.error,
        );
      } else if (ex.code == 'invalid-email') {
        showSnackbar(context, 'البريد الإلكتروني غير صحيح، يرجى التأكد منه.', type: SnackBarType.error);
      } else {
        showSnackbar(context, ex.message ?? 'تعذر إكمال التسجيل', type: SnackBarType.error);
      }
    } catch (_) {
      showSnackbar(context, 'حدث خطأ، يرجى المحاولة مرة أخرى.', type: SnackBarType.error);
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // أيقونة / شعار
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
                      const SizedBox(height: 20),

                      const Text(
                        "إنشاء حساب جديد",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff211A16),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "أدخل بياناتك للانضمام لنظام إدارة العيادة",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: fontc),
                      ),
                      const SizedBox(height: 28),

                      // بطاقة الإدخال البيضاء
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
                              hint: 'اسم المستخدم',
                              controller: nameController,
                              prefixIcon: Icons.person_outline_rounded,
                            ),
                            const SizedBox(height: 14),
                            CustomTextFiled(
                              hint: 'البريد الإلكتروني',
                              controller: emailController,
                              prefixIcon: Icons.email_outlined,
                            ),
                            const SizedBox(height: 14),
                            CustomTextFiled(
                              obsecureText: true,
                              showPasswordIcon: true,
                              hint: 'كلمة المرور',
                              controller: passwordController,
                              prefixIcon: Icons.lock_outline_rounded,
                            ),
                            const SizedBox(height: 14),
                            CustomTextFiled(
                              obsecureText: true,
                              showPasswordIcon: true,
                              hint: 'تأكيد كلمة المرور',
                              controller: confirmPasswordController,
                              prefixIcon: Icons.lock_reset_rounded,
                            ),
                            const SizedBox(height: 24),

                            CustomButton(
                              namebutton: isLoading
                                  ? '...جاري إنشاء الحساب'
                                  : 'تسجيل الحساب',
                              buttonColor: gold,
                              onTap: isLoading ? null : _handleRegister,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // رابط الانتقال لتسجيل الدخول
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pushReplacementNamed(
                              context,
                              LoginPage.id,
                            ),
                            child: Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                color: darkGold,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'لديك حساب بالفعل؟',
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
  }
}
