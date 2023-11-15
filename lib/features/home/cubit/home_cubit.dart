import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:traka/core/services/ably_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AblyService ablyService;
  HomeCubit(this.ablyService) : super(HomeInitial());
}
