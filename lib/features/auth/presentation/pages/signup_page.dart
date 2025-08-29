import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tisser_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tisser_app/features/auth/presentation/bloc/auth_events.dart';
import 'package:tisser_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:tisser_app/features/task/presentation/pages/home_page.dart';
import 'package:tisser_app/features/auth/presentation/pages/login_page.dart';
import 'package:tisser_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:tisser_app/features/auth/presentation/widgets/my_textfield.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    // 👇 notifier for password visibility
    final ValueNotifier<bool> obscurePassword = ValueNotifier<bool>(true);

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
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Signup error"),
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
                    const SizedBox(height: 80),

                    Lottie.asset(
                      'assets/login.json',
                      height: 220,
                      repeat: true,
                      reverse: false,
                      animate: true,
                    ),

                    const SizedBox(height: 30),

                    MyTextFiled(
                      controller: emailController,
                      text: 'Enter email',
                      icon: Icons.email,
                    ),

                    const SizedBox(height: 10),

                    // 👇 wrap password field in ValueListenableBuilder
                    ValueListenableBuilder<bool>(
                      valueListenable: obscurePassword,
                      builder: (context, isObscure, _) {
                        return MyTextFiled(
                          controller: passwordController,
                          text: 'Enter password',
                          icon: Icons.key,
                          obscureText: isObscure,
                          suffix: IconButton(
                            icon: Icon(
                              isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              obscurePassword.value = !isObscure;
                            },
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 55),
                    if (state is AuthLoading)
                      Lottie.asset(
                        'assets/loading.json',
                        height: 50,
                        repeat: true,
                        reverse: false,
                        animate: true,
                      )
                    else
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          title: 'SignUp',
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              SignUpEvent(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              ),
                            );
                          },
                        ),
                      ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already registered? ',
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Login now',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
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
