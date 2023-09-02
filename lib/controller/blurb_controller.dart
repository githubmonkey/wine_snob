import '../data/repositories/blurb_repository_impl.dart';
import '../domain/repositories/abstract/blurb_repository.dart';

class BlurbController {
  final BlurbRepository blurbRepository = BlurbRepositoryImpl();

  Future<List<String>> getBlurbs(String description) {
    return blurbRepository.getBlurbs(description);
  }
}
