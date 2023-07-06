import 'package:http/http.dart' as http;
import 'dart:convert';

class StreetsList {
  List<Street> streets;
  StreetsList({required this.streets});

  factory StreetsList.fromJson(List<dynamic> json) {
    List<Street> streets = [];
    for (var streetMap in json) {
      streets.add(Street.fromJson(streetMap));
    }

    return StreetsList(
      streets: streets,
    );
  }
}

class Street {
  String? name;
  String? address;
  String? id;
  String? cityId;

  Street({required this.name, required this.address, required this.id, required this.cityId});

  factory Street.fromJson(Map<String, dynamic> json) {
    return Street(
      name: json['name'] as String,
      address: json['address'] as String,
      id: json['id'] as String,
      cityId: json['cityId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['address'] = address;
    data['id'] = id;
    data['cityId'] = cityId;
    return data;
  }
}

Future<StreetsList> getStreetList() async {
  const url = 'https://649befbd0480757192372825.mockapi.io/api/v1/cities/1/streets';
  final response = await http.get(
    Uri.parse(url),
  );
  final jsonresponse = json.decode(response.body);

  if (response.statusCode == 200) {
    return StreetsList.fromJson(jsonresponse);
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
