import 'package:clinic_app/Constant.dart';
import 'package:clinic_app/helper/custom_showscanr.dart';
import 'package:clinic_app/helper/selected_state.dart';
import 'package:clinic_app/screens/cubits/editSession_cubit/edit_session_cubit.dart';
import 'package:clinic_app/screens/edit_session_page.dart';
import 'package:clinic_app/widget/add_image_Item.dart';
import 'package:clinic_app/widget/custom_Appbar.dart';
import 'package:clinic_app/widget/custom_elevated_button.dart';
import 'package:clinic_app/widget/note_Item.dart';
import 'package:clinic_app/widget/session_Item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;

class DetailSession extends StatelessWidget {
  const DetailSession({super.key, required this.sessionId});
  final String sessionId;
  String _formatTimestampShorts(dynamic timestamp) {
    if (timestamp == null) return 'غير محدد';
    DateTime date = timestamp.toDate();
    const List<String> arabicMonths = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];

    String monthName = arabicMonths[date.month - 1];
    return '${date.day}/ $monthName /${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditSessionCubit, EditSessionState>(
      listener: (context, state) {
       
        if (state is EditSessionFailure) {
          showSnackbar(context, state.erroMessage);
        }
        if (state is SessionDeletedSuccess) {
          showSnackbar(context, 'تم حذف الجلسة بنجاح');
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is EditSessionLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is EditSessionLoadedData) {
          final session = state.SessionData;

          return Directionality(
            textDirection: TextDirection.rtl,
            child: ListView(
              children: [
                CustomAppbar(title: 'قائمة تفاصيل جلسة'),

                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.all(16),
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
                    borderRadius: BorderRadius.circular(25),

                    child: Column(
                      //Headres
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                          color: const Color(0xffFCF8EF),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //number session
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'الجلسة رقم',
                                    style: TextStyle(
                                      color: Color(0xffA98258),
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    '#${session!.numberSession}',
                                    style: TextStyle(
                                      color: Color(0xff3D291C),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              //State
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: selectBadgeBgColor(session.state),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: selectBadgeTextColor(
                                      session.state,
                                    ).withValues(alpha: 0.3),
                                    width: 1,
                                  ),
                                ),

                                child: Text(
                                  session.state.trim().isEmpty
                                      ? 'غير محدد'
                                      : session.state,
                                  style: TextStyle(
                                    color: selectBadgeTextColor(session.state),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Detailes Session
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
                          child: Column(
                            children: [
                              SessionItem(
                                icon: Icons.calendar_month_outlined,
                                title: 'التاريخ',
                                value: session.date != null
                                    ? intl.DateFormat(
                                        'd MMMM yyyy',
                                        'ar',
                                      ).format(session.date!.toDate())
                                    : 'غير محدد',
                              ),

                              SessionItem(
                                icon: Icons.access_time_outlined,
                                title: 'الوقت',
                                value: session.time!,
                              ),

                              SessionItem(
                                icon: Icons.medical_services_outlined,
                                title: 'نوع الجلسة',
                                value: session.type,
                              ),

                              SessionItem(
                                icon: Icons.location_on_outlined,
                                title: 'الموقع',
                                value: session.places!,
                              ),

                              SessionItem(
                                icon: Icons.person,
                                title: 'المعالج',
                                value: ' ${session.nameDoctor}',
                              ),
                            ],
                          ),
                        ),

                        // ================= BOTTOM =================
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Divider(
                            color: Color(0xffE8DCCB),
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'المريض',
                                style: TextStyle(
                                  color: Color(0xffA98258),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                state.patientName!,
                                style: TextStyle(
                                  color: Color(0xff3D291C),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt_outlined, color: fontc, size: 20),
                      const SizedBox(width: 10),

                      Text(
                        'الصور المرفقة',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                Row(
                  spacing: 5,
                  children: [
                    Expanded(
                      child: AddImageItem(
                        initialUrls: state.imageUrls,
                        isReadOnly: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                //Records notes
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(Icons.note_alt_outlined, color: fontc, size: 20),
                      const SizedBox(width: 10),

                      Text(
                        'سجل الملاحظات',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    NoteItem(
                      doctor: 'المعالج ${session.nameDoctor}',
                      date: _formatTimestampShorts(session.date),
                      note: session.notes,
                    ),

                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 160,
                          height: 55,
                          child: CustomElevatedButton(
                            icon: Icons.edit,
                            backgroundcolor: darkGold,
                            text: 'تعديل الجلسة',
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                EditSessionPage.id,
                                arguments: sessionId,
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
                            text: 'حذف الجلسة',
                            textcolor: darkGold,
                            borderColor: const Color(0xffE9D9BD),
                            iconColor: gold,
                            onPressed: () {
                              _showDeleteConfirmationDialog(context,sessionId);
                             
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          );
        }
        // Fallback widget for any other state:
        return const SizedBox.shrink();
      },
    );
  }
  void _showDeleteConfirmationDialog(BuildContext context, String sessionId) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xffE9D9BD))
          ),
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
              SizedBox(width: 8),
              Text(
                'تأكيد الحذف',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3D291C),
                ),
              ),
            ],),
            content: const Text(
            'هل أنت متأكد من حذف هذه الجلسة؟ لا يمكن التراجع عن هذا الإجراء.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ), 
          actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'إلغاء',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton
            (
                style:ElevatedButton.styleFrom(backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,),
                onPressed: () {
                Navigator.pop(dialogContext); // Close dialog
                context.read<EditSessionCubit>().deleteSession(
                      sessionId: sessionId,
                    );
              },
              child: const Text(
                'نعم',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            
          ],
        ),
      );
    },
  );
}
}
