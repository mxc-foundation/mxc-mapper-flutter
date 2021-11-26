import 'dart:math';

import 'package:mxc_mapper/models/gateway.dart';

abstract class GatewayRepository {
  Future<Gateway> fetchGateway(String id);
}

class FakeGatewayRepository implements GatewayRepository {
  double data = 0;

  @override
  Future<Gateway> fetchGateway(String id) {
    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final random = Random();

        // Simulate some network exception
        if (random.nextBool()) {
          throw NetworkException();
        }

        // Since we're inside a fake repository, we need to cache the temperature
        // in order to have the same one returned in for the detailed gateway
        data = 20 + random.nextInt(15) + random.nextDouble();

        // Return "fetched" gateway
        return Gateway(
          id: id,
          // data: data,
        );
      },
    );
  }
}

class NetworkException implements Exception {}
