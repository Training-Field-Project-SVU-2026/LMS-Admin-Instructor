import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lms_admin_instructor/core/services/local/cache_helper.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/dio_consumer.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/data/repository/instructor_admin_repository_impl.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/domain/repository/instructor_admin_repoditory.dart';
import 'package:lms_admin_instructor/features/auth/data/repositories/auth_admin_repository_impl.dart';
import 'package:lms_admin_instructor/features/auth/domain/repositories/auth_admin_repository.dart';
import 'package:lms_admin_instructor/features/auth/presentation/bloc/auth_admin_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/common/data/repository/quiz_repository_impl.dart';
import 'package:lms_admin_instructor/features/instructor/common/domain/repository/quiz_repository.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_quiz_bloc/course_quiz_bloc.dart';
import 'package:lms_admin_instructor/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:lms_admin_instructor/features/splash/domain/splash_repository.dart';
import 'package:lms_admin_instructor/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:lms_admin_instructor/features/admin/students_admin/data/repository/students_admin_repository_impl.dart';
import 'package:lms_admin_instructor/features/admin/students_admin/domain/repository/students_admin_repository.dart';
import 'package:lms_admin_instructor/features/admin/students_admin/presentation/bloc/student_admin_bloc.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/data/repository/courses_instructor_repository_impl.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/domain/repository/courses_instructor_repository.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/presentation/bloc/courses_instructor_bloc.dart';
import 'package:lms_admin_instructor/root/bloc/root_bloc.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Services
  final cacheHelper = CacheHelper();
  await cacheHelper.init();
  sl.registerLazySingleton<CacheHelper>(() => cacheHelper);

  // External
  sl.registerLazySingleton(() => Dio());

  // Remote package
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));

  // Features - Auth
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(apiConsumer: sl(), cacheHelper: sl()),
  );

  // Splash
  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(apiConsumer: sl(), cacheHelper: sl()),
  );
  sl.registerLazySingleton(() => SplashBloc(splashRepository: sl()));

  sl.registerLazySingleton(() => AuthBloc(authRepository: sl()));

  // Features - Students Admin
  sl.registerLazySingleton<StudentsAdminRepository>(
    () => StudentsAdminRepositoryImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton(
    () => StudentAdminBloc(studentsAdminRepository: sl()),
  );

  // Features - Instructor Admin
  sl.registerLazySingleton<InstructorAdminRepoditory>(
    () => InstructorAdminRepositoryImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton(
    () => InstructorAdminBloc(instructorAdminRepoditory: sl()),
  );

  // Features - Instructor 
  sl.registerLazySingleton<CoursesInstructorRepository>(
    () => CoursesInstructorRepositoryImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton(() => CoursesInstructorBloc(repository: sl()));
  
  // Features - Quiz
  sl.registerLazySingleton<QuizRepository>(
    () => QuizRepositoryImpl(apiConsumer: sl()),
  );
  sl.registerLazySingleton(() => CourseQuizBloc(quizRepository: sl()));

  // Root
  sl.registerLazySingleton(() => RootBloc());
}