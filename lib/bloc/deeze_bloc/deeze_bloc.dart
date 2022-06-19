import 'package:bloc/bloc.dart';

import 'deeze_event.dart';
import 'deeze_repository.dart';
import 'deeze_state.dart';

class DeezeBloc extends Bloc<DeezeEvent, DeezeState> {
  DeezeRepository _DeezeRepository = DeezeRepository();
  DeezeBloc() : super(const LoadingDeeze()) {
    on<LoadDeeze>(((event, emit) async {
      final type = event.type;
      emit(await _DeezeRepository.getCategories(type));
    }));
  }
}
