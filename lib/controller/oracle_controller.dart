import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wine_snob/data/repositories/blurb_repository_impl.dart';
import 'package:wine_snob/data/repositories/firebase_auth_repository.dart';
import 'package:wine_snob/data/repositories/oracles_repository.dart';
import 'package:wine_snob/domain/models/oracle.dart';

part 'oracle_controller.g.dart';

@riverpod
class OracleController extends _$OracleController {
  String _description = '';

  Future<List<Oracle>> _fetchOracle() async {
    if (_description.isEmpty) return [];

    final oraclesRepository = ref.read(oraclesRepositoryProvider);
    final blurbRepository = BlurbRepositoryImpl();
    final user = ref.read(authRepositoryProvider).currentUser!;
    final blurbs = await blurbRepository.getBlurbs(_description);
    final oracles = blurbs.map((elem) {
      final oracle = oraclesRepository.createOracle(
          uid: user.uid, input: _description, output: elem);
      oraclesRepository.setOracle(uid: user.uid, oracle: oracle);
      return oracle;
    }).toList();
    return oracles;
  }

  @override
  FutureOr<List<Oracle>> build() {
    return _fetchOracle();
  }

  Future<void> updateOracles(String description) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      _description = description;
      return _fetchOracle();
    });
  }
}
