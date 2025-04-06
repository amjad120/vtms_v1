import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/components/CustomButton.dart';
import 'package:flutter_application_10/components/CustomTextField.dart';

class Updatevehicle extends StatefulWidget {
  const Updatevehicle({
    super.key,
    required this.docid,
    required this.oldvehicleName,
    required this.oldchassisNumber,
    required this.oldplateNumber,
    required this.oldcolor,
    required this.oldvehicleType,
    required this.oldcoverdDistance,
  });

  final String docid;
  final String oldvehicleName;
  final String oldchassisNumber;
  final String oldplateNumber;
  final String oldcolor;
  final String oldvehicleType;
  final String oldcoverdDistance;

  @override
  State<Updatevehicle> createState() => _UpdatevehicleState();
}

class _UpdatevehicleState extends State<Updatevehicle>
    with SingleTickerProviderStateMixin {
  TabController? tabController; // for move between pages by tab icons

  TextEditingController vehicleName = TextEditingController();
  TextEditingController chassisNumber = TextEditingController();
  TextEditingController plateNumber = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController vehicleType = TextEditingController();
  TextEditingController coverdDistance = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  CollectionReference vehicle =
      FirebaseFirestore.instance.collection('vehicle');
  bool isLoading = false;
  updateVehicle() async {
    // Call the user's CollectionReference to add a new user
    if (formState.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        await vehicle.doc(widget.docid).update({
          "id": FirebaseAuth.instance.currentUser!.uid,
          "v_name": vehicleName.text,
          "chassisNumber": chassisNumber.text,
          "plateNumber": plateNumber.text,
          "color": color.text,
          "vehicleType": vehicleType.text,
          "coverdDistance": coverdDistance.text,
        });
        Navigator.of(context).pushReplacementNamed("homepage");
      } catch (e) {
        isLoading = false;
        setState(() {});
        print("Error $e");
      }
    }
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
    vehicleName.text = widget.oldvehicleName;
    chassisNumber.text = widget.oldchassisNumber;
    plateNumber.text = widget.oldplateNumber;
    color.text = widget.oldcolor;
    vehicleType.text = widget.oldvehicleType;
    coverdDistance.text = widget.oldcoverdDistance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(("Vehicle information"),
              style: TextStyle(
                fontSize: 30,
              )),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          bottom: TabBar(
            controller: tabController,
              unselectedLabelColor: Colors.black,
              unselectedLabelStyle: TextStyle(fontSize: 15),
              labelColor: Colors.white,
              labelStyle: TextStyle(fontSize: 18),
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.car_crash),
                  text: "Vehicle Information",
                ),
                Tab(
                  icon: Icon(Icons.filter_none_sharp),
                  text: "Vehicle reports",
                ),
                Tab(
                  icon: Icon(Icons.map_outlined),
                  text: "Tracking vehicle",
                ),
              ]),
        ),
        body: TabBarView(controller: tabController, children: [
          Form(
            key: formState,
            child: isLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: EdgeInsets.all(20),
                    child: ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Vehicle Information",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            Text(
                              "Edit the following fields to update vehicle information",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Container(
                              height: 15,
                            ),
                            Text(
                              "Vehicle name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Container(
                              height: 10,
                            ),
                            CustomTextField(
                                hintText: "Vehicle Name",
                                mycontroller: vehicleName,
                                validator: (val) {
                                  if (val == "") return "Enter vehicle Name";
                                }),
                            Text(
                              "Vehicle type",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Container(
                              height: 10,
                            ),
                            CustomTextField(
                                hintText: "Vehicle Type",
                                mycontroller: vehicleType,
                                validator: (val) {
                                  if (val == "") return "Enter vehicle Type";
                                }),
                            Text(
                              "Chassis Number",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Container(
                              height: 10,
                            ),
                            CustomTextField(
                                hintText: "Chassis Number",
                                mycontroller: chassisNumber,
                                validator: (val) {
                                  if (val == "") return "Enter chassis Number";
                                }),
                            Text(
                              "Plate Number",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Container(
                              height: 10,
                            ),
                            CustomTextField(
                                hintText: "Plate Number",
                                mycontroller: plateNumber,
                                validator: (val) {
                                  if (val == "") return "Enter plate Number";
                                }),
                            Text(
                              "Color",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Container(
                              height: 10,
                            ),
                            CustomTextField(
                                hintText: "Color",
                                mycontroller: color,
                                validator: (val) {
                                  if (val == "") return "Enter color";
                                }),
                            Text(
                              "Coverd Distance",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Container(
                              height: 10,
                            ),
                            CustomTextField(
                                hintText: "Coverd Distance",
                                mycontroller: coverdDistance,
                                validator: (val) {
                                  if (val == "") return "Enter Coverd Distance";
                                }),
                            Container(
                              height: 10,
                            ),
                            Center(
                              child: CustomButton(
                                  title: "Save",
                                  onPressed: () {
                                    updateVehicle();
                                    Navigator.of(context)
                                        .pushReplacementNamed("homepage");
                                  }),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
          ),
     Container(
      child: Text("welcome to report page"),
     )   ,Container(
      child: Text("welcome to Tracking page"),
     )   ,])
        
        );
  }
}
