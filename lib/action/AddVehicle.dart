import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/components/CustomButton.dart';
import 'package:flutter_application_10/components/CustomTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({super.key});

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  TextEditingController vehicleName = TextEditingController();
  TextEditingController chassisNumber = TextEditingController();
  TextEditingController plateNumber = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController vehicleType = TextEditingController();
  TextEditingController coverdDistance = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  CollectionReference vehicle = FirebaseFirestore.instance.collection('vehicle');
  bool isLoading = false;
  addVehicle() async {
    // Call the user's CollectionReference to add a new user
    if (formState.currentState!.validate()) {
      try {
         isLoading = true;
        setState(() {
          
        });
        DocumentReference result = await vehicle.add({
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
        setState(() {
          
        });
        print("Error $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(("Add vehicle"),
              style: TextStyle(
                fontSize: 30,
              )),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        body: Form(
          key: formState,
          child:isLoading == true? Center(child: CircularProgressIndicator(),): Container(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Vehicle Information",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Text(
                      "fill following fields to add vehicle",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Container(
                      height: 15,
                    ),
                    Text(
                      "Vehicle name",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                          title: "add vehicle",
                          onPressed: () {
                            addVehicle();
                            Navigator.of(context)
                                .pushReplacementNamed("homepage");
                          }),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
