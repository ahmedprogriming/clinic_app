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
  getpatients() {
    emit(PatientsLoding());
    try {
      patientsDB.listen((event) {
        patientsList.clear();
        for (var doc in event.docs) {
          patientsList.add(PatientsModel.fromJson(doc));
        }

        if (event.docs.isEmpty) {
          emit(PatientsFailure(errMessage: ' لا توجد بيانات'));
        } else {
          emit(PatientsSuccess(patientsList: patientsList));
        }
      });
    } on Exception catch (e) {
      emit(PatientsFailure(errMessage: ' حدث خطأ أثناء معالجة البيانات'));
    }
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
