import 'package:flutter/material.dart';

class Vehiclecard extends StatelessWidget {
  final String name;
  final String typeVehicle;
  final String year;

  const Vehiclecard(
      {super.key,
      required this.name,
      required this.typeVehicle,
      required this.year});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        margin: const EdgeInsets.all(15),
        child: Container(
          height: 100,
          margin: const EdgeInsets.all(10),
          child: Row(
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: Image.asset(
                  "images/sport-car.png",
                  height: 30,
                  width: 30,
                ),
              
              ),
              Expanded(
                child: ListTile(
                    subtitle: Text(typeVehicle),
                    title: Text(name),
                    trailing: Text(year)),
              )
            ],
          ),
        ));
  }
}
