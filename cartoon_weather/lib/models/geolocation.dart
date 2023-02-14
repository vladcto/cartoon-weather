import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'geolocation.g.dart';

@immutable
@JsonSerializable()
class Geolocation extends Equatable {
  final String name;
  final double lat;
  final double lon;

  Map<String, dynamic> toJson() => _$GeolocationToJson(this);
  factory Geolocation.fromJson(Map<String, dynamic> json) =>
      _$GeolocationFromJson(json);

  const Geolocation({
    required this.name,
    required this.lat,
    required this.lon,
  });

  @override
  List<Object?> get props => [name, lat, lon];
}
