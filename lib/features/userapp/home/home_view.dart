import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safetyapp/common/widget/custom_carousel_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                  child: ListView(
                children: [
                  CustomCarousel(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Emergency",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
