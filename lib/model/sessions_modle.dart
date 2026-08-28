import 'package:cloud_firestore/cloud_firestore.dart';

class SessionModel {
  final String docId;
  final DocumentReference? imageID;    // حقل Reference
  final DocumentReference? patientID;  // حقل Reference
  final String state;
  final Timestamp? date;
  final String notes;
  final int numberSession;
  final String type;

  SessionModel({
    required this.docId,
    this.imageID,
    this.patientID,
    required this.state,
    this.date,
    required this.notes,
    required this.numberSession,
    required this.type,
  });

  // لتحويل المستند القادم من Firestore إلى كائن
  factory SessionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return SessionModel(
      docId: doc.id,
      imageID: data['ImageID'] as DocumentReference?,
      patientID: data['PatientID'] as DocumentReference?,
      state: data['State'] ?? '',
      date: data['date'] as Timestamp?,
      notes: data['notes'] ?? '',
      numberSession: (data['numberSession'] as num?)?.toInt() ?? 0,
      type: data['type'] ?? '',
    );
  }

  // لتحويل الكائن إلى Map عند الإرسال أو التحديث
  Map<String, dynamic> toMap() {
    return {
      'ImageID': imageID,
      'PatientID': patientID,
      'State': state,
      'date': date,
      'notes': notes,
      'numberSession': numberSession,
      'type': type,
    };
  }
}