import 'package:cloud_firestore/cloud_firestore.dart';

class SessionModel {
  final String docId;
  final List<dynamic> images;    // حقل Reference
  final DocumentReference? patientID;  // حقل Reference
  final String state;
  final Timestamp? date;
  final String? time;
  final String notes;
  final int numberSession;
  final String type;
  final String nameDoctor;
  final String? places;

  SessionModel({
    required this.docId,
    this.images=const[],
    this.patientID,
    required this.state,
    this.date,
    required this.notes,
    required this.numberSession,
    required this.type,
    required this.nameDoctor,
    this.time,
     this.places
  });

  // لتحويل المستند القادم من Firestore إلى كائن
  factory SessionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
// معالجة الصور سواء كانت مصفوفة جديدة أو مرجع قديم منفرد
   List<dynamic> parsedImages = [];
    if (data['images'] is List) {
      // الاحتفاظ بجميع العناصر سواء كانت DocumentReference أو String
      parsedImages = List<dynamic>.from(data['images']);
    } else if (data['imageID'] is DocumentReference) {
      parsedImages = [data['imageID']];
    } else if (data['ImageID'] is DocumentReference) {
      parsedImages = [data['ImageID']];
    }
    return SessionModel(
      docId: doc.id,
      images: parsedImages,
      patientID: data['patientID'] as DocumentReference?,
      state: data['state'] ?? '',
      date: data['date'] as Timestamp?,
      notes: data['notes'] ?? '',
      numberSession: (data['numberSession'] as num?)?.toInt() ?? 0,
      type: data['type'] ?? '',
      nameDoctor: data['doctorName'],
     time: data['time'],
     places: data['places'],
    );
  }

  // لتحويل الكائن إلى Map عند الإرسال أو التحديث
  Map<String, dynamic> toMap() {
    return {
      'images': images,
      'PatientID': patientID,
      'State': state,
      'date': date,
      'notes': notes,
      'numberSession': numberSession,
      'type': type,
    };
  }
}