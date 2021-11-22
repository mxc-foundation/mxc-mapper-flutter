import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mxc_mapper/notifier/gateway_notifier.dart';
import 'package:mxc_mapper/repository/gateway_repository.dart';

final gatewayRepositoryProvider = Provider<GatewayRepository>(
  (ref) => FakeGatewayRepository(),
);

final gatewayNotifierProvider = StateNotifierProvider(
  (ref) => GatewayNotifier(ref.watch(gatewayRepositoryProvider)),
);
