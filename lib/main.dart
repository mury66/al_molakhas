// ignore_for_file: unused_import
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/modules/web_view/web_view.dart';
import 'package:task/network/remote/dio_helper.dart';
import 'package:task/shared/blocObserver.dart';
import 'package:task/shared/cubit/Appcubit.dart';
import 'package:task/shared/cubit/Appstates.dart';
import 'package:task/shared/cubit/cubit.dart';
import 'package:task/shared/cubit/states.dart';
import 'layouts/news_app/news_layout/news_layout.dart';
import 'network/local/cache_helper.dart';

  void main() async
  {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = const SimpleBlocObserver();
    DioHelper.init();
    await CacheHelper.init();
    bool? isDark = CacheHelper.getBoolean(key: "isDark");
    runApp(MyApp (isDark!));
}

class MyApp extends StatelessWidget {

  final bool isDark;

  const MyApp(this.isDark, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubit(NewsInitialState())..getBusiness(),),
        BlocProvider(create: (context)=>AppCubit(AppInitialState())..changeAppMode(isDark))
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, state)=>{} ,
        builder: (BuildContext context, state) {
          {
            var cubit = AppCubit.get(context);
            return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.grey,
          textTheme: const TextTheme(
          bodyLarge: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          )
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 255, 214, 156),

          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color.fromARGB(255, 255, 214, 156),
          unselectedItemColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 12, 24, 72),
          elevation: 20,
          type: BottomNavigationBarType.fixed),
          appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 250, 250, 250),
          fontSize: 20),
          actionsIconTheme: IconThemeData(
          color: Color.fromARGB(255, 255, 255, 255), size: 28),
          backgroundColor: Color.fromARGB(255, 12, 24, 72),
          systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Color.fromARGB(255, 12, 24, 72),
          ))),
          darkTheme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 12, 24, 72),
          useMaterial3: true,
          primarySwatch: Colors.brown,
          textTheme: const TextTheme(
          bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold

          )
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color.fromARGB(255, 255, 214, 156),
          unselectedItemColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 12, 24, 72),
          elevation: 20,
          type: BottomNavigationBarType.fixed),
          appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 250, 250, 250),
          fontSize: 20),
          actionsIconTheme: IconThemeData(
          color: Color.fromARGB(255, 255, 255, 255), size: 28),
          backgroundColor: Color.fromARGB(255, 12, 24, 72),
          systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Color.fromARGB(255, 12, 24, 72),
          ))),
          themeMode: cubit.isDark? ThemeMode.dark:ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: const NewsLayout(),
          );
        }
        }
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
