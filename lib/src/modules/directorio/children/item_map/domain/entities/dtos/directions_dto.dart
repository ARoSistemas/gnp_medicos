import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsDto {
  DirectionsDto({
    required this.geocodedWaypoints,
    required this.routes,
    required this.status,
  });
  factory DirectionsDto.empty() => DirectionsDto(
    geocodedWaypoints: [],
    routes: [],
    status: '',
  );

  factory DirectionsDto.fromJson(Map<String, dynamic> json) => DirectionsDto(
    geocodedWaypoints: json['geocoded_waypoints'] != null
        ? List<GeocodedWaypoint>.from(
            (json['geocoded_waypoints'] as List).map(
              (x) => GeocodedWaypoint.fromJson(x),
            ),
          )
        : [],
    routes: json['routes'] != null
        ? List<Route>.from(
            (json['routes'] as List).map((x) => Route.fromJson(x)),
          )
        : [],
    status: json['status'],
  );

  DirectionsDto directionsDtoFromJson(String str) =>
      DirectionsDto.fromJson(json.decode(str));

  String directionsDtoToJson(DirectionsDto data) => json.encode(data.toJson());

  final List<GeocodedWaypoint> geocodedWaypoints;
  final List<Route> routes;
  final String status;

  Map<String, dynamic> toJson() => {
    'geocoded_waypoints': List<dynamic>.from(
      geocodedWaypoints.map((x) => x.toJson()),
    ),
    'routes': List<dynamic>.from(routes.map((x) => x.toJson())),
    'status': status,
  };
}

class GeocodedWaypoint {
  GeocodedWaypoint({
    required this.geocoderStatus,
    required this.placeId,
    required this.types,
  });

  factory GeocodedWaypoint.empty() => GeocodedWaypoint(
    geocoderStatus: '',
    placeId: '',
    types: [],
  );

  factory GeocodedWaypoint.fromJson(Map<String, dynamic> json) =>
      GeocodedWaypoint(
        geocoderStatus: json['geocoder_status'] ?? '',
        placeId: json['place_id'] ?? '',
        types: json['types'] != null
            ? List<String>.from((json['types'] as List).map((x) => x))
            : [],
      );

  final String geocoderStatus;
  final String placeId;
  final List<String> types;

  Map<String, dynamic> toJson() => {
    'geocoder_status': geocoderStatus,
    'place_id': placeId,
    'types': List<dynamic>.from(types.map((x) => x)),
  };
}

class Route {
  Route({
    required this.bounds,
    required this.copyrights,
    required this.legs,
    required this.overviewPolyline,
    required this.summary,
    required this.warnings,
    required this.waypointOrder,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    bounds: json['bounds'] != null
        ? Bounds.fromJson(json['bounds'])
        : Bounds.empty(),
    copyrights: json['copyrights'] ?? '',
    legs: json['legs'] != null
        ? List<Leg>.from((json['legs'] as List).map((x) => Leg.fromJson(x)))
        : [],
    overviewPolyline: OverviewPolyline.fromJson(json['overview_polyline']),
    summary: json['summary'] ?? '',
    warnings: json['warnings'] != null
        ? List<dynamic>.from((json['warnings'] as List).map((x) => x))
        : [],
    waypointOrder: json['waypoint_order'] != null
        ? List<dynamic>.from(
            (json['waypoint_order'] as List).map((x) => x),
          )
        : [],
  );

  final Bounds bounds;
  final String copyrights;
  final List<Leg> legs;
  final OverviewPolyline overviewPolyline;
  final String summary;
  final List<dynamic> warnings;
  final List<dynamic> waypointOrder;

  Map<String, dynamic> toJson() => {
    'bounds': bounds.toJson(),
    'copyrights': copyrights,
    'legs': List<dynamic>.from(legs.map((x) => x.toJson())),
    'overview_polyline': overviewPolyline.toJson(),
    'summary': summary,
    'warnings': List<dynamic>.from(warnings.map((x) => x)),
    'waypoint_order': List<dynamic>.from(waypointOrder.map((x) => x)),
  };
}

class Bounds {
  Bounds({
    required this.northeast,
    required this.southwest,
  });

  factory Bounds.empty() => Bounds(
    northeast: Northeast.empty(),
    southwest: Northeast.empty(),
  );

  factory Bounds.fromJson(Map<String, dynamic> json) => Bounds(
    northeast: json['northeast'] != null
        ? Northeast.fromJson(json['northeast'])
        : Northeast.empty(),
    southwest: json['southwest'] != null
        ? Northeast.fromJson(json['southwest'])
        : Northeast.empty(),
  );

  final Northeast northeast;
  final Northeast southwest;

  Map<String, dynamic> toJson() => {
    'northeast': northeast.toJson(),
    'southwest': southwest.toJson(),
  };
}

class Northeast {
  Northeast({
    required this.lat,
    required this.lng,
  });

  factory Northeast.empty() => Northeast(lat: 0, lng: 0);

  factory Northeast.fromJson(Map<String, dynamic> json) => Northeast(
    lat: (json['lat'] as num).toDouble(),
    lng: (json['lng'] as num).toDouble(),
  );

  final double lat;
  final double lng;

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lng': lng,
  };
}

class Leg {
  Leg({
    required this.distance,
    required this.duration,
    required this.endAddress,
    required this.endLocation,
    required this.startAddress,
    required this.startLocation,
    required this.steps,
    required this.trafficSpeedEntry,
    required this.viaWaypoint,
  });

