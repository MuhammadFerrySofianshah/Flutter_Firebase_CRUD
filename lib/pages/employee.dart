import 'package:crud_firebase/services/database.dart';
import 'package:crud_firebase/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            wText('Employye', blueColor, 24, FontWeight.bold),
            wText('Firebase', orangeColor, 24, FontWeight.bold),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                _nameFormTextField(),
                wSizedBoxHeight(20),
                _ageFormTextField(),
                wSizedBoxHeight(20),
                _locationFormTextField(),
                wSizedBoxHeight(20),
                _addButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _nameFormTextField() {
    return FormBuilderTextField(
      name: "name",
      controller: nameController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          labelText: "Name"),
    );
  }

  _ageFormTextField() {
    return FormBuilderTextField(
      name: "age",
      controller: ageController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          labelText: "Age"),
    );
  }

  _locationFormTextField() {
    return FormBuilderTextField(
      name: "location",
      controller: locationController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          labelText: "Location"),
    );
  }

  ElevatedButton _addButton() {
    return ElevatedButton(
        onPressed: () async {
          // ignore: non_constant_identifier_names
          String Id = randomAlphaNumeric(10);
          Map<String, dynamic> employeeInfoMap = {
            "Name": nameController.text,
            "Age": ageController.text,
            "Id": Id,
            "Location": locationController.text,
          };
          await DatabaseKuy()
              .addEmployeeDatabaseKuy(employeeInfoMap, Id)
              .then((value) {
            Fluttertoast.showToast(
                msg: "Employee details has been upload Successfully, Broo.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          });
        },
        child: wText('ADD', orangeColor, 14, FontWeight.w500));
  }
}
