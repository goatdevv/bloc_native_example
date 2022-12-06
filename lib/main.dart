import 'package:bloc_application/domain/container_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bloc Native'),
        ),
        body: const BodyContent(),
      ),
    );
  }
}

class BodyContent extends StatefulWidget {
  const BodyContent({Key? key}) : super(key: key);

  @override
  State<BodyContent> createState() => _BodyContentState();
}

class _BodyContentState extends State<BodyContent> {
  // Получение блока для передачи эвентов и запуска функционала 
  ContainerBloc bloc = ContainerBloc();
  
  @override
  void dispose(){
    bloc.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          StreamBuilder<Color>(
            stream: bloc.outputStateStream,
            initialData: Colors.blue,
            builder: (context, snapshot) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                color: snapshot.data,
                width: 200,
                height: 200,
              );
            }
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              HomePageBtn(btnAction: () {
                bloc.inputEventSink.add(ContainerEvents.colorRedEvent);
              }, btnColor: Colors.red),
              HomePageBtn(btnAction: () {bloc.inputEventSink.add(ContainerEvents.colorRandomEvent);}, btnColor: Colors.yellow),
              HomePageBtn(btnAction: () {bloc.inputEventSink.add(ContainerEvents.colorGreenEvent);}, btnColor: Colors.green),
            ],
          ),
        ],
      ),
    );
  }
}

class HomePageBtn extends StatelessWidget {
  final Function btnAction;
  final Color btnColor;
  const HomePageBtn({Key? key, required this.btnAction,  this.btnColor = Colors.red})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: ()=>btnAction() ,
      backgroundColor: btnColor,
    );
  }
}
