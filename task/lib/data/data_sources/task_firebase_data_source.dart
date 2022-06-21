import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/data/models/date_task_model.dart';
import 'package:task/data/models/habbit_model.dart';
import 'package:task/data/models/task_model.dart';
import 'package:task/domain/entities/habbit_entity.dart';
import 'package:task/domain/entities/task_entity.dart';

abstract class TaskFirebaseDataSource {
  Future<bool> checkTaskExist(String petId, DateTime date);
  Future<void> transferTask(
      List<HabbitEntity> habbits, DateTime date, String petId);
  Stream<List<TaskEntity>> getTodayTask(String petId, DateTime date);
  Stream<List<TaskEntity>> getMonthlyTask(
      String petId, DateTime startDate, DateTime endDate);
  Future<void> changeTaskStatus(String taskId);
}

class TaskFirebaseDataSourceImpl implements TaskFirebaseDataSource {
  final FirebaseFirestore taskFirestore;

  TaskFirebaseDataSourceImpl({required this.taskFirestore});

  @override
  Future<void> changeTaskStatus(String taskId) async {
    final collectionRef = taskFirestore.collection('tasks');
    Map<String, dynamic>? doc =
        await collectionRef.doc(taskId).get().then((value) => value.data());
    bool status = doc!['complete_status'] == true ? false : true;
    final statusMap = {"complete_status": status};
    await collectionRef.doc(taskId).update(statusMap);
  }

  @override
  Future<bool> checkTaskExist(String petId, DateTime date) async {
    String dt = DateFormat.yMMMEd().format(date);
    // print(dt);
    final collectionRef = taskFirestore
        .collection('date_tasks')
        .where('pet_id', isEqualTo: petId)
        .where('date', isEqualTo: dt);
    return collectionRef.get().then((value) {
      // print(value.docs.isNotEmpty.toString());
      return value.docs.isNotEmpty;
    });
  }

  @override
  Stream<List<TaskEntity>> getMonthlyTask(
      String petId, DateTime startDate, DateTime endDate) {
    final taskCollection = taskFirestore
        .collection('tasks')
        .where('pet_id', isEqualTo: petId)
        .where('time',
            isGreaterThanOrEqualTo: startDate, isLessThanOrEqualTo: endDate);

    return taskCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnap) => TaskModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Stream<List<TaskEntity>> getTodayTask(String petId, DateTime date) {
    final taskCollection = taskFirestore
        .collection('tasks')
        .where('pet_id', isEqualTo: petId)
        .where('date', isEqualTo: DateFormat.yMMMEd().format(date));

    return taskCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnap) => TaskModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Future<void> transferTask(
      List<HabbitEntity> habbits, DateTime date, String petId) async {
    final taskRef = taskFirestore.collection('tasks');
    final taskDateRef = taskFirestore.collection('date_tasks');
    List<String> tasksId = [];
    for (var habbit in habbits) {
      final taskId = taskRef.doc().id;
      final habbitTime = habbit.time!.toDate();
      final newTask = TaskModel(
          id: taskId,
          completeStatus: false,
          title: habbit.title,
          petId: petId,
          date: DateFormat.yMMMEd().format(date),
          time: Timestamp.fromDate(DateTime(date.year, date.month, date.day,
              habbitTime.hour, habbitTime.minute)),
          activityType: habbit.activityType);
      taskRef.doc(taskId).get().then((value) {
        if (!value.exists) {
          taskRef.doc(taskId).set(newTask.toJson());
        }
      });
      tasksId.add(taskId);
    }

    final taskDataId = taskDateRef.doc().id;
    taskDateRef.doc(taskDataId).get().then((value) {
      final newDateTask = DateTaskModel(
          id: taskDataId,
          petId: petId,
          date: DateFormat.yMMMEd().format(date),
          listTaskId: tasksId);
      if (!value.exists) {
        taskDateRef.doc(taskDataId).set(newDateTask.toJson());
      }
    });
  }
}
