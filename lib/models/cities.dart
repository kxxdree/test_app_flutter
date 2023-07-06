import 'package:http/http.dart' as http;
import 'dart:convert';

class CitiesList {
  List<City> cities;
  CitiesList({required this.cities});

  factory CitiesList.fromJson(List<dynamic> json) {
    List<City> cities = [];
    for (var cityMap in json) {
      cities.add(City.fromJson(cityMap));
    }

    return CitiesList(
      cities: cities,
    );
  }
}

class City {
  String? name;
  String? image;
  DateTime? dateTimeImage;
  int? totalPeople;
  double? lat;
  double? long;
  int? id;

  City(
      {required this.name,
      required this.image,
      required this.dateTimeImage,
      required this.totalPeople,
      required this.lat,
      required this.long,
      required this.id});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'] as String,
      image: json['image'] as String,
      dateTimeImage: DateTime.parse(json['dateTimeImage']),
      totalPeople: json['totalPeople'] as int,
      lat: double.parse(json['lat']),
      long: double.parse(json['long']),
      id: int.parse(json['id']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['dateTimeImage'] = dateTimeImage;
    data['totalPeople'] = totalPeople;
    data['lat'] = lat;
    data['long'] = long;
    data['id'] = id;
    return data;
  }
}

Future<CitiesList> getCitiesList() async {
  const url = 'https://649befbd0480757192372825.mockapi.io/api/v1/cities';
  final response = await http.get(
    Uri.parse(url),
  );
  final jsonresponse = json.decode(response.body);
  if (response.statusCode == 200) {
    return CitiesList.fromJson(jsonresponse);
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
