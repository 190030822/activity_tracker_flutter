import 'package:activity_tracker/core/constants/colors.dart';
import 'package:activity_tracker/data/models/person_model.dart';
import 'package:activity_tracker/logic/bloc/activity_bloc/activity_bloc.dart';
import 'package:activity_tracker/presentation/screens/activity_details/add_activity_screen.dart';
import 'package:activity_tracker/presentation/screens/activity_details/widgets/activity_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonActivityDetails extends StatefulWidget {

  final Person person;
  const PersonActivityDetails({super.key, required this.person});

  @override
  State<PersonActivityDetails> createState() => _PersonActivityDetailsState();
}

class _PersonActivityDetailsState extends State<PersonActivityDetails> {

  @override
  void initState() {
    super.initState();
    context.read<ActivityBloc>().add(ActivityLoadEvent(personId: widget.person.personId!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person Activity Details'),
        actions: [
          BlocBuilder<ActivityBloc, ActivityState>(
            builder: (context, state) {
              switch(state.runtimeType) {
                case ActivityLoadingState: return const SizedBox();
                default: return InkWell(
                  onTap: () {
                    if (context.read<ActivityBloc>().isActivityAdded()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Activity Already Added Today")));
                    } else {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => AddNewActivity(personId: widget.person.personId!, personName: widget.person.name,)
                        )
                      );
                    }
                  }, 
                  child: const Chip(
                    label: Text("Add Activity"),
                    avatar: Icon(Icons.add_box_outlined),
                    ),
                );
              }
            }
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProperty('Name', widget.person.name),
                      _buildProperty('Age', widget.person.age.toString()),
                      _buildProperty('Gender', widget.person.gender),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProperty('Height', '${widget.person.height} cm'),
                      _buildProperty('Weight', '${widget.person.weight} kg'),
                      _buildProperty('BMI', widget.person.bodyMassIndex.toStringAsFixed(2)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(flex : 1, child: Container(margin: const EdgeInsets.only(top: 12), child: const Text("Activites", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),))),
          Expanded(
            flex: 10,
            child: Container(
              child: BlocConsumer<ActivityBloc, ActivityState>(
                listenWhen:(previous, current) => current is ActivityListenState,
                buildWhen: (previous, current) => current is! ActivityListenState,
                listener: (context, state) {
                  switch(state.runtimeType) {
                    case ActivitySuccessState : {
                      ActivitySuccessState activitySuccessState = state as ActivitySuccessState;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(activitySuccessState.succMsg)));
                    }
                  }
                },
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case ActivityLoadingState: return const Center(child: CircularProgressIndicator());
                    case ActivityLoadedState: {
                      ActivityLoadedState activityLoadedState = state as ActivityLoadedState;
                      return ListView.builder(
                        itemCount: activityLoadedState.activities.length,
                        itemBuilder: (context, index) {
                          return ActivityCard(activity: activityLoadedState.activities.elementAt(index));
                        },
                      );
                    } 
                    case ActivityEmptyState: {
                      return const Center(child: Text("No Activities"),);
                    }
                    default: return const SizedBox();
                  }
                  
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

    Widget _buildProperty(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}