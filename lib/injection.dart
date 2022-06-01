import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:user/data/data_sources/user_firebase_data_source.dart';
import 'package:user/data/repositories/user_firebase_repository_impl.dart';
import 'package:user/domain/repositories/user_firebase_repository.dart';
import 'package:user/domain/usecases/auth_usecases/delete_user_usecase.dart';
import 'package:user/domain/usecases/auth_usecases/get_user_id_usecase.dart';
import 'package:user/domain/usecases/auth_usecases/is_sign_in_usecase.dart';
import 'package:user/domain/usecases/auth_usecases/reset_password_usecase.dart';
import 'package:user/domain/usecases/auth_usecases/sign_in_usecase.dart';
import 'package:user/domain/usecases/auth_usecases/sign_in_with_google_usecase.dart';
import 'package:user/domain/usecases/auth_usecases/sign_out_usecase.dart';
import 'package:user/domain/usecases/auth_usecases/sign_up_usecase.dart';
import 'package:user/domain/usecases/auth_usecases/verify_email_usecase.dart';
import 'package:user/domain/usecases/firestore_usecases/delete_old_image_usecase.dart';
import 'package:user/domain/usecases/firestore_usecases/get_current_user_usecase.dart';
import 'package:user/domain/usecases/firestore_usecases/save_user_data_usecase.dart';
import 'package:user/domain/usecases/firestore_usecases/update_user_data_usecase.dart';
import 'package:user/domain/usecases/storage_usecases/upload_image_usecase.dart';
import 'package:user/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:user/presentation/blocs/reset_password_bloc/reset_password_bloc.dart';
import 'package:user/presentation/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:user/presentation/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:user/presentation/blocs/user_db_bloc/user_db_bloc.dart';
import 'package:user/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';

final locator = GetIt.instance;

void init() {
  // repositoriy
  locator.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(firebaseDataSource: locator()));

  // datasource
  locator.registerLazySingleton<FirebaseDataSource>(() =>
      FirebaseDataSourceImpl(
          firebaseAuth: locator(),
          firebaseFirestore: locator(),
          firebaseStorage: locator()));

  // usecases
  locator.registerLazySingleton(
      () => SignInUsecase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => IsSignInUsecase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => GetUserIdUsecase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => SignOutUsecase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => SignUpUsecase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => GetCurrentUserUsecase(firebaseRepository: locator()));
  locator
      .registerLazySingleton(() => SaveUserData(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => UploadImageUsecase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => UpdateUserDataUsecase(firebaseRepository: locator()));
  locator.registerLazySingleton(() => DeleteOldImageUsecase(locator()));
  locator.registerLazySingleton(
      () => SignInWithGoogle(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => ResetPasswordUsecase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => VerifyEmailUsecase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => DeleteUserUsecase(firebaseRepository: locator()));

  // bloc & cubit
  locator.registerFactory(
      () => SignInBloc(signInUsecase: locator(), signInWithGoogle: locator()));
  locator.registerFactory(() => SignUpBloc(
      signUpUsecase: locator(),
      saveUserData: locator(),
      verifyEmailUsecase: locator()));
  locator.registerFactory(
      () => ResetPasswordBloc(resetPasswordUsecase: locator()));
  locator.registerFactory(() => AuthCubit(
      isSignInUsecase: locator(),
      getUserIdUsecase: locator(),
      signOutUsecase: locator()));
  locator.registerFactory(
      () => UserDbBloc(getUserFromDb: locator(), deleteUserUsecase: locator()));
  locator.registerFactory(() => UserProfileBloc(
      uploadImageUsecase: locator(),
      updateUserDataUsecase: locator(),
      deleteOldImageUsecase: locator()));

  //external
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  locator.registerLazySingleton(() => auth);
  locator.registerLazySingleton(() => firestore);
  locator.registerLazySingleton(() => storage);
}