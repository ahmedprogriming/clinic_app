import 'dart:io';

import 'package:clinic_app/Constant.dart';
import 'package:clinic_app/helper/custom_showscanr.dart';
import 'package:clinic_app/screens/cubits/addSession_cubit/add_session_cubit.dart';
import 'package:clinic_app/widget/add_image_Item.dart';
import 'package:clinic_app/widget/custom_Appbar.dart';
import 'package:clinic_app/widget/custom_elevated_button.dart';
import 'package:clinic_app/widget/custom_form_textField.dart';
import 'package:clinic_app/widget/custom_selected_element.dart';
import 'package:clinic_app/widget/custom_widget_title_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewSession extends StatefulWidget {
  const AddNewSession({super.key, required this.patientID});

final String patientID;
  @override
  State<AddNewSession> createState() => _AddNewSessionState();
}

class _AddNewSessionState extends State<AddNewSession> {
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final noteController = TextEditingController();

  final nameDoctorController = TextEditingController();

  final placesController = TextEditingController();

 
  String? selectedState;
  String? selectedType;
  DateTime? selectedDate;
 List<File> _selectedImages = [];
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
    return BlocConsumer<AddSessionCubit, AddSessionState>(
      listener: (context, state) {
        
        if(state is AddSessionLoading)
        {
          selectedType=state.selectedStateSessionType;
          selectedState=state.secetedStateSessionState;
        }
         if (state is AddSessionSuccess) {
          showSnackbar(context, 'تمت إضافة الجلسة بنجاح');

          noteController.clear();
          nameDoctorController.clear();
           placesController.clear();

    dateController.clear();
    timeController.clear();
         
      // تم نقل الإغلاق إلى هنا بعد النجاح الفعلّي
      Navigator.pop(context);
        }

        if (state is AddSessionFailure) {
          showSnackbar(context, state.erroMessage);
        }

      },
      builder: (context, state) {
          final isLoading = state is AddSessionLoading;
          selectedState=state.secetedStateSessionState;
          selectedType=state.selectedStateSessionType;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: [ 
               CustomAppbar(title: 'قائمة اضافة جلسة'),

                  const SizedBox(height: 30),
              Text(
                ' جلسة جديدة',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'أدخل بيانات الجلسة العلاجية للمريض',
                  style: TextStyle(fontSize: 12, color: gold),
                ),
              ),

              Container(
                margin: const EdgeInsets.all(16),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomWidgetTitleElement(
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
                              onTap: () {
                              
context.read<AddSessionCubit>().changeSessionType('تدليك');
                              },
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: CustomSelectedElement(
                              text: 'حجامة',
                              isSelected: selectedType == 'حجامة',
                              onTap: () {
                               context.read<AddSessionCubit>().changeSessionType('حجامة');
                                
                              },
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: CustomSelectedElement(
                              text: 'حجامة و تدليك',
                              isSelected: selectedType == 'حجامة و تدليك',
                              onTap: () {
                               context.read<AddSessionCubit>().changeSessionType('حجامة و تدليك');
                          
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      CustomWidgetTitleElement(
                        icon: Icons.date_range,
                        text: 'تاريخ الجلسة',
                      ),
                      const SizedBox(height: 15),

                      CustomTextFiled(
                        bordercolor: Color(0xffE8DECC),
                        controller: dateController,
                        readonly: true,
                        hint: '02/06/2026',
                        hintColor: Colors.black,
                        icon: Icons.calendar_today,
                        fillcolor: Colors.white,

                       onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          selectedDate = pickedDate;
                          dateController.text =
                              '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
                        }
                      },
                      ),
                      const SizedBox(height: 15),
                      CustomWidgetTitleElement(
                        icon: Icons.access_time_outlined,
                        text: 'وقت الجلسة',
                      ),
                      const SizedBox(height: 15),

                      CustomTextFiled(
                        bordercolor: Color(0xffE8DECC),
                        controller: timeController,
                        readonly: true,
                        hint: '04:15:PM',
                        hintColor: Colors.black,
                        icon: Icons.access_time_outlined,
                        fillcolor: Colors.white,

                        onTap: () async {
                          final TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (pickedTime != null) {
                            timeController.text = pickedTime.format(context);
                          }
                        },
                      ),

                      const SizedBox(height: 15),
                      CustomWidgetTitleElement(
                        icon: Icons.place,
                        text: 'الموضع',
                      ),
                      const SizedBox(height: 15),
                      CustomTextFiled(
                        textdecoration: TextDecoration.none,
                        bordercolor: Color(0xffE8DECC),
                            controller: placesController,
                        hint: 'مثال: الظهر والكتفين',
                        hintColor: Colors.grey,

                        fillcolor: Colors.white,
                      ),

                      const SizedBox(height: 15),
                      CustomWidgetTitleElement(
                        icon: Icons.person,
                        text: 'المعالج',
                      ),
                      const SizedBox(height: 15),
                      CustomTextFiled(
                        textdecoration: TextDecoration.none,
                        bordercolor: Color(0xffE8DECC),
                        controller: nameDoctorController,
                        hint: 'الدكتور حسن',
                        hintColor: Colors.grey,

                        fillcolor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                height: 150,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
                            onTap: () {
                              context.read<AddSessionCubit>().changeSessionSate('مكتملة') ;
                        
                            },
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: CustomSelectedElement(
                            text: 'ملغاة',
                            isSelected: selectedState == 'ملغاة',
                            onTap: () {
                                 context.read<AddSessionCubit>().changeSessionSate('ملغاة');
                           
                            },
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: CustomSelectedElement(
                            text: 'قادمة',
                            isSelected: selectedState == 'قادمة',
                            onTap: () {
                               context.read<AddSessionCubit>().changeSessionSate('قادمة');
                           
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                height: 160,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
                        textdecoration: TextDecoration.none,
                        controller: noteController,
                        maxLines: 3,
                        hint: ' اضف ملاحظات أولية او تعليمات مابعد الجلسة...',
                        hintColor: Colors.grey,
                        fillcolor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                height: 200,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
                      text: ' الصور المرفقة',
                    ),
                    const SizedBox(height: 15),

                    Expanded(child: AddImageItem(onImagesSelected: (file) {
                          _selectedImages = file;
                        },)),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 160,
                    height: 55,
                    child: CustomElevatedButton(
                      icon: Icons.save,
                      backgroundcolor: darkGold,
                      text:isLoading ? 'جاري الحفظ...' : 'حفظ الجلسة',
                      onPressed: isLoading
                              ? null
                              : () {
                                  // Handle button press
                                  final name = nameDoctorController.text.trim();
                                  final note = noteController.text.trim();
                                  final date = selectedDate;
                                  final time = timeController.text.trim();
                                   final places = placesController.text.trim();
                                  final state = selectedState;
                                  final type=selectedType;

                                  if (name.isEmpty ||
                                      note.isEmpty ||
                                      
                                      time.isEmpty ||
                                      places.isEmpty ||
                                      state==null||
                                      type == null) {
                                    showSnackbar(
                                      context,
                                     'يرجى ملء جميع الحقول المطلوبة واختيار النوع والحالة',
                                    );

                                    return;
                                  }
                                 

                                  context.read<AddSessionCubit>().addSession(
                                    patientId: widget.patientID,
                                    time:time,
                                    date:date!,
                                    doctorName: name,
                                    places: places,
                                    notes: note,
                                    imageFiles: _selectedImages
                                  );

 
                                },
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 160,
                    height: 55,
                    child: CustomElevatedButton(
                      icon: Icons.delete,
                      backgroundcolor: Colors.white,
                      text: 'الغاء',
                      textcolor: darkGold,
                      borderColor: const Color(0xffE9D9BD),
                      iconColor: gold,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }
}
