import '../../features/items/data/datasources/items_api_datasource.dart';
import '../../features/items/data/datasources/items_local_datasource.dart';
import '../../features/items/data/repositories/items_repository_impl.dart';
import '../../features/items/domain/repositories/items_repository.dart';
import '../../features/items/domain/usecases/get_items_usecase.dart';
import '../../features/items/domain/usecases/toggle_favorite_usecase.dart';
import '../../features/items/presentation/bloc/items_cubit.dart';

class InjectionContainer {
  static final InjectionContainer _instance = InjectionContainer._internal();
  factory InjectionContainer() => _instance;
  InjectionContainer._internal();

  // Data sources
  late final ItemsApiDataSource itemsApiDataSource = ItemsApiDataSourceImpl();
  late final ItemsLocalDataSource itemsLocalDataSource = ItemsLocalDataSourceImpl();

  // Repository
  late final ItemsRepository itemsRepository = ItemsRepositoryImpl(
    apiDataSource: itemsApiDataSource,
    localDataSource: itemsLocalDataSource,
  );

  // Use cases
  late final GetItemsUseCase getItemsUseCase = GetItemsUseCase(itemsRepository);
  late final ToggleFavoriteUseCase toggleFavoriteUseCase = ToggleFavoriteUseCase(itemsRepository);

  // BLoC/Cubit
  late final ItemsCubit itemsCubit = ItemsCubit(
    getItemsUseCase: getItemsUseCase,
    toggleFavoriteUseCase: toggleFavoriteUseCase,
  );

  void init() {
    // Initialize any dependencies that need initialization
  }
}
