import 'package:bloc/bloc.dart';
import 'package:learn_pro/features/data/data_sources/local_storage.dart';
import 'package:learn_pro/features/data/data_sources/remote_datasource.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    LocalStorage localStorage = LocalStorage();
    RemoteDataSource remoteDataSource = RemoteDataSource();
    on<SplashStarted>((event, emit) async{
      emit(SplashLoading());
      try{
        String token = await localStorage.getAuthToken();
        print(token);

        if(token=='no_token'){
          emit(SplashSuccess());
        }

      }
      catch(e){
        emit(SplashFailed());
      }

    });

  }
}
