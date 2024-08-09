import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilUpdatedCubit extends Cubit<bool> {
  // Container container= Container();
  late bool isUpdated;

  ProfilUpdatedCubit() : super(false);

  void setTrue() {
    // container = Container(
    //   child: Text("true"),
    // );
    isUpdated = true;
    emit(isUpdated);
  }

  void setFalse() {
    // container = Container(
    //   child: Text("false"),
    // );
    // emit(container);
    isUpdated = false;
    emit(isUpdated);
  }
}
