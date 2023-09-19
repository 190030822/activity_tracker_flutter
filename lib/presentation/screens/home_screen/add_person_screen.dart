import 'dart:math';

import 'package:activity_tracker/data/models/person_model.dart';
import 'package:activity_tracker/logic/bloc/person_bloc/person_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewPerson extends StatefulWidget {

  const AddNewPerson({super.key});

  @override
  State<AddNewPerson> createState() => _AddNewPersonState();
}

class _AddNewPersonState extends State<AddNewPerson> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(text: "");
  final TextEditingController _ageController = TextEditingController(text: "");
  final TextEditingController _genderController = TextEditingController(text: "Male");
  final TextEditingController _heightController = TextEditingController(text: "");
  final TextEditingController _weightController = TextEditingController(text: "");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Person"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: MediaQuery.of(context).size.height-200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "UserName",
                    hintText: "Enter your Username"
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your Name";
                    } else  if (value.length <= 4) {
                        return "name should be greater than 4 characters";
                    } else {
                      return null;
                    } 
                  },
                ),
                TextFormField(
                  controller: _ageController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: "Age",
                    hintText: "Enter your age",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your age";
                    } else  if (double.parse(value) < 5) {
                        return "age should be greater than 5";
                    } else if (double.parse(value) > 100){
                      return "age should be less than 101";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 40,
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: RadioListTile<String>(
                            title: const Text('Male'),
                            value: 'Male',
                            groupValue: _genderController.text,
                            onChanged: (value) {
                              setState(() {
                                _genderController.text = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: RadioListTile<String>(
                            title: const Text('Female'),
                            value: 'Female',
                            groupValue: _genderController.text,
                            onChanged: (value) {
                              setState(() {
                                _genderController.text = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _heightController,
                  decoration: const InputDecoration(
                    labelText: "height",
                    hintText: "Enter your height(cm)",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your height";
                    } else  if (double.parse(value) < 30) {
                        return "height should be greater than 30 cm";
                    } else if (double.parse(value) > 300){
                      return "height should be less than 300 cm";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _weightController,
                  decoration: const InputDecoration(
                    labelText: "weight",
                    hintText: "Enter your weight(kg)",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your weight";
                    } else  if (double.parse(value) < 6) {
                        return "weight should be greater than 5kg";
                    } else if (double.parse(value) > 400){
                      return "weight should be less than 200 kg";
                    } else {
                      return null;
                    }
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      double bodyMassIndex;
                      bodyMassIndex = double.parse(_weightController.text)/pow(double.parse(_heightController.text)/100, 2);
                      Person newPerson = Person(name: _nameController.text, age: int.parse(_ageController.text), gender: _genderController.text,
                        height: double.parse(_heightController.text), weight: double.parse(_weightController.text), bodyMassIndex: bodyMassIndex);
                      
                      context.read<PersonBloc>().add(PersonsAddEvent(newPerson: newPerson));
                      Navigator.pop(context);
                  }
                  },
                  child: const Text("Calculate")
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

}