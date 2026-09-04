import 'dart:io';
import 'package:clinic_app/constant.dart';
import 'package:clinic_app/helper/custom_showscanr.dart';
import 'package:clinic_app/screens/cubits/editSession_cubit/edit_session_cubit.dart';
import 'package:clinic_app/widget/add_image_Item.dart';
import 'package:clinic_app/widget/custom_Appbar.dart';
import 'package:clinic_app/widget/custom_elevated_button.dart';
import 'package:clinic_app/widget/custom_form_textField.dart';
import 'package:clinic_app/widget/custom_selected_element.dart';
import 'package:clinic_app/widget/custom_widget_title_element.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;

class EditSession extends StatefulWidget {
  const EditSession({super.key, required this.sessionId});

  final String sessionId;

  @override
  State<EditSession> createState() => _EditSessionState();
}

class _EditSessionState extends State<EditSession> {
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final noteController = TextEditingController();
  final nameDoctorController = TextEditingController();
  final placesController = TextEditingController();

  String? selectedType;
  String? selectedState;
  DateTime? selectedDateTime;

  // الاحتفاظ بقوائم الصور في الـ State
  List<dynamic> currentImageUrls = [];
  List<File> newSelectedFiles = [];
List<dynamic> originalImages = []; // قائمة لتخزين الصور الأصلية عند تحميل البيانات
  @override
  void dispose() {
    noteController.dispose();
    nameDoctorController.dispose();
    placesController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditSessionCubit, EditSessionState>(
      listener: (context, state) {
        if (state is EditSessionLoadedData) {
          final session = state.SessionData;
        

          if (session != null) {
            selectedType = session.type;
            selectedState = session.state;
            noteController.text = session.notes;
            nameDoctorController.text = session.nameDoctor;
            timeController.text = session.time ?? '';
            placesController.text = session.places ?? '';
            if (session.date != null) {
              selectedDateTime = session.date!.toDate();
              dateController.text = intl.DateFormat(
                'MM/dd/yyyy',
              ).format(selectedDateTime!);
            }
          }
        }

        if (state is SessionUpdatedSuccess) {
          showSnackbar(context, 'تم تعديل الجلسة بنجاح', type: SnackBarType.success);
          noteController.clear();
          nameDoctorController.clear();
          placesController.clear();
          dateController.clear();
          timeController.clear();
          Navigator.pop(context);
        }

        if (state is EditSessionFailure) {
          showSnackbar(context, state.erroMessage, type: SnackBarType.error);
        }
      },
      builder: (context, state) {
        final isLoading = state is EditSessionLoading;
        final isReadOnly =
            isLoading; // قفل الشاشة بالكامل للقراءة فقط عند بدء الحفظ

        if (isLoading && dateController.text.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is EditSessionLoadedData) {
          if (currentImageUrls.isEmpty && newSelectedFiles.isEmpty) {
            currentImageUrls = List<String>.from(state.imageUrls);
           originalImages =List<String>.from(state.imageUrls) ;
          }
        }

        return Directionality(
          textDirection: TextDirection.rtl,
          child: AbsorbPointer(
            absorbing:
                isReadOnly, // قفل جميع التفاعلات واللمسات في الصفحة أثناء الحفظ
            child: Opacity(
              opacity: isReadOnly
                  ? 0.7
                  : 1.0, // إعطاء مؤشر بصري بأن الصفحة في وضع المعالجة
              child: ListView(
                children: [
                  const CustomAppbar(title: 'قائمة تعديل بيانات الجلسة'),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'تعديل بيانات الجلسة',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'قم بتحديث بيانات الجلسة العلاجية للمريض',
                      style: TextStyle(fontSize: 12, color: gold),
                    ),
                  ),

                  // نوع الجلسة
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: const Color(0xffE9D9BD)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomWidgetTitleElement(
                          icon: Icons.medical_services_outlined,
                          text: 'نوع الجلسة',
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: CustomSelectedElement(
                                text: 'تدليك',
                                isSelected: selectedType == 'تدليك',
                                onTap: () =>
                                    setState(() => selectedType = 'تدليك'),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: CustomSelectedElement(
                                text: 'حجامة',
                                isSelected: selectedType == 'حجامة',
                                onTap: () =>
                                    setState(() => selectedType = 'حجامة'),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: CustomSelectedElement(
                                text: 'حجامة و تدليك',
                                isSelected: selectedType == 'حجامة و تدليك',
                                onTap: () => setState(
                                  () => selectedType = 'حجامة و تدليك',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const CustomWidgetTitleElement(
                          icon: Icons.date_range,
                          text: 'تاريخ الجلسة',
                        ),
                        const SizedBox(height: 15),
                        CustomTextFiled(
                          bordercolor: const Color(0xffE8DECC),
                          controller: dateController,
                          readonly: true,
                          hint: '02/06/2026',
                          hintColor: Colors.black,
                          icon: Icons.calendar_today,
                          fillcolor: Colors.white,
                          onTap: isReadOnly
                              ? null
                              : () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        selectedDateTime ?? DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (pickedDate != null) {
                                    setState(() {
                                      selectedDateTime = pickedDate;
                                      dateController.text = intl.DateFormat(
                                        'MM/dd/yyyy',
                                      ).format(pickedDate);
                                    });
                                  }
                                },
                        ),
                        const SizedBox(height: 15),
                        const CustomWidgetTitleElement(
                          icon: Icons.access_time_outlined,
                          text: 'وقت الجلسة',
                        ),
                        const SizedBox(height: 15),
                        CustomTextFiled(
                          bordercolor: const Color(0xffE8DECC),
                          controller: timeController,
                          readonly: true,
                          hint: '04:15:PM',
                          hintColor: Colors.black,
                          icon: Icons.access_time_outlined,
                          fillcolor: Colors.white,
                          onTap: isReadOnly
                              ? null
                              : () async {
                                  final TimeOfDay? pickedTime =
                                      await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                  if (pickedTime != null) {
                                    timeController.text = pickedTime.format(
                                      context,
                                    );
                                  }
                                },
                        ),
                        const SizedBox(height: 15),
                        const CustomWidgetTitleElement(
                          icon: Icons.place,
                          text: 'الموضع',
                        ),
                        const SizedBox(height: 15),
                        CustomTextFiled(
                          readonly: isReadOnly,
                          textdecoration: TextDecoration.none,
                          bordercolor: const Color(0xffE8DECC),
                          hint: 'مثال: الظهر والكتفين',
                          hintColor: Colors.grey,
                          controller: placesController,
                          fillcolor: Colors.white,
                        ),
                      ],
                    ),
                  ),

                  // حالة الجلسة
                  Container(
                    height: 150,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: const Color(0xffE9D9BD)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        const CustomWidgetTitleElement(
                          icon: Icons.select_all_outlined,
                          text: 'حالة الجلسة',
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: CustomSelectedElement(
                                text: 'مكتملة',
                                isSelected: selectedState == 'مكتملة',
                                onTap: () =>
                                    setState(() => selectedState = 'مكتملة'),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: CustomSelectedElement(
                                text: 'ملغاة',
                                isSelected: selectedState == 'ملغاة',
                                onTap: () =>
                                    setState(() => selectedState = 'ملغاة'),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: CustomSelectedElement(
                                text: 'قادمة',
                                isSelected: selectedState == 'قادمة',
                                onTap: () =>
                                    setState(() => selectedState = 'قادمة'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // الملاحظات
                  Container(
                    height: 160,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: const Color(0xffE9D9BD)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        const CustomWidgetTitleElement(
                          icon: Icons.edit_note_outlined,
                          text: 'اضف ملاحظات',
                        ),
                        const SizedBox(height: 15),
                        Expanded(
                          child: CustomTextFiled(
                            readonly: isReadOnly,
                            textdecoration: TextDecoration.none,
                            controller: noteController,
                            maxLines: 3,
                            hint:
                                ' اضف ملاحظات أولية او تعليمات مابعد الجلسة...',
                            hintColor: Colors.grey,
                            fillcolor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // الصور المرفقة
                  Container(
                    height: 200,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: const Color(0xffE9D9BD)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        const CustomWidgetTitleElement(
                          icon: Icons.camera,
                          text: 'الصور المرفقة',
                        ),
                        const SizedBox(height: 15),
                        Expanded(
                          child: AddImageItem(
                            isReadOnly: isReadOnly,
                            initialUrls: currentImageUrls,
                            onUrlsChanged: (updatedUrls) {
                              setState(() {
                                currentImageUrls = updatedUrls;
                              });
                            },
                            onImagesSelected: (newFiles) {
                              newSelectedFiles = newFiles;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // الأزرار
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 160,
                        height: 55,
                        child: CustomElevatedButton(
                          icon: Icons.save,
                          backgroundcolor: darkGold,
                          text: isLoading ? 'جاري الحفظ...' : 'تعديل الجلسة',
                          onPressed: isLoading
                              ? null
                              : () { final date= selectedDateTime;
                                  final type = selectedType ?? '';
                                  final state = selectedState ?? '';
                                  final notes = noteController.text;
                                  final time = timeController.text;
                                  final doctorName = nameDoctorController.text;
                                  final places = placesController.text;
                                  final images =
                                      currentImageUrls; // تمرير القائمة المتبقية بعد الحذف
                                 

                                  context
                                      .read<EditSessionCubit>()
                                      .updateSession(
                                        sessionId: widget.sessionId,
                                        date: date!,
                                        type: type,
                                        state: state,
                                        notes: notes,
                                        time: time,
                                        doctorName: doctorName,
                                        places: places,
                                        imageFiles: newSelectedFiles,
                                        currentImageUrls:images,
                                        originalImages: originalImages,
                                      );
                                },
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 160,
                        height: 55,
                        child: CustomElevatedButton(
                          icon: Icons.close,
                          backgroundcolor: Colors.white,
                          text: 'الغاء',
                          textcolor: darkGold,
                          borderColor: const Color(0xffE9D9BD),
                          iconColor: gold,
                          onPressed: isLoading
                              ? null
                              : () {
                                  Navigator.pop(context);
                                },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
