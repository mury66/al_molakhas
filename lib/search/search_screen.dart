// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/components.dart';
import '../shared/cubit/Appcubit.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {

  var searchController=TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder:(context,state) {
        var list=NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
          title: const Text("Al Molakhas"),
          leading: IconButton(
            onPressed: ()
            {
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
          ),
          actions: [
            IconButton(onPressed: () {
              AppCubit.get(context).changeAppMode();
            }, icon: const Icon(Icons.brightness_4_outlined)),
          ],
        ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultinputform(
                  context: context,
                  controller: searchController,
                  submitted:(){},
                  type: TextInputType.text,
                  prefix: Icons.search,
                  sufix: Icons.close,
                  suffixOnPressed: ()
                  {
                    searchController.text="";
                  },
                  hint: "search what you want",
              ),
            ),
            Expanded(
              child: articleBuilder(list,context),
            ),
          ],
        ),
      );
      }
    );
  }
}
