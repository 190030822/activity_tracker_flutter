import 'package:activity_tracker/data/models/activity_model.dart';
import 'package:activity_tracker/logic/bloc/activity_bloc/activity_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class AddNewActivity extends StatefulWidget {
  final int personId;
  final String personName;
  const AddNewActivity({super.key, required this.personId, required this.personName});


  @override
  State<AddNewActivity> createState() => _AddNewActivityState();
}

class _AddNewActivityState extends State<AddNewActivity> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TimeOfDay? _wakeUpTime;
  bool _gym = false;
  bool _meditation = false;
  int _meditationMinutes = 0;
  bool _reading = false;
  int _pagesRead = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracking Daily Activity'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Lottie.asset(
                    height: 200,
                    'assets/form.json',
                    fit: BoxFit.cover,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Wake Up Time:',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _selectWakeUpTime(context);
                      },
                      child: Text(_wakeUpTime != null
                          ? _wakeUpTime!.format(context)
                          : 'Select Time'),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                CheckboxListTile(
                  title: const Text('Gym'),
                  value: _gym,
                  onChanged: (bool? value) {
                    setState(() {
                      _gym = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Meditation'),
                  value: _meditation,
                  onChanged: (bool? value) {
                    setState(() {
                      _meditation = value!;
                      if (!_meditation) {
                        _meditationMinutes = 0;
                      }
                    });
                  },
                ),
                if (_meditation)
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Minutes of Meditation',
                       border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (_meditation && (value == null || value.isEmpty)) {
                        return 'Please enter minutes of meditation';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (_meditation && value != null && value.isNotEmpty) {
                        _meditationMinutes = int.parse(value);
                      }
                    },
                  ),
                CheckboxListTile(
                  title: const Text('Reading'),
                  value: _reading,
                  onChanged: (bool? value) {
                    setState(() {
                      _reading = value!;
                      if (!_reading) {
                        _pagesRead = 0;
                      }
                    });
                  },
                ),
                if (_reading)
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'No. of Pages Read',
                      border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (_reading && (value == null || value.isEmpty)) {
                        return 'Please enter no. of pages read';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (_reading && value != null && value.isNotEmpty) {
                        _pagesRead = int.parse(value);
                      }
                    },
                  ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Activity _activity = Activity(personId: widget.personId, wakeUpTime: timeOfDayToDateTime(_wakeUpTime!), gym: _gym, meditationTime: _meditationMinutes, readingCount: _pagesRead);
                        context.read<ActivityBloc>().add(AddNewActivityEvent(activity: _activity));
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectWakeUpTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _wakeUpTime ?? TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        _wakeUpTime = selectedTime;
      });
    }
  }

  DateTime timeOfDayToDateTime(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  return DateTime(
    now.year,
    now.month,
    now.day, 
    timeOfDay.hour,
    timeOfDay.minute,
  );
}

}