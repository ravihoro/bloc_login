import 'package:bloc_login/features/authentication/data/data_source/authentication_data_source.dart';
import 'package:bloc_login/features/authentication/data/repository/authentication_repository_impl.dart';
import 'package:bloc_login/features/authentication/domain/usecase/login.dart';
import 'package:bloc_login/features/authentication/domain/usecase/sign_up.dart';
import 'package:bloc_login/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:bloc_login/features/login/presentation/bloc/login_cubit.dart';
import 'package:bloc_login/features/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init({
  bool isMock = false,
}) async {
  if (isMock) {
    sl.registerFactory(() => SignUpCubit());
    sl.registerFactory(() => LoginCubit());
  } else {
    sl.registerFactory(() => SignUpCubit());
    sl.registerFactory(() => LoginCubit());
    sl.registerFactory(
        () => AuthenticationCubit(login: sl<Login>(), signUp: sl<SignUp>()));

    sl.registerLazySingleton(() => Login(sl<AuthenticationRepositoryImpl>()));
    sl.registerLazySingleton(() => SignUp(sl<AuthenticationRepositoryImpl>()));
    sl.registerLazySingleton(
        () => AuthenticationRepositoryImpl(sl<AuthenticationDataSourceImpl>()));
    sl.registerLazySingleton(
        () => AuthenticationDataSourceImpl(sl<http.Client>()));
    sl.registerLazySingleton(() => http.Client());
  }
}
