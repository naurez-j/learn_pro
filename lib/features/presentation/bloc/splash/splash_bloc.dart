import 'package:bloc/bloc.dart';
import 'package:learn_pro/features/data/data_sources/local_storage.dart';
import 'package:learn_pro/features/data/data_sources/remote_datasource.dart';
import 'package:learn_pro/features/data/models/response/authenticate_user_response.dart';
import 'package:learn_pro/features/data/models/response/login_response_model.dart';
import 'package:learn_pro/utils/app_consts.dart';
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
          emit(SplashSuccess(tokenAvailable: token));
        }
        else{
          try{
            final AuthenticateUserResponse authenticateUserResponse = await remoteDataSource.authenticateUser(token);
            AppConst.token=token;
            AppConst.userId=authenticateUserResponse.id;
            AppConst.email=authenticateUserResponse.email;
            AppConst.name=authenticateUserResponse.name;
            AppConst.role=authenticateUserResponse.role;
            emit(SplashSuccess(tokenAvailable:authenticateUserResponse.role));
          }catch(e){
            emit(SplashFailed());
          }
        }

      }
      catch(e){
        emit(SplashFailed());
      }

    });

  }
}
