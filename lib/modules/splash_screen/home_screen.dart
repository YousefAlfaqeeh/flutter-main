import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/login/now_login.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';

import '../home/new_home.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // Fetch initial data
    if (CacheHelper.getBoolean(key: 'authorization') != null) {
      AppCubit().get_notif('', '');
    }

    // Set up the timer for navigation
    Timer(Duration(seconds: 8), () {
      if (CacheHelper.getBoolean(key: 'authorization') == null ||
          CacheHelper.getBoolean(key: 'authorization').toString().isEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddNewTask()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Hiome_Kids()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        if (CacheHelper.getBoolean(key: 'authorization') == null ||
            CacheHelper.getBoolean(key: 'authorization').toString().isEmpty) {
          return AppCubit()..getschool();
        }
        return AppCubit()..getChildren();
      },
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              height: double.infinity,
              alignment: Alignment.bottomCenter,
              color: Colors.white,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 2.5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomLotte('assets/lang/comp.json'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
