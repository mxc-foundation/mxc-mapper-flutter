import 'package:meta/meta.dart';

class Location {
  int latitude;
  int longitude;
  int altitude;
  int accuracy;
  String source;

  Location(
      {this.latitude = 0,
      this.longitude = 0,
      this.altitude = 0,
      this.accuracy = 0,
      this.source = ''});
}

class Gateway {
  final String id;
  final String networkServerID;
  final String organizationID;

  final String name;
  final String description;

  final String lastSeenAt;
  final String createdAt;
  final String updatedAt;

  // Map get location => {};

  Gateway({
    this.id = '',
    this.networkServerID = '',
    this.organizationID = '',
    this.name = '',
    this.description = '',
    this.lastSeenAt = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Gateway &&
        o.id == id &&
        o.networkServerID == networkServerID &&
        o.organizationID == organizationID &&
        o.name == name &&
        o.description == description &&
        o.lastSeenAt == lastSeenAt &&
        o.createdAt == createdAt &&
        o.updatedAt == updatedAt;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      networkServerID.hashCode ^
      organizationID.hashCode ^
      name.hashCode ^
      description.hashCode ^
      lastSeenAt.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
