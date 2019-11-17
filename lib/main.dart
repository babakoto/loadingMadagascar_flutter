import 'dart:math';
import 'dart:ui';

import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  LoadingController _loadingController ;

  @override
  void initState() {
    super.initState();
    _loadingController = LoadingController();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          setState(() {

          });
        },
        child: Icon(Icons.play_circle_filled),),
      body: Center(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 200,
                    width: 200,
                    child: FlareActor("assets/madagascar.flr",
                      alignment:Alignment.center,
                      fit:BoxFit.contain,
                      animation:"Untitled",
                      controller: _loadingController,
                    ),
                  ),
                  Positioned(
                      top: 180,
                      left: 60,
                      child: Text("Loading ...")
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.indeterminate_check_box), onPressed: (){
                      setState(() {
                        _loadingController.decrement();
                      });
                  }),
                  IconButton(icon: Icon(Icons.add_box),onPressed: (){
                    if(_loadingController.water.y>278.0){
                      setState(() {
                        _loadingController.increment();
                      });
                    }
                  },)
                ],
              )
            ],
          )
      ),
    );
  }
}



class LoadingController extends FlareControls{
 double _targetY = 0.0;
 double _targetYDown = 0.0;
 ActorNode water;
  @override
  void initialize(FlutterActorArtboard artboard) {
    super.initialize(artboard);
    water = artboard.getNode("water");
    print(">>${water.y}");
    water.y = 800.0;
    play('Untitled');
  }

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    super.advance(artboard, elapsed);
    water.y += _targetY;
    print("avance:${water.y}");
    return true;
  }

  increment(){
    _targetY -=20.0;
  }

  decrement(){
    _targetY +=20.0;
  }


}