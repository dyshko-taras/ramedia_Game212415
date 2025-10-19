// path: lib/logic/cubits/info_cubit.dart
import 'package:code/constants/app_images.dart';
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
    const items = <InfoItem>[
      InfoItem(
        title: 'BLUE SWIRL\nCANDY',
        description:
            'One interesting fact is that its ocean-like waves symbolize endless sweetness, making it feel like diving into a sea of sugar.',
        imagePath: AppImages.candyBlueSwirl,
      ),
      InfoItem(
        title: 'PINK SWIRL\nCANDY',
        description:
            'One interesting fact is that giant pink swirls were once carnival classics, crafted to look as fun as they taste.',
        imagePath: AppImages.candyPinkSwirl,
      ),
      InfoItem(
        title: 'SKY BLUE\nCANDY',
        description:
            'One interesting fact is that blue sweets often trick your taste buds — many are raspberry-flavored, not blueberry.',
        imagePath: AppImages.candySkyBlue,
      ),
      InfoItem(
        title: 'GREEN\nCANDY',
        description:
            'One interesting fact is that green candies are often minty or lime-flavored, refreshing and energizing with every bite.',
        imagePath: AppImages.candyGreen,
      ),
      InfoItem(
        title: 'PURPLE\nCANDY',
        description:
            'One interesting fact is that spiral designs are made to catch the eye, promising endless fun and flavor.',
        imagePath: AppImages.candyPurple,
      ),
      InfoItem(
        title: 'COOL\nCANDY',
        description:
            'One interesting fact is that pink treats became popular because their playful color is linked with joy and celebration.',
        imagePath: AppImages.candyCool,
      ),
      InfoItem(
        title: 'TURQUOISE\nCANDY',
        description:
            'One interesting fact is that rare candy shades like turquoise were made to stand out, shining like hidden gems in a candy shop.',
        imagePath: AppImages.candyTurquoise,
      ),
      InfoItem(
        title: 'YELLOW\nCANDY',
        description:
            'One interesting fact is that yellow sweets add a zingy lemon kick, balancing sugar rush with tangy freshness.',
        imagePath: AppImages.candyYellow,
      ),
      InfoItem(
        title: 'RED\nCANDY',
        description:
            'One interesting fact is that red candies symbolize love and passion, often being the very first flavor to sell out.',
        imagePath: AppImages.candyRed,
      ),
      InfoItem(
        title: 'PUPLE 2\nCANDY',
        description:
            'One interesting fact is that purple candies often taste of berries, but their rich color has long been linked to royalty.',
        imagePath: AppImages.candyPurple,
      ),
    ];

    emit(InfoState(items: items));
  }
}
