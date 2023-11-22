part of 'query_bloc.dart';

sealed class QueryState extends Equatable {
  const QueryState();

  @override
  List<Object> get props => [];
}

final class QueryInitial extends QueryState {}

final class ErrorState extends QueryState {}

final class SuccessState extends QueryState {
  final List<Map<String, dynamic>> products;
  SuccessState(this.products);
}

final class QueryLoading extends QueryState {}
