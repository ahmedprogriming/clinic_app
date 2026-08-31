import 'package:clinic_app/model/patients_model.dart';
import 'package:clinic_app/screens/cubits/patients_cubit/patients_cubit.dart';
import 'package:clinic_app/widget/custom_Appbar.dart';
import 'package:clinic_app/widget/custom_button.dart';
import 'package:clinic_app/widget/custom_card_patients.dart';
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
                      prefixIcon: const Icon(Icons.search, color: Color(0xff999896)),
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
                  borderColor: const Color(0xffEBE7E4),
                  namebutton: 'فلترة',
                  icon: const Icon(Icons.tune, size: 24, color: Color(0xff8D734B)),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.people),
                                title: const Text('الكل'),
                                onTap: () {
                                  context.read<PatientsCubit>().filterByGender(null);
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.male),
                                title: const Text('ذكر'),
                                onTap: () {
                                  context.read<PatientsCubit>().filterByGender('ذكر');
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.female),
                                title: const Text('أنثى'),
                                onTap: () {
                                  context.read<PatientsCubit>().filterByGender('أنثى');
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
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

              case PatientsFailure():
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      state.errMessage,
                      style: const TextStyle(fontSize: 16, color: Colors.red),
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
                  physics: const NeverScrollableScrollPhysics(), // Disables inner scrolling so parent scrolls everything
                  itemCount: patientsList.length,
                  itemBuilder: (context, index) {
                    final patient = patientsList[index];

                    return CustomCardPatients(
                      patientName: patient.patientaname ?? '',
                      age: patient.age ?? 0,
                      numberphone: patient.numberPhone ?? '',
                      docId: patient.docId ?? '',
                      onTap: () {
                        // Navigate to patient sessions or edit page
                      },
                    );
                  },
                );
            }
          },
        ),
      ],
    );
  }
}