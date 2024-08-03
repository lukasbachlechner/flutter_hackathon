import 'package:flame/components.dart';
import 'package:flame/game.dart';

const double _animationSpeed = 0.025;

Future<SpriteAnimationComponent> addAnimation(
  FlameGame game,
  Map<String, dynamic> selectedSprite,
) async {
  final gameSize = game.size;
  final size = Vector2.all(192.0);

  final animationComponent = SpriteAnimationComponent.fromFrameData(
    await game.images.load('${selectedSprite["name"]}.png'),
    SpriteAnimationData.sequenced(
      amount: selectedSprite["amount"],
      amountPerRow: selectedSprite["amountPerRow"],
      textureSize: size,
      stepTime: _animationSpeed,
      loop: false,
    ),
    size: size,
    removeOnFinish: true,
  );

  animationComponent.position = gameSize / 2 - (size / 2);

  return animationComponent;
}
