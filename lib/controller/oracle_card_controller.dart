import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wine_snob/data/repositories/firebase_auth_repository.dart';
import 'package:wine_snob/data/repositories/oracles_repository.dart';
import 'package:wine_snob/domain/models/oracle.dart';

part 'oracle_card_controller.g.dart';

@riverpod
class OracleCardController extends _$OracleCardController {

  @override
  FutureOr<void> build() {
  }

  Future<void> updateOracle(
      {required OracleID oid, required Map<String, dynamic> data}) async {
    final oraclesRepository = ref.read(oraclesRepositoryProvider);
    final user = ref.read(authRepositoryProvider).currentUser!;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() =>
        oraclesRepository.updateOracle(uid: user.uid, oid: oid, data: data));
  }
}