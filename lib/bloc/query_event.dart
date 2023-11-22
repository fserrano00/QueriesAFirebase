part of 'query_bloc.dart';

sealed class QueryEvent extends Equatable {
  const QueryEvent();

  @override
  List<Object> get props => [];
}

class QueryEventSearch extends QueryEvent {
  final String query;

  QueryEventSearch({required this.query});

  @override
  List<Object> get props => [query];
}
