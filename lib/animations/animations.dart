import 'package:flame/components.dart';
import 'package:flame/game.dart';

const double _animationSpeed = 0.025;

Future<SpriteAnimationComponent> getAnimation(
  FlameGame game,
  Vector2 position,
  Vector2 size,
  Map<String, dynamic> selectedSprite,
) async {
  final animationComponent = SpriteAnimationComponent.fromFrameData(
    await game.images.load('${selectedSprite["name"]}.png'),
    SpriteAnimationData.sequenced(
      amount: selectedSprite["amount"],
      amountPerRow: selectedSprite["amountPerRow"],
      textureSize: size,
      stepTime: _animationSpeed,
      // loop: false,
    ),
    size: size,
    removeOnFinish: false,
  );

  animationComponent.position = position;

  return animationComponent;
}
