import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiProvider {
  int? _sensorData;

  ApiProvider() {
    _fetchRandomNumber();
  }

  Future<void> _fetchRandomNumber() async {
    final response = await http.get(Uri.parse(
        'https://testgardamillenial.000webhostapp.com/random_number.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _sensorData = data['number'];
    } else {
      //print('Failed to fetch data: ${response.statusCode}');
    }
  }

  int? get sensorData => _sensorData;
}
