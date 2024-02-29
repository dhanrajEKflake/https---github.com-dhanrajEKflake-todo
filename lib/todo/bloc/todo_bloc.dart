import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_todo_app/todo/modal/task_modal.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final List<Task> todoList = [];
  int taskID = 0;

  TodoBloc() : super(TodoInitial()) {
    on<LoadTasksEvent>(loadTasksEvent);
    on<AddTaskEvent>(addTaskEvent);
    on<DeleteTaskEvent>(deleteTaskEvent);
    on<CompleteTaskEvent>(completeTaskEvent);
  }

  FutureOr<void> loadTasksEvent(LoadTasksEvent event, Emitter<TodoState> emit) {
    emit(TodoLoadingState());
    emit(TodoLoadedState(myTasks: todoList));
  }

  FutureOr<void> addTaskEvent(AddTaskEvent event, Emitter<TodoState> emit) {
    emit(TodoLoadingState());
    taskID = taskID + 1;
    Task task = Task(id: taskID, title: event.title, status: false);

    todoList.add(task);
    emit(TodoLoadedState(myTasks: todoList));
  }

  FutureOr<void> deleteTaskEvent(
      DeleteTaskEvent event, Emitter<TodoState> emit) {
    emit(TodoLoadingState());
    todoList.removeWhere((element) => element.id == event.taskID);
    emit(TodoLoadedState(myTasks: todoList));
  }

  FutureOr<void> completeTaskEvent(
      CompleteTaskEvent event, Emitter<TodoState> emit) {
    emit(TodoLoadingState());
    todoList.map((e) {
      if (e.id == event.taskID) {
        e.status = true;
        return e;
      }
    }).toList();

    emit(TodoLoadedState(myTasks: todoList));
  }
}
