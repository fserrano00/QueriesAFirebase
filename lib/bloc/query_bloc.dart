import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'query_event.dart';
part 'query_state.dart';

class QueryBloc extends Bloc<QueryEvent, QueryState> {
  QueryBloc() : super(QueryInitial()) {
    on<QueryEventSearch>(_handleRequestEvent);
  }

  Future<void> _handleRequestEvent(
    QueryEventSearch event,
    Emitter<QueryState> emit,
  ) async {
    emit(QueryLoading());
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('chats').get();

      List<Map<String, dynamic>> products = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      emit(SuccessState(products));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
