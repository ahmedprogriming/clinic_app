import 'package:bloc/bloc.dart';
import 'package:clinic_app/model/patients_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'patients_state.dart';

class PatientsCubit extends Cubit<PatientsState> {
  PatientsCubit() : super(PatientsInitial());
  final Stream<QuerySnapshot> patientsDB = FirebaseFirestore.instance
      .collection('Patients')
      .snapshots();
  List<PatientsModel> patientsList = [];
  List<PatientsModel> filteredPatients = [];
  void getpatients() {
    emit(PatientsLoding());

    patientsDB.listen(
      (event) {
        patientsList.clear();
        for (var doc in event.docs) {
          patientsList.add(PatientsModel.fromJson(doc,doc.id));
        }

        if (patientsList.isEmpty) {
          emit(PatientsFailure(errMessage: 'لا توجد بيانات'));
        } else {
          emit(PatientsSuccess(patientsList: patientsList));
        }
      },
      onError: (error) {
        emit(
          PatientsFailure(
            errMessage: 'خطأ أثناء معالجة البيانات: ${error.toString()}',
          ),
        );
      },
    );
  }

  void searchPatients(String query) {
    if (query.trim().isEmpty) {
      filteredPatients = patientsList;
    } else {
      filteredPatients = patientsList.where((patient) {
        return patient.patientaname.toLowerCase().contains(
          query.trim().toLowerCase(),
        );
      }).toList();
    }

    emit(PatientsSuccess(patientsList: filteredPatients));
  }

  void filterByGender(String? gender) {
    if (gender == null) {
      filteredPatients = patientsList;
    } else {
      filteredPatients = patientsList.where((patient) {
        return patient.gandar == gender;
      }).toList();
    }

    emit(PatientsSuccess(patientsList: filteredPatients));
  }
}
