import 'api_provider.dart';
import '../models/business.dart';

class Repository {
  ApiProvider appApiProvider = ApiProvider();
  Future<Business> fetchBusinesses(String city) => appApiProvider.fetchBusinesses(city);
  Future<bool> singInUser(String email, String password) => appApiProvider.singInUser(email, password);
}
