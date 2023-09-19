import 'package:activity_tracker/core/constants/colors.dart';
import 'package:activity_tracker/data/models/person_model.dart';
import 'package:activity_tracker/presentation/screens/activity_details/activity_details_screen.dart';
import 'package:flutter/material.dart';

class PersonListTile extends StatelessWidget {
  final Person person;
  const PersonListTile({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: ClipOval(
          child: Container(
            height: 40,
            width: 40,
            color: figmaLightestGrey,
            child: const Icon(Icons.account_circle, color: Colors.amber,),
          ),
        ),
        title: Text(person.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
        trailing: Text("BMI : ${person.bodyMassIndex.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        onTap: () {
          Navigator.pushNamed(context, '/personActivityDetails', arguments: person);
        },
      ),
    );
  }
}
