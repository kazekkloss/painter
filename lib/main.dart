import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paint/painter/painter.dart';
import 'package:paint/painter_bloc/painter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PainterBloc(),
      child: const MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          PainterCanvas(height: height, width: width),
          Padding(
            padding: const EdgeInsets.all(50),
            child: IconButton(
                onPressed: !show
                    ? () {
                        setState(() {
                          show = true;
                        });
                      }
                    : () {
                        setState(() {
                          show = false;
                        });
                      },
                icon: const Icon(
                  Icons.settings,
                  size: 60,
                )),
          ),
          AnimatedPositioned(
              top: (height - 500) / 2,
              left: !show ? -300 : (width - 300) / 2,
              curve: Curves.linearToEaseOut,
              duration: const Duration(milliseconds: 600),
              child: const PainterTools())
        ],
      ),
    );
  }
}
