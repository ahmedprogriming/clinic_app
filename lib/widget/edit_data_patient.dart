import 'package:clinic_app/constant.dart';
import 'package:clinic_app/helper/custom_showscanr.dart';
import 'package:clinic_app/screens/cubits/edit_patient_cubit/cubit/edit_patient_cubit.dart';
import 'package:clinic_app/widget/custom_Appbar.dart';
import 'package:clinic_app/widget/custom_form_textField.dart';
import 'package:clinic_app/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPatient extends StatefulWidget {
  const EditPatient({super.key, required this.docId});
  final String docId;
  @override
  State<EditPatient> createState() => _EditPatientState();
}

class _EditPatientState extends State<EditPatient> {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;
  late final TextEditingController ageController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    ageController = TextEditingController();

    // جلب البيانات عند فتح الشاشة
    context.read<EditPatientCubit>().getPatientData(widget.docId);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    ageController.dispose();
    super.dispose();
  }

  final items = ['ذكر', 'أنثى'];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditPatientCubit, EditPatientState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is EditPatientDataLoaded) {
          // تعبئة الحقول عند نجاح جلب البيانات
          nameController.text = state.patientData['patientname'] ?? '';
          phoneController.text = state.patientData['numberphone'] ?? '';
          addressController.text = state.patientData['address'] ?? '';
          ageController.text = state.patientData['age']?.toString() ?? '';
        }
        if (state is EditPatientSuccess) {
          ShowSnackbar(context, 'تمت التعديل المريض بنجاح');

          nameController.clear();
          phoneController.clear();
          ageController.clear();
          addressController.clear();

          context.read<EditPatientCubit>().clearGender();

          // تم نقل الإغلاق إلى هنا بعد النجاح الفعلّي
          Navigator.pop(context);
        }

        if (state is EditPatientFialure) {
          ShowSnackbar(context, state.erroMessage);
        }
      },
      builder: (context, state) {
        final isLoading = state is EditPatientLoding;

        if (isLoading && nameController.text.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppbar(title: 'قائمة تعديل بيانات المريض'),

                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: 350,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(
                            0,
                            0.1,
                          ), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 15,
                      children: [
                        const CustomText(text: 'الأسم الكامل*'),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: CustomTextFiled(
                            height: 55,
                            width: 310,
                            hint: 'أدخل الأسم الكامل',
                            hintColor: Colors.grey,
                            textdecoration: TextDecoration.none,
                            bordercolor: Color(0xffEBE7E4),
                            icon: Icons.person,
                            controller: nameController,
                          ),
                        ),
                        const CustomText(text: 'رقم الهاتف*'),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: CustomTextFiled(
                            height: 55,
                            width: 310,
                            hint: 'أدخل رقم الهاتف',
                            hintColor: Colors.grey,
                            textdecoration: TextDecoration.none,
                            bordercolor: Color(0xffEBE7E4),
                            icon: Icons.phone,
                            controller: phoneController,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            CustomText(text: 'العمر*'),
                            CustomText(text: 'الجنس*'),
                          ],
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 150,
                                height: 55,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color(0xffEBE7E4),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: state.selectedGender,
                                    hint: const Text(
                                      ' اختر الجنس',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    isExpanded: true,
                                    iconSize: 25,
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xffC1AD94),
                                    ),
                                    items: items.map(buildMenuItem).toList(),
                                    onChanged: (value) {
                                      context
                                          .read<EditPatientCubit>()
                                          .changeGender(value);
                                    },
                                  ),
                                ),
                              ),
                              CustomTextFiled(
                                hint: 'أدخل العمر',
                                height: 55,
                                width: 150,
                                hintColor: Colors.grey,
                                textdecoration: TextDecoration.none,
                                bordercolor: Color(0xffEBE7E4),
                                icon: Icons.calendar_month,
                                controller: ageController,
                              ),
                            ],
                          ),
                        ),
                        const CustomText(text: 'العنوان*'),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: CustomTextFiled(
                            hint: 'أدخل العنوان',
                            height: 55,
                            width: 350,
                            hintColor: Colors.grey,
                            textdecoration: TextDecoration.none,
                            bordercolor: Color(0xffEBE7E4),
                            icon: Icons.add_to_home_screen_sharp,
                            controller: addressController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 150),
                  Container(
                    padding: const EdgeInsets.all(16),
                    height: 80,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(
                            0,
                            0.1,
                          ), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      spacing: 15,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  // Handle button press
                                  final name = nameController.text.trim();
                                  final phone = phoneController.text.trim();
                                  final agetxt = ageController.text.trim();
                                  final address = addressController.text.trim();
                                  final gender = state.selectedGender;

                                  if (name.isEmpty ||
                                      phone.isEmpty ||
                                      agetxt.isEmpty ||
                                      address.isEmpty ||
                                      gender == null) {
                                    ShowSnackbar(
                                      context,
                                      'يرجى ملء جميع الحقول',
                                    );

                                    return;
                                  }
                                  final parsedAge = int.tryParse(agetxt);

                                  if (parsedAge == null) {
                                    ShowSnackbar(
                                      context,
                                      'العمر يجب أن يكون رقمًا',
                                    );
                                    return;
                                  }

                                  context.read<EditPatientCubit>().editPatient(
                                    docId: widget.docId,
                                    patientname: name,
                                    numberphone: phone,
                                    address: address,
                                    gander: gender,
                                    age: parsedAge,
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffB28238),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 13,
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'تعديل',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            // Handle button press
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),

                            padding: const EdgeInsets.symmetric(
                              horizontal: 60,
                              vertical: 15,
                            ),
                          ),
                          child: const Text(
                            'الغاء',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: kFontColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );
}
