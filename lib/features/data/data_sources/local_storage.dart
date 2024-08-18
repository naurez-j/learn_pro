import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    try {
      await secureStorage.write(key: 'auth_token', value: token);
    } catch (e) {
      print('Error saving token to the local storage');
      throw Exception(e);
    }
  }

  Future<String> getAuthToken() async {
    try {
      final String? authToken = await secureStorage.read(key: 'auth_token');
      if (authToken != null) {
        return authToken;
      } else {
        return 'no_token';
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void>deleteAuthToken()async{
    try {
      await secureStorage.delete(key: 'auth_token');
    } catch (e) {
      throw Exception(e);
    }
  }

}
