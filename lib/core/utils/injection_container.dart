import 'package:bloc_login/features/sign_up/data/data_source/sign_up_data_source.dart';
import 'package:bloc_login/features/sign_up/data/repository/sign_up_repository_impl.dart';
import 'package:bloc_login/features/sign_up/domain/usecase/sign_up_usecase.dart';
import 'package:bloc_login/features/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => SignUpCubit(usecase: sl()));

  sl.registerLazySingleton(() => SignUpUsecase(signUpRepository: sl()));

  sl.registerLazySingleton(() => SignUpRepositoryImpl(dataSource: sl()));

  sl.registerLazySingleton(() => SignUpDataSourceImpl(client: sl()));

  sl.registerLazySingleton(() => http.Client());
}
