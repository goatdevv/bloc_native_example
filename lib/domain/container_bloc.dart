import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

// Создаем эвенты (действие)
enum ContainerEvents{colorRedEvent,colorGreenEvent,colorRandomEvent}

// класс для реализации бизнес логики
class ContainerBloc {
  
  // определяем параметры которые требуется изменить в зависимости от эвента который мы получаем от пользователя 
  Color _color = Colors.blueGrey;
  
  // Контроллер который отвечает за входящий поток данных 
  final _inputEventController = StreamController<ContainerEvents>();
  
  // стрим для входной информации 
  StreamSink<ContainerEvents> get inputEventSink => _inputEventController.sink;
  
  // стрим для состояния который мы отправляем в ui
  final _outputStateController = StreamController<Color>();
  Stream<Color> get outputStateStream => _outputStateController.stream; 
  
  // Future<void>
  
  Future<void> _changeContainerState(ContainerEvents event) async {
    if (event == ContainerEvents.colorRedEvent) {
      _color = Colors.red;
    } else if(event == ContainerEvents.colorGreenEvent){
      _color = Colors.green;
    } else if(event == ContainerEvents.colorRandomEvent){
      _color = Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);
    } else {
      // throw Создается исключение которое оповестит нас о том что произошла ошибка 
      throw Exception('Не корректный эвент и все сломалось');
    }
    _outputStateController.sink.add(_color);
  }
  
  ContainerBloc(){
    // Здесь мы подписываемся на поток и обрабатываем события пришедшей со стороны ui 
    // трансформируем в новый state 
   _inputEventController.stream.listen(_changeContainerState);
  }
  
  Future<void> dispose() async {
    
    _inputEventController.close();
    _outputStateController.close();
  }
}