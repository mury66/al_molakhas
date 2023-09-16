// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/modules/buisness/buisness.dart';
import 'package:task/modules/science/science.dart';
import 'package:task/modules/sports/sports.dart';
import 'package:task/shared/cubit/states.dart';

import '../../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit(super.initialState);

  static NewsCubit get(context) => BlocProvider.of(context);

  int current = 0;
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    ];
  List business = [];
  List sport = [];
  List science = [];
  List search = [];
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(label: "Business", icon: Icon(Icons.business_center_sharp)),
    const BottomNavigationBarItem(label: "Sports", icon: Icon(Icons.sports)),
    const BottomNavigationBarItem(label: "Science", icon: Icon(Icons.science)),
  ];
  void changeIndex(int index){
    current = index;

    if(index==0) {
      getBusiness();
    }
    if(index==1) {
      getSport();
    }
    if(index==2) {
      getScience();
    }
    emit(NewsChangeBottomNavBarState());
  }
  void getBusiness(){
    if(business.isEmpty){
        emit(NewsGetBusinessLoadingState());
        DioHelper.getData(url: "v2/top-headlines", query: {
          "country": "us",
          "category": "business",
          "apiKey": "099e9c9aaac14711aefccd39ade69a28",
        }).then((value) {
          business = value.data["articles"];
          emit(NewsGetBusinessSuccessState());
        }).catchError((error) {
          print(error.toString());
          emit(NewsGetBusinessErrorState(error.toString()));
        });
      }
    else{
        emit(NewsGetBusinessSuccessState());
      }
  }
  void getSport(){
    if(sport.isEmpty){
        emit(NewsGetSportLoadingState());
        DioHelper.getData(url: "v2/top-headlines", query: {
          "country": "us",
          "category": "sports",
          "apiKey": "099e9c9aaac14711aefccd39ade69a28",
        }).then((value) {
          sport = value.data["articles"];
          emit(NewsGetSportSuccessState());
        }).catchError((error) {
          print(error.toString());
          emit(NewsGetSportErrorState(error.toString()));
        });
      }
    else{
      emit(NewsGetSportSuccessState());

    }
  }
  void getScience(){
    if(science.isEmpty){
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "us",
        "category": "science",
        "apiKey": "099e9c9aaac14711aefccd39ade69a28",
      }).then((value) {
        science = value.data["articles"];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }
    else{
      emit(NewsGetScienceSuccessState());
    }
  }
  void getSearch(String value){
      emit(NewsGetSearchLoadingState());
      search=[];
      DioHelper.getData(url: "v2/everything", query: {
        "q": value,
        "apiKey": "099e9c9aaac14711aefccd39ade69a28",
      }).then((value) {
        search = value.data["articles"];
        emit(NewsGetSearchSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });
  }
}
