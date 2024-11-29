import 'dart:convert';

import 'package:enpal_monitor/core/network/network_client.dart';
import 'package:enpal_monitor/core/network/network_request.dart';
import 'package:enpal_monitor/core/network/network_response.dart';
import 'package:flutter/services.dart';

class FakeNetworkClientImpl implements NetworkClient {
  @override
  Future<NetworkResponse> get({required NetworkRequest request}) async {
    await Future.delayed(Duration(milliseconds: 2000));
    final String response = await rootBundle.loadString('assets/mock.json');
    return NetworkResponse(
      body: await jsonDecode(response),
      headers: {},
    );
  }
}
