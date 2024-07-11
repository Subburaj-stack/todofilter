import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_material_you/blocs/tasks/tasks_bloc.dart';
import 'package:todo_material_you/model/task.dart';
import 'package:todo_material_you/repositories/task_repository.dart';

// Mock TaskRepository for testing
class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  void main() {
    group('TasksBloc', () {
      late TasksBloc tasksBloc;
      late MockTaskRepository mockTaskRepository;

      setUp(() {
        mockTaskRepository = MockTaskRepository();
        tasksBloc = TasksBloc(mockTaskRepository);
      });

      tearDown(() {
        tasksBloc.close();
      });

      test('initial state is TasksLoaded with empty list', () {
        expect(tasksBloc.state, TasksLoaded(tasks: []));
      });

      test('emits TasksLoaded with initial tasks when LoadTask is added', () {
        final initialTasks = [
          Task(id: 1, userId: 1, title: 'Task 1', isComplete: false),
          Task(id: 2, userId: 1, title: 'Task 2', isComplete: false),
        ];

        // Simulate loading initial tasks from repository
        when(mockTaskRepository.getTask())
            .thenAnswer((_) async => initialTasks);

        // Expecting TasksLoaded state with initial tasks list
        final expectedResponse = emitsInOrder([
          TasksLoaded(tasks: []),
          TasksLoaded(tasks: initialTasks),
        ]);

        // Adding LoadTask event to the bloc
        tasksBloc.add(LoadTask());

        // Asserting that the bloc emits the expected states in order
        expectLater(tasksBloc.stream, expectedResponse);
      });

      test('emits TasksLoaded with task added when AddTask is added', () {
        final initialTasks = [
          Task(id: 1, userId: 1, title: 'Task 1', isComplete: false),
        ];

        final newTask =
            Task(id: 2, userId: 1, title: 'New Task', isComplete: false);

        // Simulate loading initial tasks from repository
        when(mockTaskRepository.getTask())
            .thenAnswer((_) async => initialTasks);

        // Expected tasks list after handling AddTask event
        final expectedUpdatedTasks = List<Task>.from(initialTasks)
          ..add(newTask);

        // Expecting TasksLoaded state with updated tasks list
        final expectedResponse = emitsInOrder([
          TasksLoaded(tasks: initialTasks),
          TasksLoaded(tasks: expectedUpdatedTasks),
        ]);

        // Adding AddTask event to the bloc
        tasksBloc.add(AddTask(task: newTask));

        // Asserting that the bloc emits the expected states in order
        expectLater(tasksBloc.stream, expectedResponse);
      });

      test('emits TasksLoaded with task deleted when DeleteTask is added', () {
        final initialTasks = [
          Task(id: 1, userId: 1, title: 'Task 1', isComplete: false),
          Task(id: 2, userId: 1, title: 'Task 2', isComplete: false),
        ];

        final taskToDelete = initialTasks.firstWhere((task) => task.id == 1);

        // Simulate loading initial tasks from repository
        when(mockTaskRepository.getTask())
            .thenAnswer((_) async => initialTasks);

        // Expected tasks list after handling DeleteTask event
        final expectedUpdatedTasks =
            initialTasks.where((task) => task.id != taskToDelete.id).toList();

        // Expecting TasksLoaded state with updated tasks list
        final expectedResponse = emitsInOrder([
          TasksLoaded(tasks: initialTasks),
          TasksLoaded(tasks: expectedUpdatedTasks),
        ]);

        // Adding DeleteTask event to the bloc
        tasksBloc.add(DeleteTask(task: taskToDelete));

        // Asserting that the bloc emits the expected states in order
        expectLater(tasksBloc.stream, expectedResponse);
      });
    });
  }
}
