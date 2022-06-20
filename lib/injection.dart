import 'package:adopt/adopt.dart';
import 'package:petrivia/data/repositories/petrivia_repository_impl.dart';
import 'package:user/user.dart';
import 'package:schedule/schedule.dart';
import 'package:pet/pet.dart';
import 'package:petrivia/petrivia.dart';
import 'package:pet_map/pet_map.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:notification/data/data_sources/notification_data_source.dart';
import 'package:notification/domain/repositories/notification_repository.dart';
import 'package:notification/domain/usecases/get_list_notification_usecase.dart';
import 'package:notification/domain/usecases/send_adopt_notif_usecase.dart';
import 'package:notification/presentation/blocs/notification_bloc/notification_bloc.dart';
import 'package:notification/presentation/blocs/send_notif_bloc/send_notif_bloc.dart';
import 'package:notification/data/repositories/notification_repository_impl.dart';

final locator = GetIt.instance;

void init() {
  // repositoriy
  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(firebaseDataSource: locator()));
  locator.registerLazySingleton<PlanRepository>(
      () => PlanRepositoryImpl(planDataSource: locator()));
  locator.registerLazySingleton<TaskFirebaseRepository>(
      () => TaskFirebaseRepositoryImpl(taskFirebaseDataSource: locator()));
  locator.registerLazySingleton<PetRepository>(
      () => PetRepositoryImpl(petFirebaseDataSource: locator()));
  locator.registerLazySingleton<AdoptRepository>(
      () => AdoptRepositoryImpl(adoptDataSource: locator()));
  locator.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(notificationDataSource: locator()));
  locator.registerLazySingleton<PetriviaRepository>(
      () => PetriviaRepositoryImpl(petriviaDataSource: locator()));
  locator.registerLazySingleton<PetMapRepository>(
      () => PetMapRepositoryImpl(locator()));

  // datasource
  locator.registerLazySingleton<UserDataSource>(() => UserDataSourceImpl(
      firebaseAuth: locator(),
      firebaseFirestore: locator(),
      firebaseStorage: locator()));
  locator.registerLazySingleton<PlanDataSource>(
      () => PlanDataSourceImpl(firebaseFireStore: locator()));
  locator.registerLazySingleton<TaskFirebaseDataSource>(
      () => TaskFirebaseDataSourceImpl(taskFireStore: locator()));
  locator.registerLazySingleton<PetDataSource>(() => PetDataSourceImpl(
      firebaseFirestore: locator(), firebaseStorage: locator()));
  locator.registerLazySingleton<AdoptDataSource>(() => AdoptDataSourceImpl(
        firebaseFirestore: locator(),
        firebaseStorage: locator(),
        firebaseAuth: locator(),
      ));
  locator.registerLazySingleton<NotificationDataSource>(
      () => NotificationDataSourceImpl(firebaseFirestore: locator()));
  locator.registerLazySingleton<PetriviaDataSource>(
      () => PetrviaDataSourceImpl(firebaseFirestore: locator()));
  locator.registerLazySingleton<PetMapDataSource>(
      () => PetMapDataSourceImpl(locator()));
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
  locator.registerLazySingleton(
      () => AddPlanUsecase(firebaseRepository: locator()));
  locator.registerLazySingleton(
      () => AddTaskUseCase(firebaseRepository: locator()));
  locator.registerLazySingleton(() => AddPetUsecase(locator()));
  locator.registerLazySingleton(
      () => AddPetPhotoUsecase(petRepository: locator()));
  locator.registerLazySingleton(
      () => AddPetCertificateUsecase(petRepository: locator()));
  locator.registerLazySingleton(
      () => CreateNewAdoptUsecase(adoptRepository: locator()));
  locator.registerLazySingleton(() => SaveUserIdLocal(repository: locator()));
  locator.registerLazySingleton(
      () => RemoveUserIdLocalUsecase(userRepository: locator()));
  locator.registerLazySingleton(
      () => UploadPetAdoptPhotoUsecase(adoptRepository: locator()));
  locator.registerLazySingleton(
      () => UploadPetCertificateUsecase(adoptRepository: locator()));
  locator.registerLazySingleton(
      () => GetAllPetListUsecase(adoptRepository: locator()));
  locator.registerLazySingleton(
      () => GetPetDescriptionUsecase(adoptRepository: locator()));
  locator.registerLazySingleton(
      () => GetUserIdLocalUsecase(adoptRepository: locator()));
  locator.registerLazySingleton(
      () => UpdateAdoptUsecase(adoptRepository: locator()));
  locator.registerLazySingleton(
      () => GetListNotificationUsecase(notificationRepository: locator()));

  locator
      .registerLazySingleton(() => GetPlanUsecase(planRepository: locator()));

  locator.registerLazySingleton(() => GetPetriviaUsecase(locator()));

  locator.registerLazySingleton(() => GetOpenAdoptListUsecase(locator()));
  locator.registerLazySingleton(() => SaveDataLocalUsecase(locator()));
  locator.registerLazySingleton(() => GetUserDataLocalUsecase(locator()));
  locator.registerLazySingleton(() => RequestAdoptUsecase(locator()));
  locator.registerLazySingleton(() => RemoveOpenAdoptUsecase(locator()));
  locator.registerLazySingleton(() => GetTodayTaskUsecase(locator()));

  locator.registerLazySingleton(() => SendAdoptNotifUsecase(locator()));
  locator.registerLazySingleton(() => GetPetsUsecase(locator()));
  locator.registerLazySingleton(() => ChangeTaskStatusUsecase(locator()));
  locator.registerLazySingleton(() => GetMonthlyTaskUsecase(locator()));
  locator.registerLazySingleton(() => RemovePetUsecase(locator()));
  locator.registerLazySingleton(() => UpdatePetUsecase(locator()));
  locator.registerLazySingleton(() => CreatePetMapUsecase(locator()));
  locator.registerLazySingleton(() => RemovePetMapUsecase(locator()));
  locator.registerLazySingleton(() => GetAllPetMapUsecase(locator()));
  locator.registerLazySingleton(() => CheckPetMapUsecase(locator()));
  locator.registerLazySingleton(() => GetPetMapUsecase(locator()));
  locator.registerLazySingleton(() => UpdatePetMapUsecase(locator()));
  locator.registerLazySingleton(() => SearchPetAdoptUsecase(locator()));
  locator.registerLazySingleton(() => GetPlanHistoryUsecase(locator()));

  locator
      .registerLazySingleton(() => GetPetDescUsecase(petRepository: locator()));

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
      signOutUsecase: locator(),
      removeUserIdLocalUsecase: locator(),
      saveUserIdLocal: locator()));
  locator.registerFactory(() => UserDbBloc(
      getUserFromDb: locator(),
      deleteUserUsecase: locator(),
      saveUserDataLocalUsecase: locator()));
  locator.registerFactory(() => UserProfileBloc(
      uploadImageUsecase: locator(),
      updateUserDataUsecase: locator(),
      deleteOldImageUsecase: locator()));

  locator.registerFactory(() => TaskBloc(addTaskUsecase: locator()));
  locator.registerFactory(() => GetPetriviaBloc(getPetriviaUsecase: locator()));
  locator
      .registerFactory(() => GetAllPetMapBloc(getAllPetMapUsecase: locator()));

  locator.registerFactory(() => AddPetBloc(
        addPetUsecase: locator(),
        addPetCertificateUsecase: locator(),
        addPetPhotoUsecase: locator(),
      ));
  locator.registerFactory(() => OpenAdoptBloc(
      createNewAdoptUsecase: locator(),
      uploadPetPhoto: locator(),
      uploadPetCertificateUsecase: locator(),
      removeOpenAdoptUsecase: locator()));

  locator.registerFactory(() => DetailAdoptBloc(
        getPetDescriptionUsecase: locator(),
        getUserIdLocalUsecase: locator(),
        requestAdoptUsecase: locator(),
      ));
  locator.registerFactory(() => ListAdoptBloc(
      getAllPetListUsecase: locator(), searchPetAdoptUsecase: locator()));
  locator.registerFactory(() => UpdatePetBloc(
      addPetCertificateUsecase: locator(),
      addPetPhotoUsecase: locator(),
      updatePetUsecase: locator()));

  locator.registerFactory(() => EditAdoptBloc(
      updateAdoptUsecase: locator(),
      uploadPetCertificateUsecase: locator(),
      uploadPetPhoto: locator()));
  locator.registerFactory(
      () => NotificationBloc(getListNotificationUsecase: locator()));
  locator
      .registerFactory(() => OpenAdoptStatusBloc(getOpenAdoptList: locator()));
  locator
      .registerFactory(() => SendNotifBloc(sendAdoptNotifUsecase: locator()));
  locator.registerFactory(() => GetPetBloc(getPetUsecase: locator()));
  locator.registerFactory(() => GetSchedulePetBloc(getPetUsecase: locator()));
  locator.registerFactory(() => GetPetDescBloc(
      getPetDescUsecase: locator(),
      getTodayTaskUsecase: locator(),
      removePetUsecase: locator()));

  locator.registerFactory(() => GetTodayTaskBloc(
      getTodayTaskUsecase: locator(), changeTaskStatusUsecase: locator()));
  locator.registerFactory(() => DayPlanCalendarBloc(getPlanUsecase: locator()));
  locator.registerFactory(
      () => GetMonthlyTaskBloc(getMonthlyTaskUsecase: locator()));
  locator.registerFactory(
      () => GetPlanHistoryBloc(getPlanHistoryUsecase: locator()));
  locator.registerFactory(() => PetmapCubit(
      createPetMapUsecase: locator(),
      removePetMapUsecase: locator(),
      checkPetMapUsecase: locator(),
      updatePetMapUsecase: locator()));

  locator.registerFactory(() => GetPetMapBloc(getPetMapUsecase: locator()));
  locator.registerFactory(() => AddPlanCubit(addPlanUsecase: locator()));
  //external
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  locator.registerLazySingleton(() => auth);
  locator.registerLazySingleton(() => firestore);
  locator.registerLazySingleton(() => storage);
}
