import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mxc_mapper/models/gateway.dart';
import 'package:mxc_mapper/repository/gateway_repository.dart';

abstract class GatewayState {
  const GatewayState();
}

class GatewayInitial extends GatewayState {
  const GatewayInitial();
}

class GatewayLoading extends GatewayState {
  const GatewayLoading();
}

class GatewayLoaded extends GatewayState {
  final Gateway gateway;
  const GatewayLoaded(this.gateway);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is GatewayLoaded && o.gateway == gateway;
  }

  @override
  int get hashCode => gateway.hashCode;
}

class GatewayError extends GatewayState {
  final String message;
  const GatewayError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is GatewayError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class GatewayNotifier extends StateNotifier<GatewayState> {
  final GatewayRepository _gatewayRepository;

  GatewayNotifier(this._gatewayRepository) : super(GatewayInitial());

  Future<void> getGateway(String cityName) async {
    try {
      state = GatewayLoading();
      final gateway = await _gatewayRepository.fetchGateway(cityName);
      state = GatewayLoaded(gateway);
    } on NetworkException {
      state = GatewayError("Couldn't fetch gateway. Is the device online?");
    }
  }
}
