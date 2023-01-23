import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvModel = TvModel(
    posterPath: "/esN3gWb1P091xExLddD2nh4zmi3.jpg",
    popularity: 37.882356,
    id: 62560,
    backdropPath: "/v8Y9yurHuI7MujWQMd8iL3Gy4B5.jpg",
    voteAverage: 7.5,
    overview:
        "A contemporary and culturally resonant drama about a young programmer, Elliot, who suffers from a debilitating anti-social disorder and decides that he can only connect to people by hacking them. He wields his skills as a weapon to protect the people that he cares about. Elliot will find himself in the intersection between a cybersecurity firm he works for and the underworld organizations that are recruiting him to bring down corporate America.",
    originCountry: ["US"],
    genreIds: [80, 18],
    originalLanguage: "en",
    voteCount: 287,
    name: "Mr. Robot",
    originalName: "Mr. Robot",
  );

  final tTv = Tv(
    posterPath: "/esN3gWb1P091xExLddD2nh4zmi3.jpg",
    popularity: 37.882356,
    id: 62560,
    backdropPath: "/v8Y9yurHuI7MujWQMd8iL3Gy4B5.jpg",
    voteAverage: 7.5,
    overview:
        "A contemporary and culturally resonant drama about a young programmer, Elliot, who suffers from a debilitating anti-social disorder and decides that he can only connect to people by hacking them. He wields his skills as a weapon to protect the people that he cares about. Elliot will find himself in the intersection between a cybersecurity firm he works for and the underworld organizations that are recruiting him to bring down corporate America.",
    originCountry: ["US"],
    genreIds: [80, 18],
    originalLanguage: "en",
    voteCount: 287,
    name: "Mr. Robot",
    originalName: "Mr. Robot",
  );

  test('should be a subclass of Movie entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
