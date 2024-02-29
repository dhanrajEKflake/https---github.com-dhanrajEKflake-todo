import 'package:flutter/material.dart';
import 'package:flutter_application_todo_app/todo/bloc/todo_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController taskController = TextEditingController();
  final TodoBloc todoBloc = TodoBloc();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    taskController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => todoBloc..add(LoadTasksEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
        ),
        body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
          if (state is TodoLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is TodoLoadedState) {
            return state.myTasks.isEmpty
                ? const Center(
                    child: Text('No todo available'),
                  )
                : ListView.builder(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    itemCount: state.myTasks.length,
                    itemBuilder: (context, index) {
                      return TodoTileWidget(
                        title: state.myTasks[index].title,
                        status: state.myTasks[index].status,
                        onTapComplete: () {
                          todoBloc.add(CompleteTaskEvent(
                              taskID: state.myTasks[index].id));
                        },
                        onTapDelete: () {
                          todoBloc.add(
                              DeleteTaskEvent(taskID: state.myTasks[index].id));
                        },
                      );
                    });
          }
          return const SizedBox();
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => SimpleDialog(
                      title: const Text('Add Todo'),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            controller: taskController,
                            decoration: InputDecoration(
                                hintText: 'Enter Text',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                )),
                          ),
                        ),
                        Container(
                          width: 40,
                          alignment: Alignment.centerRight,
                          margin: const EdgeInsets.only(right: 10, top: 20),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)))),
                              onPressed: () {
                                todoBloc.add(
                                    AddTaskEvent(title: taskController.text));
                                taskController.clear();
                                Navigator.pop(context);
                              },
                              child: const Text('ADD')),
                        )
                      ],
                    ));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class TodoTileWidget extends StatelessWidget {
  const TodoTileWidget(
      {super.key,
      required this.title,
      required this.status,
      required this.onTapComplete,
      required this.onTapDelete});
  final String title;
  final bool status;
  final VoidCallback onTapComplete;
  final VoidCallback onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.brown.shade200),
          borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(status ? 'Status: Completed' : 'Status: On Going'),
            Row(
              children: [
                !status
                    ? GestureDetector(
                        onTap: onTapComplete,
                        child: Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.brown.shade200),
                          child: const Center(
                            child: Text(
                              'Complete',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                SizedBox(
                  width: !status ? 10 : 0,
                ),
                GestureDetector(
                  onTap: onTapDelete,
                  child: Container(
                    width: 60,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.brown.shade200),
                    child: const Center(
                      child: Text(
                        'Delete',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
