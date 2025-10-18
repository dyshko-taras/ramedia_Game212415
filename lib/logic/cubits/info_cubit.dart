// path: lib/logic/cubits/info_cubit.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoItem extends Equatable {
  const InfoItem({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  final String title;
  final String description;
  final String imagePath;

  @override
  List<Object?> get props => <Object?>[title, description, imagePath];
}

/// Info screen state: list of items.
class InfoState extends Equatable {
  const InfoState({required this.items});
  final List<InfoItem> items;

  InfoState copyWith({List<InfoItem>? items}) =>
      InfoState(items: items ?? this.items);

  @override
  List<Object?> get props => <Object?>[items];
}

class InfoCubit extends Cubit<InfoState> {
  InfoCubit() : super(const InfoState(items: <InfoItem>[]));

  Future<void> loadItems() async {
    emit(const InfoState(items: <InfoItem>[]));
  }
}
