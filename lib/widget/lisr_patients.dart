import 'package:clinic_app/model/patients_model.dart';
import 'package:clinic_app/screens/cubits/patients_cubit/patients_cubit.dart';
import 'package:clinic_app/widget/custom_button.dart';
import 'package:clinic_app/widget/custom_card_patients.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ListPatients extends StatelessWidget {

  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
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
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'The field is required';
                      } else {
                        return null;
                      }
                    },
                    cursorColor: Colors.black,

                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      hintText: 'ابحث عن اسم المريض',
                      prefixIcon: Icon(Icons.search, color: Color(0xff999896)),

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
                  buttonColor: Color(0xffFDF9F1),
                  borderColor: Color(0xffEBE7E4),
                  namebutton: 'بحث',
                  icon: Icon(Icons.tune, size: 24, color: Color(0xff8D734B)),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.people),
                              title: const Text('الكل'),
                              onTap: () {
                                context.read<PatientsCubit>().filterByGender(
                                  null,
                                );
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.male),
                              title: const Text('ذكر'),
                              onTap: () {
                                context.read<PatientsCubit>().filterByGender(
                                  'ذكر',
                                );
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.female),
                              title: const Text('أنثى'),
                              onTap: () {
                                context.read<PatientsCubit>().filterByGender(
                                  'أنثى',
                                );
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        Expanded(
          child: BlocBuilder<PatientsCubit, PatientsState>(
            builder: (context, state) {
              switch (state) {
                case PatientsInitial():
                  return const Center(child: CircularProgressIndicator());

                case PatientsLoding():
                  return const Center(child: CircularProgressIndicator());

                case PatientsFailure():
                  return Center(child: Text(state.errMessage));

                case PatientsSuccess():
                 final patientsList = state.patientsList;

                  return ListView.builder(
                    itemCount: patientsList.length,
                    itemBuilder: (context, index) {
                      final patient = patientsList[index];

                      return CustomCardPatients(
                        patientName: patient.patientaname ?? '',
                        age: patient.age ?? 0,
                        numberphone: patient.numberPhone ?? '',
                        onTap: () {
                          print('Patient ID: ${patient.patientaname}');
                        },
                      );
                    },
                  );
              }
            },
          ),
        ),
      ],
    );
  }
}
