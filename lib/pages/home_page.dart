import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/pages/employee.dart';
import 'package:crud_firebase/services/database.dart';
import 'package:crud_firebase/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<QuerySnapshot> employeeStream;
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final locationController = TextEditingController();

  //  GET
  getOnTheLoad() async {
    employeeStream = await DatabaseKuy().getEmployeeDatabaseKuy();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getOnTheLoad();
  }

  Widget allEmployeeDatabaseKuy() {
    return StreamBuilder<QuerySnapshot>(
      stream: employeeStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              wText('Name : ' + ds['Name'], orangeColor, 16,
                                  FontWeight.bold),
                                  Spacer(),
                              IconButton(
                                  onPressed: () {
                                    nameController.text = ds["Name"];
                                    ageController.text = ds["Age"];
                                    locationController.text = ds["Location"];
                                    editEmployeeDatabaseKuy(ds["Id"]);
                                  },
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () async{
                                   await DatabaseKuy().deleteEmployeeDatabaseKuy(ds["Id"]);
                                  },
                                  icon: Icon(Icons.delete))
                            ],
                          ),
                          wText('Age: ' + ds['Age'], blueColor, 16,
                              FontWeight.w500),
                          wSizedBoxHeight(10),
                          wText('Location : ' + ds['Location'], orangeColor, 16,
                              FontWeight.w500),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
        }
      },
    );
  }

  // SCAFFOLD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        child: Icon(Icons.add),
        onPressed: () => wPush(context, Employee()),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            wText('Flutter', blueColor, 24, FontWeight.bold),
            wText('Firebase', orangeColor, 24, FontWeight.bold),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(child: allEmployeeDatabaseKuy()),
            ],
          ),
        ),
      ),
    );
  }

// EDIT
  Future editEmployeeDatabaseKuy(String id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.cancel_outlined),
                      ),
                      wText('Edit', blueColor, 18, FontWeight.bold),
                      wText('Details', orangeColor, 18, FontWeight.bold),
                    ],
                  ),
                  _nameFormTextField(),
                  wSizedBoxHeight(20),
                  _ageFormTextField(),
                  wSizedBoxHeight(20),
                  _locationFormTextField(),
                  wSizedBoxHeight(20),
                  ElevatedButton(
                      onPressed: () async {
                        Map<String, dynamic> updateInfo = {
                          "Name": nameController.text,
                          "Age": ageController.text,
                          "Id": id,
                          "Location": locationController.text,
                        };
                        await DatabaseKuy()
                            .updateEmployeeDatabaseKuy(id, updateInfo)
                            .then((value) {
                          Navigator.pop(context);
                        });
                      },
                      child: wText('Update', orangeColor, 14, FontWeight.w500))
                ],
              ),
            ),
          ));
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
}
