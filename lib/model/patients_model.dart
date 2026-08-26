 class PatientsModel {
  final String patientaname;
  final String numberPhone;
  final String gandar;
  final int age;
  final String address;

  PatientsModel({
    required this.patientaname,
    required this.numberPhone,
    required this.gandar,
    required this.age,
    required this.address,
  });

  factory PatientsModel.fromJson(jsonData) {
    return PatientsModel(
      patientaname: jsonData['patientname'],
      numberPhone: jsonData['numberphone'],
      gandar: jsonData['gander'],
      age: jsonData['age'],
      address: jsonData['address'],
    );
  }
}
