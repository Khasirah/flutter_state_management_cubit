import 'dart:convert';

import 'package:cubit/appliacation/auth/cubit/auth_cubit.dart';
import 'package:cubit/domain/auth/model/login_response.dart';
import 'package:cubit/utils/constanst.dart' as constans;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late LoginResponse loginResponse;

  @override
  void initState() {
    final _data = GetStorage().read(constans.USER_LOCAL_KEY);
    loginResponse = LoginResponse.fromJson(jsonDecode(_data));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => AuthCubit(),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Center(
                child: Text(loginResponse.token.toString()),
              );
            },
          ),
        ),
      ),
    );
  }
}
