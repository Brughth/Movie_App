part of 'carousel_cubit.dart';

@immutable
 class CarouselState {
  bool? scrollToNextPage;
  bool? scrollToPrecedentPage;
  int currentIndex;
  CarouselState({
    this.scrollToNextPage,
    this.scrollToPrecedentPage,
    required this.currentIndex,
  });
}
