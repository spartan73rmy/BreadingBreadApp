part of 'paths_bloc.dart';

abstract class PathsEvent extends Equatable {
  const PathsEvent(List<Object> list);

  @override
  List<Object> get props => [];
}

class GetPaths extends PathsEvent {
  GetPaths() : super([]);
}

class AddPath extends PathsEvent {
  final String name;

  AddPath(this.name) : super([name]);
}

class EditPath extends PathsEvent {
  final String name;
  final int id;
  final bool selected;

  EditPath(this.name, this.id, this.selected) : super([name, id, selected]);
}
