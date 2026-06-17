# Flutter Moving Background

A high-performance Flutter package for creating beautiful, customizable moving backgrounds.

See an Example here : https://movingbg.netlify.app/

![Example GIF](gifs/example.gif)

## Features

- [X] **High Performance**: Optimized with a single `Ticker`, `CustomPainter`, and zero-allocation paint loops for smooth 60fps+ animations.
- [X] **Shader Caching**: Highly optimized parallax trail rendering in rain animations to prevent frame drops.
- [X] **Beautiful Presets**: Built-in design presets (`sunset`, `aurora`, `cyberpunk`, `themed`).
- [X] **Multiple Background Styles**: Includes `MovingBackground`, `BubbleBackground`, `RainBackground`, `ConstellationBackground`, and `WaveBackground`.
- [X] **Pause/Resume**: Easily pause animations when not needed to save battery.
- [X] **Customizable**: Control colors, radius, blur, speed, and more.
- [X] **Lightweight**: Minimal impact on your app's widget tree (zero dependencies outside Flutter).

## Supported Platforms

- Flutter Android
- Flutter iOS
- Flutter Web
- Flutter Desktop

## Getting started

In your flutter project add the dependency:

```yaml
dependencies:
  flutter_moving_background: ^0.2.0
```

Import the package:

```dart
import 'package:flutter_moving_background/flutter_moving_background.dart';
```

## How to use

### 1. Moving Circles Presets (One-Liners)

Create beautiful glowing backgrounds instantly using const preset constructors:

```dart
// Warm sunset oranges & deep purples
MovingBackground.sunset(child: YourWidget())

// Neon green & dark space blue auroras
MovingBackground.aurora(child: YourWidget())

// Electric magenta & neon cyan cyberpunk theme
MovingBackground.cyberpunk(child: YourWidget())

// Theme-aware color schemes (inherits primary/secondary/tertiary colors from active ThemeData)
MovingBackground.themed(context, child: YourWidget())
```

### 2. Custom Moving Circles

```dart
MovingBackground(
  backgroundColor: Colors.white,
  animationType: AnimationType.pulse,
  duration: Duration(seconds: 10),
  circles: const [
    MovingCircle(color: Colors.purple, radius: 300),
    MovingCircle(color: Colors.deepPurple, radius: 500),
    MovingCircle(color: Colors.orange, radius: 400),
  ],
  child: Center(child: Text("Hello World")),
)
```

### 3. Constellation Background (Interactive Particle Web)

A tech-oriented particle system where floating nodes slowly move. Nearby nodes are connected by dynamic, distance-based web lines. Includes mouse hover / touch attraction.

```dart
ConstellationBackground(
  particleCount: 50,
  maxDistance: 120.0,
  speed: 1.0,
  colors: const [Colors.cyanAccent, Colors.pinkAccent],
  lineColor: Colors.white12,
  child: YourWidget(),
)
```

### 4. Flowing Waves Background

Layered sine waves that flow horizontally with parallax speeds and customizable wave heights/amplitudes for soothing fluid landscape aesthetics.

```dart
WaveBackground(
  waveCount: 3,
  speed: 1.0,
  amplitude: 25.0,
  frequency: 0.005,
  colors: const [Colors.blue, Colors.teal, Colors.cyan],
  child: YourWidget(),
)
```

### 5. Bubble Background

```dart
BubbleBackground(
  numBubbles: 15,
  colors: [Colors.blue, Colors.purple],
  speed: 1.5,
  child: YourWidget(),
)
```

### 6. Rain Background

```dart
RainBackground(
  numberOfDrops: 100,
  fallSpeed: 2.0,
  hasTrail: true,
  colors: const [Colors.blue],
  child: YourWidget(),
)
```

## Animation Types

| Type | Description |
| --- | --- |
| `moveAndFade` | Circles move to random positions while fading in and out. |
| `pulse` | Circles move while their size and opacity pulse rhythmically. |
| `scale` | Circles scale from zero to full size and back as they move. |
| `move` | Circles move at constant opacity and size. |

## Contributing

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue][issue].  
If you fixed a bug or implemented a feature, please send a [pull request][pr].

[issue]: https://github.com/IldySilva/flutter_moving_background/issues
[pr]: https://github.com/IldySilva/flutter_moving_background/pulls
