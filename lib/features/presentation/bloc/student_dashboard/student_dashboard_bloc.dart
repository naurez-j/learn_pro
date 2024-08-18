import 'package:bloc/bloc.dart';
import 'package:learn_pro/features/data/repo_implementation/repo_impl.dart';
import 'package:learn_pro/features/domain/repository/repository.dart';
import 'package:learn_pro/features/domain/usecases/get_enrolled_courses_usecase.dart';
import 'package:meta/meta.dart';

import '../../../data/models/response/all_courses_response.dart';

part 'student_dashboard_event.dart';
part 'student_dashboard_state.dart';

class StudentDashboardBloc extends Bloc<StudentDashboardEvent, StudentDashboardState> {
  StudentDashboardBloc() : super(StudentDashboardInitial()) {
    RepoInitial repoInitial = RepoImpl();
    on<StudentDashboardStarted>((event, emit) async{
      GetEnrolledCoursesUsecase getEnrolledCoursesUsecase = GetEnrolledCoursesUsecase(repoInitial);
      emit(StudentDashboardLoading());
      try{
        final List<AllCoursesResponse>enrolledCourses;
        enrolledCourses = await getEnrolledCoursesUsecase.getCourses();
        emit(StudentDashboardSuccess(allCourses: enrolledCourses));
      }catch(e){
        print(e);
        emit(StudentDashboardFailed());
      }
    });
  }
}
