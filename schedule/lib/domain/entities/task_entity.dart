import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String? petId;
  final String? activity;
  final Timestamp? startTime;
  final Timestamp? endTime;
  final String repeat;
  final String description;
  final String status;

  TaskEntity({
    this.petId,
    required this.activity,
    required this.startTime,
    required this.endTime,
    required this.repeat,
    required this.description,
    required this.status
  });

  @override
  List<Object?> get props =>
      [petId, activity, repeat, description, startTime, endTime, status];
}