  factory Leg.empty() => Leg(
    distance: Distance(text: '', value: 0),
    duration: Distance(text: '', value: 0),
    endAddress: '',
    endLocation: Northeast.empty(),
    startAddress: '',
    startLocation: Northeast.empty(),
    steps: [],
    trafficSpeedEntry: [],
    viaWaypoint: [],
  );

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
    distance: json['distance'] != null
        ? Distance.fromJson(json['distance'])
        : Distance(text: '', value: 0),
    duration: json['duration'] != null
        ? Distance.fromJson(json['duration'])
        : Distance(text: '', value: 0),
    endAddress: json['end_address'] ?? '',
    endLocation: Northeast.fromJson(json['end_location']),
    startAddress: json['start_address'] ?? '',
    startLocation: json['start_location'] != null
        ? Northeast.fromJson(json['start_location'])
        : Northeast.empty(),
    steps: json['steps'] != null
        ? List<Step>.from(
            (json['steps'] as List).map((x) => Step.fromJson(x)),
          )
        : [],
    trafficSpeedEntry: json['traffic_speed_entry'] != null
        ? List<dynamic>.from(
            (json['traffic_speed_entry'] as List).map((x) => x),
          )
        : [],
    viaWaypoint: json['via_waypoint'] != null
        ? List<dynamic>.from(
            (json['via_waypoint'] as List).map((x) => x),
          )
        : [],
  );

  final Distance distance;
  final Distance duration;
  final String endAddress;
  final Northeast endLocation;
  final String startAddress;
  final Northeast startLocation;
  final List<Step> steps;
  final List<dynamic> trafficSpeedEntry;
  final List<dynamic> viaWaypoint;

  Map<String, dynamic> toJson() => {
    'distance': distance.toJson(),
    'duration': duration.toJson(),
    'end_address': endAddress,
    'end_location': endLocation.toJson(),
    'start_address': startAddress,
    'start_location': startLocation.toJson(),
    'steps': List<dynamic>.from(steps.map((x) => x.toJson())),
    'traffic_speed_entry': List<dynamic>.from(trafficSpeedEntry.map((x) => x)),
    'via_waypoint': List<dynamic>.from(viaWaypoint.map((x) => x)),
  };
}

class Distance {
  Distance({
    required this.text,
    required this.value,
  });

  factory Distance.fromJson(Map<String, dynamic> json) => Distance(
    text: json['text'] ?? '',
    value: json['value'] ?? 0,
  );
  final String text;
  final int value;

  Map<String, dynamic> toJson() => {
    'text': text,
    'value': value,
  };
}

class Step {
  Step({
    required this.distance,
    required this.duration,
    required this.endLocation,
    required this.htmlInstructions,
    required this.polyline,
    required this.startLocation,
    required this.travelMode,
    this.maneuver,
  });

  factory Step.empty() => Step(
    distance: Distance(text: '', value: 0),
    duration: Distance(text: '', value: 0),
    endLocation: Northeast.empty(),
    htmlInstructions: '',
    polyline: Polyline(
      points: '',
      polylineId: const PolylineId(''),
      color: Colors.blue,
      width: 0,
    ),
    startLocation: Northeast.empty(),
    travelMode: '',
    maneuver: '',
  );

  factory Step.fromJson(Map<String, dynamic> json) => Step(
    distance: json['distance'] != null
        ? Distance.fromJson(json['distance'])
        : Distance(text: '', value: 0),
    duration: json['duration'] != null
        ? Distance.fromJson(json['duration'])
        : Distance(text: '', value: 0),
    endLocation: json['end_location'] != null
        ? Northeast.fromJson(json['end_location'])
        : Northeast.empty(),
    htmlInstructions: json['html_instructions'] ?? '',
    polyline: json['polyline'] != null
        ? Polyline.fromJson(json['polyline'])
        : Polyline(
            points: '',
            polylineId: const PolylineId(''),
            color: Colors.blue,
            width: 0,
          ),
    startLocation: json['start_location'] != null
        ? Northeast.fromJson(json['start_location'])
        : Northeast.empty(),
    travelMode: json['travel_mode'] ?? '',
    maneuver: json['maneuver'] ?? '',
  );

  final Distance distance;
  final Distance duration;
  final Northeast endLocation;
  final String htmlInstructions;
  final Polyline polyline;
  final Northeast startLocation;
  final String travelMode;
  final String? maneuver;

  Map<String, dynamic> toJson() => {
    'distance': distance.toJson(),
    'duration': duration.toJson(),
    'end_location': endLocation.toJson(),
    'html_instructions': htmlInstructions,
    'polyline': polyline.toJson(),
    'start_location': startLocation.toJson(),
    'travel_mode': travelMode,
    'maneuver': maneuver,
  };
}

class Polyline {
  Polyline({
    required this.points,
    required this.polylineId,
    required this.color,
    required this.width,
  });

  factory Polyline.fromJson(Map<String, dynamic> json) => Polyline(
    points: json['points'] ?? '',
    polylineId: const PolylineId(''),
    color: Colors.transparent,
    width: 0,
  );

  final String points;
  final PolylineId polylineId;
  final Color color;
  final int width;

  Map<String, dynamic> toJson() => {
    'points': points,
    'polylineId': polylineId,
    'color': color,
    'width': width,
  };
}

class OverviewPolyline {
  OverviewPolyline({
    required this.points,
  });

  factory OverviewPolyline.fromJson(Map<String, dynamic> json) =>
      OverviewPolyline(
        points: json['points'] ?? '',
      );

  final String points;

  Map<String, dynamic> toJson() => {
    'points': points,
  };
}
