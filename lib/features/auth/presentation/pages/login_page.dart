import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tisser_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tisser_app/features/auth/presentation/bloc/auth_events.dart';
import 'package:tisser_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:tisser_app/features/task/presentation/pages/home_page.dart';
import 'package:tisser_app/features/auth/presentation/pages/signup_page.dart';
import 'package:tisser_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:tisser_app/features/auth/presentation/widgets/my_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    // 👇 instead of setState
    final ValueNotifier<bool> obscurePassword = ValueNotifier<bool>(true);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                  content: Text("Login error"),
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

                  // 👇 Wrap password field with ValueListenableBuilder
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
                            isObscure ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            obscurePassword.value = !isObscure;
                          },
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(color: Colors.blue.shade600),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
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

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
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
                          style: TextStyle(
                            color: Colors.blue.shade600,
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
    );
  }
}
