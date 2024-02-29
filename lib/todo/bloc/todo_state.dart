part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

final class TodoInitial extends TodoState {}

final class TodoLoadingState extends TodoState {}

final class TodoLoadedState extends TodoState {
  final List<Task> myTasks;

  const TodoLoadedState({required this.myTasks});
}

final class TodoErrorState extends TodoState {}
