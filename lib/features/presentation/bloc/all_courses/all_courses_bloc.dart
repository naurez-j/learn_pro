import 'package:bloc/bloc.dart';
import 'package:learn_pro/features/domain/usecases/get_all_courses_usecase.dart';
import 'package:meta/meta.dart';

import '../../../data/models/response/all_courses_response.dart';
import '../../../data/repo_implementation/repo_impl.dart';
import '../../../domain/repository/repository.dart';

part 'all_courses_event.dart';

part 'all_courses_state.dart';

class AllCoursesBloc extends Bloc<AllCoursesEvent, AllCoursesState> {
  AllCoursesBloc() : super(AllCoursesInitial()) {
    RepoInitial repoInitial = RepoImpl();
    on<AllCoursesStartEvent>((event, emit) async {
      GetAllCourseUsecase getAllCourseUsecase =
          GetAllCourseUsecase(repoInitial);
      emit(AllCoursesLoading());
      try {
        final List<AllCoursesResponse> allCourses;
        allCourses = await getAllCourseUsecase.getCourses();
        emit(AllCoursesSuccess(allCourses: allCourses));
      } catch (e) {
        emit(AllCoursesFailed());
      }
    });
  }
}
