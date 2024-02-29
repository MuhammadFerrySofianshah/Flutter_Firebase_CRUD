import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseKuy {
  // CREATE
  Future addEmployeeDatabaseKuy(
      Map<String, dynamic> employeeInfoMap, id) async {
    return FirebaseFirestore.instance
        .collection("EmployeeKuy")
        .doc(id)
        .set(employeeInfoMap);
  }

  // READ
  Future<Stream<QuerySnapshot>> getEmployeeDatabaseKuy() async {
    return FirebaseFirestore.instance.collection("EmployeeKuy").snapshots();
  }

  // UPDATE
  Future updateEmployeeDatabaseKuy(
      String id, Map<String, dynamic> updateInfo) async {
    return FirebaseFirestore.instance
        .collection("EmployeeKuy")
        .doc(id)
        .update(updateInfo);
  }

  // DELETE
  Future deleteEmployeeDatabaseKuy(String id) async {
    return FirebaseFirestore.instance
        .collection("EmployeeKuy")
        .doc(id)
        .delete();
  }
}
