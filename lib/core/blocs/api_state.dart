import 'package:equatable/equatable.dart';

abstract class ApiState extends Equatable {
  final List _props;

  const ApiState([this._props = const <dynamic>[]]);

  @override
  List<Object> get props => [_props];
}

class ApiInitial extends ApiState {}

class ApiLoading extends ApiState {}

class ApiSuccess<T> extends ApiState {
  final T response;

  const ApiSuccess({
    required this.response,
  });

  @override
  List<Object> get props => [response as Object];
}

class ApiError extends ApiState {
  final String message;

  const ApiError({required this.message});

  @override
  List<Object> get props => [message];
}
