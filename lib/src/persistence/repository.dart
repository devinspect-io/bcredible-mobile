import 'api_provider.dart';
import '../models/business.dart';

class Repository {
  ApiProvider appApiProvider = ApiProvider();
  Future<List<Business>> fetchBusinesses(String city) =>
      appApiProvider.fetchBusinesses(city);
  Future<bool> singInUser(String email, String password) =>
      appApiProvider.singInUser(email, password);
  Future<bool> createUser(String name, String city, String street, String email,
          String password, List<String> categories) =>
      appApiProvider.createUser(
          name, city, street, email, password, categories);
  Future<bool> createRating(
          int stars, String review, String userId, String businessId) =>
      appApiProvider.createRating(stars, review, userId, businessId);
  Future<List<Business>> search(String query) => appApiProvider.search(query);
}
