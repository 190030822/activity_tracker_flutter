import 'package:activity_tracker/core/constants/colors.dart';
import 'package:activity_tracker/data/models/new_user.dart';
import 'package:activity_tracker/logic/bloc/authenticate_bloc/authenticate_bloc.dart';
import 'package:activity_tracker/presentation/screens/login/widgets/emailTextField.dart';
import 'package:activity_tracker/presentation/screens/login/widgets/passwordTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: Container(
          color: figmaLightestGrey,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.mode_edit_outline_rounded,
                        size: 150,
                      ),
                      EmailTextField(_emailController),
                      PasswordTextField(_passwordController),
                      ElevatedButton.icon(
                        style: ButtonStyle(backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.red;
                            }
                            return figmaDarkGrey;
                          },
                        )),
                        label: BlocConsumer<AuthenticateBloc, AuthenticateState>(
                          listenWhen: (previous, current) => current is AuthenticateSignUpState && current.isNew == true,
                          buildWhen: (previous, current) => current is AuthenticateSignUpState && current.isNew == true,
                          listener: (context, state) {
                            AuthenticateSignUpState authenticateSignUpState = state as AuthenticateSignUpState;
                            switch(authenticateSignUpState.status) {
                              case SignUpState.registered: {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User Registered Successfully")));
                                Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
                              }
                              case SignUpState.failed: {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User Registration Unsucessfull")));
                              }
                              default: 
                            } 
                          },
                          builder: (context, state) {
                            AuthenticateSignUpState authenticateSignUpState = state as AuthenticateSignUpState;
                            switch(authenticateSignUpState.status) {
                              case SignUpState.registering: return const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: figmaOrange,));
                              default : return const Text("Sign Up");
                            } 
                          }, 
                        ),
                        icon: const Icon(Icons.login_rounded),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            UserModel user = UserModel(_emailController.text, _passwordController.text);
                            context.read<AuthenticateBloc>().add(AuthenticateSignUpEvent(user));
                          }
                        },
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account ? ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            InkWell(
                              onTap: () => Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false),
                              child: const Text("Sign in",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: figmaBlue)),
                            )
                          ])
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
