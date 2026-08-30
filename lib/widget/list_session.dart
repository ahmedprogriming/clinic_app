import 'package:clinic_app/constant.dart';
import 'package:clinic_app/helper/custom_showscanr.dart';
import 'package:clinic_app/model/sessions_modle.dart';
import 'package:clinic_app/screens/add_new_session_Page.dart';
import 'package:clinic_app/screens/cubits/edit_patient_cubit/cubit/edit_patient_cubit.dart';
import 'package:clinic_app/screens/cubits/patients_cubit/patients_cubit.dart';
import 'package:clinic_app/screens/cubits/session_cubit/cubit/sessionlist_cubit.dart';
import 'package:clinic_app/widget/add_new_session.dart';
import 'package:clinic_app/widget/custom_elevated_button.dart';
import 'package:clinic_app/widget/custom_form_textField.dart';
import 'package:clinic_app/widget/custom_records_session.dart';
import 'package:clinic_app/widget/custom_small_contaner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListSession extends StatefulWidget {
  const ListSession({super.key, required this.docId});
  final String docId;

  @override
  State<ListSession> createState() => _ListSessionState();
}

class _ListSessionState extends State<ListSession> {
  String namePatient = '';
  String phonenum = '';

  List<SessionModel> sessionsDate = [];
  @override
  void initState() {
    super.initState();

    // جلب البيانات عند فتح الشاشة
    context.read<EditPatientCubit>().getPatientData(widget.docId);
    context.read<SessionlistCubit>().getSessionsData(widget.docId);
  }

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
    return '${date.day}/ ${monthName} /${date.year}';
  }

  // تنسيق التاريخ المستخرج من Firestore
  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return 'غير محدد';

    DateTime date = timestamp.toDate();

    // مصفوفة بأسماء الأشهر العربية
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

    // تحويل نظام 24 ساعة إلى 12 ساعة مع تحديد الفترة
    int hour12 = date.hour % 12;
    if (hour12 == 0) hour12 = 12; // معالجة منتصف الليل والظهيرة

    String period = date.hour >= 12 ? 'مساءً' : 'صباحاً';
    String minute = date.minute.toString().padLeft(2, '0');

    return '$monthName ${date.day} — ${date.year} — $hour12:$minute $period';
  }

  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionlistCubit, SessionlistState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is SessionlistSuccess) {
          sessionsDate = state.sessionsList;
        }
        if (state is SessionlistFailure) {
          ShowSnackbar(context, state.erroMessage);
        }
      },
      builder: (context, state) {
        // استخراج أول جلسة حالتها "قادمة"
        final upcomingSession = sessionsDate.cast<SessionModel?>().firstWhere(
          (s) => s?.state == 'قادمة',
          orElse: () => null,
        );

        // استخراج أول جلسة حالتها "مكتملة"
        final completSession = sessionsDate.cast<SessionModel?>().firstWhere(
          (s) => s?.state == 'مكتملة',
          orElse: () => null,
        );

        final displaySessions = state is SessionlistSuccess
            ? state.filteredSessionsList
            : <SessionModel>[];
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.only(bottom: 100),
                children: [
                  const SizedBox(height: 20),
                  // ========================= // معلومات المريض // =========================
                  BlocConsumer<EditPatientCubit, EditPatientState>(
                    listener: (context, state) {
                      // TODO: implement listener

                      if (state is EditPatientDataLoaded) {
                        namePatient = state.patientData['patientname'];
                        phonenum = state.patientData['numberphone'];
                      }

                      if (state is EditPatientFialure) {
                        ShowSnackbar(context, state.erroMessage);
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state is EditPatientLoding;

                      if (isLoading && namePatient.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return Container(
                        margin: const EdgeInsets.all(15),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: gold.withOpacity(0.2)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: gold.withOpacity(0.18),
                                  child: Icon(
                                    Icons.person,
                                    color: darkGold,
                                    size: 40,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ملف المريض',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: fontc,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '$namePatient',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            size: 15,
                                            color: fontc,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            '967$phonenum+',

                                            style: TextStyle(
                                              fontSize: 12,
                                              color: fontc,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            // الشريط الموجود تحت رقم الهاتف
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: cream,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'الجلسات السابقة',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: fontc,
                                    ),
                                  ),
                                  Text(
                                    '${sessionsDate.length} جلسة',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: darkGold,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  // ========================= // آخر جلسة والجلسة القادمة // =========================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Custom_small_contaner(
                            textTop: 'آخر جلسة',
                            textbottom:
                                completSession != null &&
                                    completSession.date != null
                                ? _formatTimestampShorts(completSession.date)
                                : 'لا يوجد',
                            icon: const Icon(Icons.edit_calendar_sharp),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Custom_small_contaner(
                            textTop: 'الجلسة القادمة',
                            textbottom:
                                upcomingSession != null &&
                                    upcomingSession.date != null
                                ? _formatTimestampShorts(upcomingSession.date)
                                : 'لا توجد',
                            icon: const Icon(Icons.hourglass_empty),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // ========================= // البحث // =========================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomTextFiled(
                      hint: 'البحث في الجلسات...',
                      controller: searchController,
                      hintColor: Colors.grey,
                      fontsizehint: 16,
                      icon: Icons.search,
                      fillcolor: Colors.white,
                      bordercolor: const Color(0xffE8DECC),
                      textdecoration: TextDecoration.none,
                      onChange: (query) {
                        context.read<SessionlistCubit>().searchSessions(query);
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  // ========================= // عنوان سجل الجلسات // =========================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'سجل الجلسات',
                      style: TextStyle(
                        fontSize: 20,
                        color: darkGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ========================= // الجلسات // =========================
                  if (state is SessionlistLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (displaySessions.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'لا توجد جلسات مسجلة تطابق بحثك',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    ...displaySessions.map((session) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: RecordsSessionPatient(
                          textTop: 'الجلسة# ${session.numberSession}',
                          textbottom: '${_formatTimestamp(session.date)}',
                          state: session.state,
                        ),
                      );
                    }),
                ],
              ),

              Positioned(
                bottom: 40,
                right: 16,
                child: SizedBox(
                  width: 160,
                  height: 55,
                  child: CustomElevatedButton(
                    icon: Icons.add,
                    backgroundcolor: darkGold,
                    text: 'إضافة جلسة',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AddNewSessionPage.id,
                        arguments: widget.docId,
                      );
                    },
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
