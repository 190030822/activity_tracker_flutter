import 'package:activity_tracker/core/constants/colors.dart';
import 'package:activity_tracker/data/models/new_user.dart';
import 'package:activity_tracker/logic/bloc/authenticate_bloc/authenticate_bloc.dart';
import 'package:activity_tracker/presentation/screens/login/widgets/emailTextField.dart';
import 'package:activity_tracker/presentation/screens/login/widgets/passwordTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: "");
  final TextEditingController _passwordController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(6),
              height: MediaQuery.of(context).size.height - 10,
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.security_outlined,
                        size: 150,
                      ),
                      const Text(
                        "Welcome Again",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      EmailTextField(_emailController),
                      PasswordTextField(_passwordController),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthenticateBloc>().add(
                                AuthenticateSignInEvent(UserModel(
                                    _emailController.text,
                                    _passwordController.text)));
                          }
                        },
                        icon: const Icon(
                          Icons.login,
                        ),
                        label:
                            BlocConsumer<AuthenticateBloc, AuthenticateState>(
                          listenWhen: (previous, current) =>
                              current is AuthenticateSignUpState &&
                              current.isNew == false,
                          buildWhen: (previous, current) =>
                              current is AuthenticateSignUpState &&
                              current.isNew == false,
                          listener: (context, state) {
                            AuthenticateSignUpState authenticateSignUpState =
                                state as AuthenticateSignUpState;
                            switch (authenticateSignUpState.status) {
                              case SignUpState.registered:
                                {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, "/home", (route) => false);
                                }
                              case SignUpState.failed:
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(state.user.email)));
                                }
                              default:
                            }
                          },
                          builder: (context, state) {
                            AuthenticateSignUpState authenticateSignUpState =
                                state as AuthenticateSignUpState;
                            switch (authenticateSignUpState.status) {
                              case SignUpState.registering: {
                                if (!state.user.isEmpty) {
                                   return const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                    )
                                  );
                                } else {
                                   return const Text("Sign In");
                                }
                              }
                
                              default:
                                return const Text("Sign In");
                            }
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocBuilder<AuthenticateBloc, AuthenticateState>(
                            builder: (context, state) {
                              if (state.runtimeType == AuthenticateSignUpState) {
                                AuthenticateSignUpState authenticateSignUpState = state as AuthenticateSignUpState;
                                switch(authenticateSignUpState.status) {
                                  case SignUpState.registering : {
                                    if (authenticateSignUpState.user.isEmpty) {
                                      return const CircularProgressIndicator();
                                    } else {
                                      return  SignInWithGoogle(authenticateSignUpState);
                                    }
                                  }
                                  case SignUpState.wentback : {
                                    return  SignInWithGoogle(authenticateSignUpState);
                                  }
                                  default: return  SignInWithGoogle(authenticateSignUpState);
                                }
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account ? ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          InkWell(
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,),
                            ),
                            onTap: () => Navigator.pushNamedAndRemoveUntil(
                                context, "/signUp", (route) => false),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

class SignInWithGoogle extends StatelessWidget {

  final AuthenticateSignUpState state;
  const SignInWithGoogle(this.state,{
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width/1.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20)
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/google_icon.png',
                width: 30, height: 30),
            const Text("Continue with Google"),
          ],
        ),     
      ),
      onTap: () {
        if (state.status == SignUpState.registering) {
          return ;
        }
        context
            .read<AuthenticateBloc>()
            .add(AuthenticateSignInWithGoogleEvent());
      },
    );
  }
}
