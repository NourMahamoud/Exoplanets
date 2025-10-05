class PlanetModel {
  String? planet_name;
  String? planet_radius;
  String? koi_disposition;
  String? temperature;
  String? stellar_temperature;
  String? distance;
  String? transit_duration;
  String? orbital_period;
  String? stellar_radius;
  String? transit_depth;
  String? star_planet_radius_ratio;
  String? star_name;

  static const Map<String, String> DEFAULT_VALUES = {
    'transit_depth': '4376.0',
    'transit_duration': '2.750763',
    'orbital_period':'4.244335',
    'planet_radius':'10.5416',
    'stellar_radius': '1.23975',
    'temperature': '1201.5124066',
    'stellar_temperature': '5805.6',
    'distance': '386.525',

  };

  PlanetModel(
      this.planet_name,
      this.planet_radius,
      this.koi_disposition,
      this.temperature,
      this.stellar_temperature,
      this.distance,
      this.transit_duration,
      this.orbital_period,
      this.stellar_radius,
      this.transit_depth,
      this.star_planet_radius_ratio,
      this.star_name,
      ) {
    transit_depth ??= DEFAULT_VALUES['transit_depth'];
    transit_duration ??= DEFAULT_VALUES['transit_duration'];
    orbital_period ??= DEFAULT_VALUES['orbital_period'];
    planet_radius ??= DEFAULT_VALUES['planet_radius'];
    stellar_radius ??= DEFAULT_VALUES['stellar_radius'];
    temperature ??= DEFAULT_VALUES['temperature'];
    stellar_temperature ??= DEFAULT_VALUES['stellar_temperature'];
    distance ??= DEFAULT_VALUES['distance'];
  }

  factory PlanetModel.fromjson(Map<String, dynamic> json) {
    return PlanetModel(
      json['planet name'],
      json['planet_radius'],
      json['planet disposition'],
      json['temperature'],
      json['stellar_temperature'],
      json['distance'],
      json['koi_duration'],
      json['orbital_period'],
      json['ra'],
      json['transit_depth'],
      json['pl_ratror'],
      json['star name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'planet_name': planet_name,
      'planet_radius': planet_radius,
      'planet disposition': koi_disposition,
      'temperature': temperature,
      'stellar_temperature': stellar_temperature,
      'distance': distance,
      'transit_duration': transit_duration,
      'orbital_period': orbital_period,
      'stellar_radius': stellar_radius,
      'transit_depth': transit_depth,
      'star_planet_radius_ratio': star_planet_radius_ratio,
      'star_name': star_name,

    };
  }
}


