import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class FailureServer extends Failure {
  const FailureServer(super.message);
}

class FailureConnection extends Failure {
  const FailureConnection(super.message);
}

class FailureDatabase extends Failure {
  const FailureDatabase(super.message);
}
