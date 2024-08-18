import 'package:bloc/bloc.dart';
import 'package:learn_pro/features/data/data_sources/local_storage.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    LocalStorage localStorage = LocalStorage();
    on<SplashEvent>((event, emit) {
      // TODO: implement event handler
    });

  }
}
