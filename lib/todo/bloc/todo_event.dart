part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTasksEvent extends TodoEvent {
  // final List<Task> myTasks;

  // const LoadTasksEvent({required this.myTasks});
}

class AddTaskEvent extends TodoEvent {
  final String title;

  const AddTaskEvent({required this.title});
}

class CompleteTaskEvent extends TodoEvent {
  final int taskID;

  const CompleteTaskEvent({required this.taskID});
}

class DeleteTaskEvent extends TodoEvent {
  final int taskID;

  const DeleteTaskEvent({required this.taskID});
}
