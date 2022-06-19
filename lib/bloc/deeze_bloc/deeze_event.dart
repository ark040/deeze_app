import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class DeezeEvent {
  const DeezeEvent();
}

class LoadDeeze extends DeezeEvent {
  final String type;
  const LoadDeeze(this.type);
}
