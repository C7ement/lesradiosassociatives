class RadioStation {
  String name;
  String city;
  String team;
  String zipcode;
  double lat;
  double lng;
  String website;
  String logo;
  bool status;
  String streamlink;
  String slogan;
  String geohash;
  String fblink;

  RadioStation({
    required this.name,
    required this.city,
    required this.team,
    required this.zipcode,
    required this.lat,
    required this.lng,
    required this.website,
    required this.logo,
    required this.status,
    required this.streamlink,
    required this.slogan,
    required this.geohash,
    required this.fblink,
  });

  // Method to update the RadioStation object with new data
  void update(Map<String, dynamic> newFields) {
    name = newFields['name'] ?? name;
    city = newFields['city'] ?? city;
    team = newFields['team'] ?? team;
    zipcode = newFields['zipcode'] ?? zipcode;
    lat = newFields['lat'] ?? lat;
    lng = newFields['lng'] ?? lng;
    website = newFields['website'] ?? website;
    logo = newFields['logo'] ?? logo;
    status = newFields['status'] ?? status;
    streamlink = newFields['streamlink'] ?? streamlink;
    slogan = newFields['slogan'] ?? slogan;
    geohash = newFields['geohash'] ?? geohash;
    fblink = newFields['fblink'] ?? fblink;
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'city': city,
        'team': team,
        'zipcode': zipcode,
        'lat': lat,
        'lng': lng,
        'website': website,
        'logo': logo,
        'status': status,
        'streamlink': streamlink,
        'slogan': slogan,
        'geohash': geohash,
        'fblink': fblink,
      };
}
