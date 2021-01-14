import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bread_delivery/Entities/path.dart';
import 'package:bread_delivery/Services/Http/networkError.dart';
import 'package:bread_delivery/Services/Path/pathRepository.dart';
import 'package:equatable/equatable.dart';

part 'paths_event.dart';
part 'paths_state.dart';

class PathsBloc extends Bloc<PathsEvent, PathsState> {
  final PathsLogic logic;

  PathsBloc(this.logic) : super(PathsInitial());

  @override
  Stream<PathsState> mapEventToState(
    PathsEvent event,
  ) async* {
    if (event is GetPaths) {
      yield PathsLoading();
      try {
        var paths = await logic.fetchPathsList();
        if (paths != null) {
          yield PathsLoaded(paths);
        }
        yield PathsLoaded(List<Path>());
      } catch (e) {
        if (e is MyException && e != null) yield PathsError(e);
        yield PathsLoaded(List<Path>());
      }
    }

    if (event is AddPath) {
      yield PathsLoading();
      try {
        await logic.addPath(event.name);
        yield PathOperationCompleted();
      } catch (e) {
        if (e is MyException && e != null) yield PathsError(e);
        yield PathsLoaded(List<Path>());
      }
    }
    if (event is EditPath) {
      yield PathsLoading();
      try {
        await logic.editPath(event.id, event.name);
        yield PathOperationCompleted();
      } catch (e) {
        if (e is MyException && e != null) yield PathsError(e);
        yield PathsLoaded(List<Path>());
      }
    }

    if (event is DeletePath) {
      yield PathsLoading();
      try {
        await logic.deletePath(event.id);
        yield PathOperationCompleted();
      } catch (e) {
        if (e is MyException && e != null) yield PathsError(e);
        yield PathsLoaded(List<Path>());
      }
    }
  }
}
