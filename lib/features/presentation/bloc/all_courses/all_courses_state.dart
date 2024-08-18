part of 'all_courses_bloc.dart';

@immutable
abstract class AllCoursesState {}

final class AllCoursesInitial extends AllCoursesState {}

class AllCoursesSuccess extends AllCoursesState{
  List<AllCoursesResponse>allCourses;
  AllCoursesSuccess({required this.allCourses});
}

class AllCoursesLoading extends AllCoursesState{}
class AllCoursesFailed extends AllCoursesState{}


