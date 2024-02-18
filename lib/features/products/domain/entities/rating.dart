import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  final num rate;
  final int count;
  const Rating({required this.rate, required this.count});

  @override
  List<Object?> get props => [rate, count];
}
