import 'package:basicobien/pages/splashsreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        //texto
        textTheme:GoogleFonts.latoTextTheme(Theme.of(context).textTheme).copyWith(
          titleLarge: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.titleLarge,
                fontSize: 32,
                color: Colors.black,
                fontWeight: FontWeight.bold,
          ),
          bodyLarge: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.bodyLarge,
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
            bodyMedium: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.bodyMedium,
              fontSize: 18,
              color: Colors.black87,
              fontStyle: FontStyle.italic,
            )
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green.shade300,
          brightness: Brightness.light,
          ),
          iconTheme: IconThemeData(
            color: Colors.green.shade300,
          ),
          scaffoldBackgroundColor: Colors.green[50],
          appBarTheme: AppBarTheme(
             backgroundColor: Colors.green.shade300,
             titleTextStyle: GoogleFonts.lato(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold
             )
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade300,
              textStyle: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white
              )
            )
          )


      ),
      home: SplashScreen(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Water Seven")),
      body: Center(child: Text("")),
    );
  }
}
