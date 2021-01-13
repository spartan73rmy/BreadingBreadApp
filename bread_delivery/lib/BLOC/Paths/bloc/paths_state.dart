part of 'paths_bloc.dart';

abstract class PathsState extends Equatable {
  const PathsState();

  @override
  List<Object> get props => [];
}

class PathsInitial extends PathsState {}

class PathsLoading extends PathsState {}

class PathsError extends PathsState {
  final MyException e;

  @override
  String toString() {
    return e.toString();
  }

  PathsError(this.e);
}

class PathsLoaded extends PathsState {
  final List<Path> paths;

  PathsLoaded(this.paths);
}

class PathOperationCompleted extends PathsState {}
