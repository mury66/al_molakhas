// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/search/search_screen.dart';
import 'package:task/shared/components/components.dart';
import 'package:task/shared/cubit/Appcubit.dart';
import 'package:task/shared/cubit/cubit.dart';
import 'package:task/shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, NewsStates) {},
      builder: (context, NewsStates) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Al Molakhas"),
            actions: [
              IconButton(onPressed: ()
              {
                navigateTo(context, SearchScreen());
              }
              , icon: const Icon(Icons.search)),
              IconButton(onPressed: () {
                AppCubit.get(context).changeAppMode();
              }, icon: const Icon(Icons.brightness_4_outlined)),
            ],
          ),
          body: cubit.screens[cubit.current],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.current,
            items: cubit.bottomItems,
            onTap: (index) {
              cubit.changeIndex(index);
            },
          ),
        );
      },
    );
  }
}
