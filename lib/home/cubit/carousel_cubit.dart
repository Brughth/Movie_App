import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'carousel_state.dart';

class CarouselCubit extends Cubit<CarouselState> {
  CarouselCubit() : super(CarouselState(currentIndex: 0));

  void nextpage(int index) => emit(
        CarouselState(
          currentIndex: index,
          scrollToNextPage: true,
          scrollToPrecedentPage: false,
        ),
      );
  void decrement() => emit(
        CarouselState(
          currentIndex: state.currentIndex - 1,
          scrollToNextPage: false,
          scrollToPrecedentPage: true,
        ),
      );
}
