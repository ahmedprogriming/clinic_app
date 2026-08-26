import 'package:clinic_app/constant.dart';
import 'package:clinic_app/screens/cubits/patients_cubit/patients_cubit.dart';
import 'package:clinic_app/screens/patients_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // =========================
            // HEADER
            // =========================
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Color(0xffB2935B),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffB2935B).withOpacity(0.25),
                        blurRadius: 25,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.monitor_heart_outlined,
                    color: Colors.white,
                    size: 38,
                  ),
                ),

                const SizedBox(width: 12),

                // Clinic name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    Text(
                      "نظام إدارة العيادة",
                      style: TextStyle(fontSize: 14, color: fontc),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      "عيادة الحجامة والمساج",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff211A16),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 12),

                // Notification
                /*Expanded(
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.notifications_none_rounded,
                      color: Color(0xffB2935B),
                      size: 29,
                    ),
                  ),
                ),
                */
              ],
            ),

            const SizedBox(height: 45),

            // =========================
            // WELCOME
            // =========================
            Text(
              "مرحباً بك 👋",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 21,
                color: fontc,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "إدارة العيادة",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Color(0xff211A16),
              ),
            ),

            const SizedBox(height: 3),

            Text(
              "تابع المرضى والجلسات بسهولة",
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 16, color: fontc),
            ),

            const SizedBox(height: 30),

            // =========================
            // DASHBOARD CARDS
            // =========================
            Row(
              children: [
                // =====================
                // APPOINTMENTS CARD
                // =====================
                /*  Expanded(
                  child: _DashboardCard(
                    title: "المواعيد",
                    number: "8",
                    subtitle: "مواعيد اليوم",
                    icon: Icons.calendar_month_outlined,
                    backgroundColor: Colors.white,
                    iconBackgroundColor: const Color(0xffF3EBDD),
                    iconColor: Color(0xffB2935B),
                    textColor: const Color(0xff211A16),
                  ),
                ),

                const SizedBox(width: 15),
                */

                // =====================
                // PATIENTS CARD
                // =====================
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                    
                      Navigator.pushNamed(context, PatientsPage.id);
                    },
                    child: _DashboardCard(
                      title: "المرضى",
                      number: (BlocProvider.of<PatientsCubit>(
                        context,
                      ).patientsList.length).toString(),
                      numberLabel: "مريض",
                      subtitle: "إدارة بيانات المرضى",
                      icon: Icons.people_outline_rounded,
                      backgroundColor: Color(0xffB2935B),
                      iconBackgroundColor: Colors.transparent,
                      iconColor: Colors.white,
                      textColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final String number;
  final String? numberLabel;
  final String subtitle;
  final IconData icon;
  final Color backgroundColor;
  final Color iconBackgroundColor;
  final Color iconColor;
  final Color textColor;

  const _DashboardCard({
    required this.title,
    required this.number,
    this.numberLabel,
    required this.subtitle,
    required this.icon,
    required this.backgroundColor,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.arrow_back_rounded, color: iconColor, size: 26),

              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(icon, color: iconColor, size: 30),
              ),
            ],
          ),

          Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            "$number $numberLabel",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            subtitle,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 13, color: textColor.withOpacity(.75)),
          ),
        ],
      ),
    );
  }
}
