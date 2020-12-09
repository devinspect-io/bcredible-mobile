import 'dart:async';

import 'package:rxdart/rxdart.dart';
import '../models/business.dart';
import '../persistence/repository.dart';

class BusinessBloc {
  Repository _repository = Repository();

  // Create a PublicSubject object responsible to add the data which is got from
  // the server in the form of Report object and pass it to the UI screen as a stream.
  final _businessFetcher = PublishSubject<List<Business>>();
  
  //This method is used to pass the response as stream to UI
  Stream<List<Business>> get result => _businessFetcher.stream;

  fetchBusinesses(String city) async {
    List<Business> businessResponse = await _repository.fetchBusinesses(city);
    _businessFetcher.sink.add(businessResponse);
  }

  dispose() {
    _businessFetcher.close();
  }
}

final businessBloc = BusinessBloc();
