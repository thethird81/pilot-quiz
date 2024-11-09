import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference questions =
      FirebaseFirestore.instance.collection("questions");

  // CREATE: add a new question

  Future<void> addQuestion(String question) {
    return questions.add({
      'question': question,
      'timestamp': Timestamp.now(),
    });
  }

  //READ: get questions from database
  Stream<QuerySnapshot> getQuestionStream() {
    final questionStream =
        questions.orderBy('timestamp', descending: true).snapshots();
    return questionStream;
  }
}
