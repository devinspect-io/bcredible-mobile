import 'api_provider.dart';
import '../models/business.dart';

class Repository {
  ApiProvider appApiProvider = ApiProvider();
  Future<List<Business>> fetchBusinesses(String city) => appApiProvider.fetchBusinesses(city);
}
