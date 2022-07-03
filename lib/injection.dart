import 'package:get_it/get_it.dart';
import './common/api_url.dart';
import './common/helper_local.dart';
import './data/datasources/creator_remote.dart';
import './data/datasources/product_remote_db.dart';
import './data/datasources/auth_remote.dart';
import './data/datasources/search_remote.dart';
import './data/datasources/user_remote_db.dart';
import './data/datasources/wishlist_remote.dart';
import './data/repository_impl/auth_impl.dart';
import './data/repository_impl/creator_impl.dart';
import './data/repository_impl/search_impl.dart';
import './data/repository_impl/user_impl.dart';
import './data/repository_impl/wishlist_impl.dart';
import './domain/repository/auth_repository.dart';
import './domain/repository/creator_repository.dart';
import './domain/repository/product_repository.dart';
import './domain/repository/search_repository.dart';
import './domain/repository/user_repository.dart';
import './domain/repository/wishlist_repository.dart';
import './domain/user_case/add_wishlist.dart';
import './domain/user_case/delete_wishlist.dart';
import './domain/user_case/get_creator.dart';
import './domain/user_case/get_creator_collection.dart';
import './domain/user_case/get_product_detail.dart';
import './domain/user_case/get_products.dart';
import './domain/user_case/get_user.dart';
import 'package:http/http.dart' as http;
import './domain/user_case/get_wishlist.dart';
import './domain/user_case/login_auth.dart';
import './domain/user_case/search_product.dart';
import './presentation/provider/creator_nothifier.dart';
import './presentation/provider/detail_product_nothifier.dart';
import './presentation/provider/nitifikasi_nothifier.dart';
import './presentation/provider/wishlist_nothifier.dart';
import 'common/notif_local.dart';
import 'data/repository_impl/product_impl.dart';
import 'domain/user_case/singup_auth.dart';
import 'presentation/provider/home_nothifier.dart';
import 'presentation/provider/login_nothifier.dart';
import 'presentation/provider/profile_nothifier.dart';
import 'presentation/provider/search_nothifier.dart';

final GetIt locator = GetIt.instance;

void init() async {
  // provider
  locator.registerFactory(() => HomeNotifier(locator(), locator(),locator()));
  locator.registerFactory(() => ProfileNothifier(locator(), locator()));
  locator.registerFactory(() => ProductDetailNothifier(locator()));
  locator
      .registerFactory(() => LoginNothifier(locator(), locator(), locator()));
  locator.registerFactory(() => SearchNothifier(locator(),locator()));
  locator
      .registerFactory(() => CreatorNothifier(locator(), locator(), locator()));
  locator.registerFactory(
      () => WishlistNothifier(locator(), locator(), locator(), locator()));
  locator.registerFactory(() => NotifikasiNothifier());

  // use case
  locator
      .registerLazySingleton(() => GetProducts(productRepository: locator()));
  locator.registerLazySingleton(() => GetProductDetail(locator()));
  locator.registerLazySingleton(() => GetUser(userRepository: locator()));
  locator.registerLazySingleton(() => LoginAuth(locator()));
  locator.registerLazySingleton(() => SingUpAuth(locator()));
  locator.registerLazySingleton(() => GetCreator(locator()));
  locator.registerLazySingleton(() => GetCreatorCollection(locator()));
  locator.registerLazySingleton(() => GetWislist(locator()));
  locator.registerLazySingleton(() => AddWishlist(locator()));
  locator.registerLazySingleton(() => DeleteWishlist(locator()));
  locator.registerLazySingleton(() => SearchProductUseCase(locator()));

  // repository
  locator.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userRemoteDataSource: locator()));
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(locator()));
  locator.registerLazySingleton<CreatorRepository>(
      () => CreatorRepositoryImpl(locator()));
  locator.registerLazySingleton<WishlistRepository>(
      () => WishlistRepositoryImpl(locator()));
  locator.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(locator()));

  // data source
  locator.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(apiUrl: locator(), client: locator()));
  locator.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: locator(), apiUrl: locator()));
  locator.registerLazySingleton<AuthRemoteRepository>(
      () => AuthRemoteRepositoryImpl(locator(), locator(), locator()));
  locator.registerLazySingleton<CreatorRemoteRepository>(
      () => CreatorRemoteRepositoryImpl(locator(), locator()));
  locator.registerLazySingleton<WishlistRemoteSource>(
      () => WishlistRemoteSourceImpl(locator(), locator()));
  locator.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(locator(), locator()));

  // helper
  locator.registerLazySingleton(() => HelperLocal());
  locator.registerLazySingleton(() => NothifLocal());

  // External
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => ApiUrl());
}
