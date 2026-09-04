import 'package:clinic_app/constant.dart';
import 'package:clinic_app/screens/add_new_patient_page.dart';
import 'package:clinic_app/screens/cubits/patients_cubit/patients_cubit.dart';
import 'package:clinic_app/widget/custom_Appbar.dart';
import 'package:clinic_app/widget/custom_button.dart';
import 'package:clinic_app/widget/custom_card_patients.dart';
import 'package:clinic_app/widget/customFilterBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPatients extends StatefulWidget {
  const ListPatients({super.key});

  @override
  State<ListPatients> createState() => _ListPatientsState();
}

class _ListPatientsState extends State<ListPatients> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  String? selectedCity;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 30),
      children: [
        // 1. App Bar (Scrolls with page)
        CustomAppbar(title: 'قائمة المرضى'),
        const SizedBox(height: 20),

        // 2. Search & Filter Bar (Scrolls with page)
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 4),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      context.read<PatientsCubit>().searchPatients(value);
                    },
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      hintText: 'ابحث عن اسم المريض',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xff999896),
                      ),
                      hintStyle: const TextStyle(
                        color: Color(0xff999896),
                        fontSize: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xffEBE7E4)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xffEBE7E4)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xff999896)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SizedBox(
                width: 100,
                height: 50,
                child: CustomButton(
                  buttonColor: const Color(0xffFDF9F1),
                  borderColor: selectedCity != null
                      ? const Color(0xffB2935B)
                      : const Color(0xffEBE7E4),
                  namebutton: selectedCity ?? 'فلترة',
                  icon: Icon(
                    Icons.tune,
                    size: 22,
                    color: selectedCity != null
                        ? const Color(0xffB2935B)
                        : const Color(0xff8D734B),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return FilterBottomSheet(
                          selectedCity: selectedCity,
                          onFilterApplied: (city) {
                            setState(() {
                              selectedCity = city;
                            });
                            context.read<PatientsCubit>().filterByAddress(city);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),

        // 3. Patient Cards (Scrolls together inside parent ListView)
        BlocBuilder<PatientsCubit, PatientsState>(
          builder: (context, state) {
            switch (state) {
              case PatientsInitial():
              case PatientsLoding():
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: CircularProgressIndicator(),
                  ),
                );

              case PatientsEmpty():
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // أيقونة هادئة ومعبرة
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha:0.08),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person_add_alt_1_rounded,
                            size: 64,
                            color: darkGold, // لون أزرق وقور
                          ),
                        ),
                        const SizedBox(height: 20),

                        // عنوان رئيسي
                        const Text(
                          'سجل المرضى فارغ حالياً',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // توجيه إرشادي للطبيب
                        const Text(
                          'ابدأ بتسجيل أول مريض لمتابعة جلسات الحجامة والتشخيص الطبي بسهولة.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // زر إجراء سريع (Call To Action)
                        ElevatedButton.icon(
                          onPressed: () {
                            // توجيه الطبيب إلى شاشة إضافة مريض
                            Navigator.pushNamed(context, AddNewPatientPage.id);
                          },
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text(
                            'إضافة مريض جديد',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:  const Color.fromARGB(255, 190, 144, 60), // لون ذهبي
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                );


              case PatientsSuccess():
                final patientsList = state.patientsList;

                if (patientsList.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        'لا يوجد مرضى مسجلين',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // Disables inner scrolling so parent scrolls everything
                  itemCount: patientsList.length,
                  itemBuilder: (context, index) {
                    final patient = patientsList[index];

                    return CustomCardPatients(
                      patientName: patient.patientaname,
                      age: patient.age,
                      numberphone: patient.numberPhone,
                      docId: patient.docId ?? '',
                      onTap: () {
                        // Navigate to patient sessions or edit page
                      },
                    );
                  },
                );
                case PatientsFailure():
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline_rounded,
                          size: 48,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          state.errMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 15, color: Colors.redAccent),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: () {
                            // إعادة جلب البيانات
                            context.read<PatientsCubit>().getpatients();
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('إعادة المحاولة'),
                        ),
                      ],
                    ),
                  ),
                );
            }
          },
        ),
      ],
    );
  }
}
