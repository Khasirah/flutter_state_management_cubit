import 'package:cubit/appliacation/auth/cubit/auth_cubit.dart';
import 'package:cubit/domain/auth/model/login_request.dart';
import 'package:cubit/presentation/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _userName = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => AuthCubit(),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Terjadi Kesalahan 😭"),
                          content: Text(state.errorMessage.error.toString()),
                        ));
              } else if (state is AuthLoading) {
              } else if (state is AuthLoginSuccess) {
                // save data to local
                context.read<AuthCubit>().saveUserToLocal(state.dataLogin);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ));
              }
            },
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: _userName,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Input Username',
                      ),
                    ),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Input Password',
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    (state is AuthLoading)
                        ? _loginButtonLoading()
                        : _loginButton(context)
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  ElevatedButton _loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final _requestData =
            // LoginRequest(email: _userName.text, password: _password.text);
            LoginRequest(email: "eve.holt@reqres.in", password: "cityslicka");
        context.read<AuthCubit>().signInUser(_requestData);
      },
      child: const Text("Login"),
    );
  }

  ElevatedButton _loginButtonLoading() {
    return ElevatedButton(
      onPressed: () {},
      child: CircularProgressIndicator(),
    );
  }
}
