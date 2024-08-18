part of 'student_dashboard_bloc.dart';

@immutable
abstract class StudentDashboardState {}

final class StudentDashboardInitial extends StudentDashboardState {}

class StudentDashboardSuccess extends StudentDashboardState{
  final List<AllCoursesResponse>allCourses;
  StudentDashboardSuccess({required this.allCourses});
}
class StudentDashboardLoading extends StudentDashboardState{}
class StudentDashboardFailed extends StudentDashboardState{}
