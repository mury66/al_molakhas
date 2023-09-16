// ignore_for_file: non_constant_identifier_names, unnecessary_const

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:task/modules/web_view/web_view.dart';
import 'package:task/shared/cubit/cubit.dart';

void navigateTo(context,widget)
  =>Navigator.push(context,MaterialPageRoute(
      builder:(context)=>widget)
  );


Widget defaultinputform(
    {
      context,
      IconData? sufix,
      bool isPassword = false,
      bool isClickable = true,
      Function()? suffixOnPressed,
      Function? changed ,
      //required Function() validate,
      required Function submitted,
      Function()? tapped,
      required TextInputType type,
      required IconData prefix,
      required TextEditingController controller,
      //required String label,
      String? Function(String?)? validator,
      required String hint,
    }
    )
=>TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        enabled: isClickable,
        validator: (value) {
          if (value!.isEmpty) {
            return "this field can not be empty";
          }
          return null;
        },
        onFieldSubmitted: submitted(),
        onChanged: (value)
        {
          NewsCubit.get(context).getSearch(value);
        },
        onTap: tapped,
        cursorColor: const Color.fromARGB(255, 0, 0, 0),
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 119, 119, 119),
            ),
            iconColor: Colors.white,
            //labelText: label,
            border: const OutlineInputBorder(),
            //enabledBorder: const UnderlineInputBorder() ,
            prefixIcon: Icon(prefix),
            suffixIcon: IconButton(
              icon: Icon(sufix),
              onPressed: suffixOnPressed,
            )));

Widget buildArticleItem(article,context) => InkWell(
  onTap: (){
    navigateTo(context,WebViewScreen(url:"${article["url"]}"));
  },
  child:   Padding(

    padding: const EdgeInsets.all(10.0),

    child: Row(

      children: [

        Container(

          width: 120,

          height: 120 ,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10),

              image: DecorationImage(

                  image: NetworkImage("${article["urlToImage"]}"),

                  fit:BoxFit.cover

              )

          ),



        ),

        const SizedBox(width: 20,),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.start,

              children: [

                Expanded(

                  child: Text("${article["title"]}",

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                    style: Theme.of(context).textTheme.bodyLarge ,

                )),

                Text("${article["publishedAt"]}",

                  style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.grey),

                ),



              ],

            ),

          ),

        )

      ],

    ),

  ),
);

Widget articleBuilder(list,context) => ConditionalBuilder(
    condition:(list.isNotEmpty),
    builder: (context) =>ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context,index)=>buildArticleItem(list[index],context),
      separatorBuilder:(context,index)=>Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(height: 1,
          color: Color.fromARGB(255, 255, 214, 156),),
      ) ,
      itemCount: list.length ,
    ) ,
    fallback: (context) => const Center(
        child: CircularProgressIndicator(
          color: Color.fromARGB(255, 255, 214, 156),))
);