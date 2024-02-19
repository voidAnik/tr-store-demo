import 'package:equatable/equatable.dart';

abstract class DataState extends Equatable {
  final List _props;

  const DataState([this._props = const <dynamic>[]]);

  @override
  List<Object> get props => [_props];
}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataLoaded<T> extends DataState {
  final T response;

  const DataLoaded({
    required this.response,
  });

  @override
  List<Object> get props => [response as Object];
}

class DataError extends DataState {
  final String message;

  const DataError({required this.message});

  @override
  List<Object> get props => [message];
}
