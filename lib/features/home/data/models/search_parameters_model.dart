class SearchParametersModel{
  final String searchWord;
  final bool desscendingPrice;
  final bool descendingRating;

  const SearchParametersModel({
    required this.searchWord,
    required this.desscendingPrice,
    required this.descendingRating,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchParametersModel &&
          runtimeType == other.runtimeType &&
          searchWord == other.searchWord &&
          desscendingPrice == other.desscendingPrice &&
          descendingRating == other.descendingRating);

  @override
  int get hashCode =>
      searchWord.hashCode ^ desscendingPrice.hashCode ^ descendingRating.hashCode;

  @override
  String toString() {
    return 'SearchParametersModel{' +
        ' searchWord: $searchWord,' +
        ' ascendingPrice: $desscendingPrice,' +
        ' ascendingRating: $descendingRating,' +
        '}';
  }

  SearchParametersModel copyWith({
    String? searchWord,
    bool? ascendingPrice,
    bool? ascendingRating,
  }) {
    return SearchParametersModel(
      searchWord: searchWord ?? this.searchWord,
      desscendingPrice: ascendingPrice ?? this.desscendingPrice,
      descendingRating: ascendingRating ?? this.descendingRating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'searchWord': this.searchWord,
      'ascendingPrice': this.desscendingPrice,
      'ascendingRating': this.descendingRating,
    };
  }

  factory SearchParametersModel.fromMap(Map<String, dynamic> map) {
    return SearchParametersModel(
      searchWord: map['searchWord'] as String,
      desscendingPrice: map['ascendingPrice'] as bool,
      descendingRating: map['ascendingRating'] as bool,
    );
  }
}