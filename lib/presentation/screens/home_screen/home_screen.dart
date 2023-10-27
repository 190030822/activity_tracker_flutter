import 'package:activity_tracker/core/constants/colors.dart';
import 'package:activity_tracker/logic/bloc/authenticate_bloc/authenticate_bloc.dart';
import 'package:activity_tracker/logic/bloc/person_bloc/person_bloc.dart';
import 'package:activity_tracker/logic/cubit/theme_cubit/theme_cubit.dart';
import 'package:activity_tracker/presentation/screens/home_screen/widgets/person_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PersonBloc>().add(PersonsLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            BlocBuilder<PersonBloc, PersonState>(
                buildWhen: (previous, current) => current is! PersonListenState,
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case PersonsEmptyState || PersonsLoadingState:
                      return const SizedBox();
                    default:
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/addPerson');
                        },
                        child:const Chip(
                          label: Text("Add User"), 
                          avatar: Icon(Icons.add_box_outlined),
                        ),
                      );
                  }
                })
          ],
        ),
        drawer: Drawer(
          child: Column(children: [
            DrawerHeader(
                child: Column(
              children: [
                const Text("Welcome"),
                BlocBuilder<AuthenticateBloc, AuthenticateState>(
                    buildWhen: (previous, current) =>
                        current is AuthenticateSignUpState &&
                        current.isNew == false &&
                        current.status == SignUpState.registered,
                    builder: (context, state) {
                      AuthenticateSignUpState authenticateSignUpState =
                          state as AuthenticateSignUpState;
                      return Text(authenticateSignUpState.user.email);
                    }),
              ],
            )),
            BlocListener<AuthenticateBloc, AuthenticateState>(
              listenWhen: (previous, current) =>
                  current is AuthenticateSignUpState,
              listener: (context, state) {
                if (state.runtimeType == AuthenticateSignUpState) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                }
              },
              child: ListTile(
                onTap: () {
                  context
                      .read<AuthenticateBloc>()
                      .add(AuthenticateLogoutEvent());
                },
                title: const Text("Logout"),
                trailing: const Icon(Icons.logout),
              ),
            ),
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                if (state.runtimeType == ThemeInitial) {
                  ThemeInitial themeInitialState = state as ThemeInitial;
                  return ListTile(
                    title: const Text("Dark Mode"),
                    trailing: Switch(value : themeInitialState.isDark, onChanged: (value) {
                      context.read<ThemeCubit>().onToggle();
                    }),
                  );
                } else {
                  return const SizedBox();
                }
                
              },
            )
          ]),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<PersonBloc, PersonState>(
            listenWhen: (previous, current) => current is PersonListenState,
            buildWhen: (previous, current) => current is! PersonListenState,
            listener: (context, state) {
              switch (state.runtimeType) {
                case PersonErrorState:
                  {
                    PersonErrorState personErrorState =
                        state as PersonErrorState;
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(personErrorState.errMsg)));
                  }
                case PersonSuccessState:
                  {
                    PersonSuccessState personSuccessState =
                        state as PersonSuccessState;
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(personSuccessState.succMsg)));
                  }
              }
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case PersonsLoadingState:
                  {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                case PersonsEmptyState:
                  {
                    return Center(
                        child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/addPerson');
                          },
                          child: const Chip(
                            label: Text("Add User"),
                            avatar: Icon(Icons.add_box_outlined),
                          ),
                        ),
                        const Text("Provide your Info to calculate BMI")
                      ],
                    ));
                  }
                case PersonsLoadedState:
                  {
                    PersonsLoadedState personsLoadedState =
                        state as PersonsLoadedState;
                    return ListView.builder(
                      itemCount: personsLoadedState.personsList.length,
                      itemBuilder: (context, index) => PersonListTile(
                          person:
                              personsLoadedState.personsList.elementAt(index)),
                    );
                  }
              }
              return const SizedBox();
            },
          ),
        ));
  }
}
