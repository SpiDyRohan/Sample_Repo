import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LoginController extends GetxController{
  var isChecked=false.obs;
  var isemailFilled=false.obs;
  var isPasswordFilled=false.obs;
  late StompClient stompClient;

  TextEditingController passwordController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    emailController.text="abc@abc.com";
    passwordController.text="6000ac4bc22ce6ea4adcae78b0ff87412d05e4c35912c38a740ff6db659";
  }
  @override
  void onReady() {
    super.onReady();
    connection();
  }

  connection() {
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://122.179.143.201:8089',
        onConnect: (StompFrame connectFrame) {
          subscribeToDestination('/websocket?sessionID=<YOUR_FIRST_NAME>&userID=<YOUR_FIRST_NAME>&apiToken=<YOUR_FIRST_NAME>'); // Adjust the subscription destination accordingly
          debugPrint('Connected');
        },
        beforeConnect: () async {
          await Future.delayed(Duration(milliseconds: 200));
          debugPrint('Connecting...');
        },
        onWebSocketError: (dynamic error) {
          debugPrint('WebSocket Error: $error');
        },
      ),
    );
    stompClient.activate();
  }

  subscribeToDestination(String destination) {
    stompClient.subscribe(
      destination: destination,
      callback: (frame) {
        debugPrint("Received message: ${frame.body}");
        // Handle the received message here
      },
    );
  }



}