import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_ascent/constants.dart';

class Api {
  final Firestore _db = Firestore.instance;
  CollectionReference ref;

  Api() {
    ref = _db.collection("tasks");
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  Future<QuerySnapshot> getTaskDataCollectionForUser(String userId) {
    return ref.document(userId).collection("tasks").getDocuments();
  }

  //Filter the data stream by doc ids
  Stream<QuerySnapshot> streamDataCollection(List<String> docIds) {
    return ref.where(FieldPath.documentId, whereIn: docIds).snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }

  Future<void> removeDocument(String taskId, String userId) {
    return ref.document(userId).collection("tasks").document(taskId).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  //Added this function specially for user task collection
  Future setDocument(String docId, Map data) {
    return ref.document(docId).setData(data);
  }

  Future addDocumentToUser(String userId, String taskId, Map data) {
    return ref
        .document(userId)
        .collection("tasks")
        .document(taskId)
        .setData(data);
  }

  Future<void> updateTask(Map data, String taskId, String userId) {
    return ref
        .document(userId)
        .collection("tasks")
        .document(taskId)
        .updateData(data);
  }
}
