import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisser_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tisser_app/features/auth/presentation/bloc/auth_events.dart';
import 'package:tisser_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:tisser_app/features/auth/presentation/pages/home_page.dart';
import 'package:tisser_app/features/auth/presentation/pages/signup_page.dart';
import 'package:tisser_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:tisser_app/features/auth/presentation/widgets/my_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("login error"),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 150),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    MyTextFiled(
                      controller: emailController,
                      text: 'Enter email',
                      icon: Icons.email,
                    ),

                    SizedBox(height: 10),
                    MyTextFiled(
                      controller: passwordController,
                      text: 'Enter password',
                      icon: Icons.key,
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Forgot password',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    if (state is AuthLoading)
                      Center(child: CircularProgressIndicator())
                    else
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          title: 'Login',
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              SignInEvent(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              ),
                            );
                          },
                        ),
                      ),

                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'New member?  ',
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Register now',
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
