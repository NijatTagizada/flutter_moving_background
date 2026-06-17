# AGENTS.md

Guide for AI agents and contributors working on **flutter_moving_background** — a high-performance, light, and beautiful moving background package for Flutter.

## Philosophy

- **Performant by default.** All moving elements must avoid triggering widget tree rebuilds. We use a single `Ticker` combined with a `ValueNotifier` passed to the `CustomPainter`'s `repaint` listener to directly paint updates onto the canvas. Do NOT call `setState()` inside the animation tickers.
- **Lightweight.** The package has zero external dependencies outside of the core Flutter SDK. Keep it this way. All components should have a clean, focused, and predictable API surface.
- **Beautiful & Modern.** Leverage smooth transitions, HSL color ranges, glassmorphism-friendly blurs (`MaskFilter.blur`), and physics/kinematics simulations (bouncing, parallax layers, and random-walk interpolations with curves) to create high-end visual aesthetics.

---

## Core Surfaces & Widgets

### 1. Moving Circles (`MovingBackground`)
- **Visuals:** A soft, glowing, glassmorphic backdrop with randomly moving circles that smoothly fade, pulse, or scale.
- **Logic:** Each circle's movement targets a random point, interpolating via `Curves.easeInOut` over the configured duration.
- **Gotcha:** Uses `MaskFilter.blur(BlurStyle.normal, circle.config.blurSigma)` for the glow/blur effect. Be careful when updating `MaskFilter` as it is rendered on the GPU; keep the blur sigmas at reasonable levels to avoid overloading low-end devices.

### 2. Bouncing Bubbles (`BubbleBackground`)
- **Visuals:** Sharp or blurred bubbles that move inside a bounding box and bounce when they hit screen edges.
- **Logic:** Keeps track of velocities (`Offset`) and does elastic reflections (inverts `dx`/`dy`) upon boundaries contact.
- **Gotcha:** Boundary bounds check compares `position.dx` / `position.dy` against the constraints size `_lastSize`. Make sure to handle null size states gracefully when the widget is first laid out.

### 3. Parallax Rain (`RainBackground` and `CustomRain`)
- **Visuals:** Multiple layers of vertical falling drops, creating depth through speed, size, and opacity scaling.
- **Logic:** Simulates distance layers where furthest layers have lower speed multipliers, smaller sizes, and lower opacity. Optionally draws gradient trails.
- **Gotcha:** The project has two separate rain widgets: `RainBackground` ([rain_background.dart](file:///Users/ildebertosilva/flutter_moving_background/lib/rain_background.dart)) and `CustomRain` ([rain_custom_background.dart](file:///Users/ildebertosilva/flutter_moving_background/lib/rain_custom_background.dart)). They share similar parallax calculations but are distinct classes. Keep both implementation details aligned if making changes.

---

## Gotchas & Guidelines (Read before code changes)

1. **Keep Ticker Updates Efficient:**
   - Always calculate delta time (`dt`) on tick callbacks. Do not assume a static 60FPS update rate.
   - For example, in `update(double dt)` functions, normalize coordinates/movement by multiplying velocities or speeds with `dt` or a speed factor.

2. **Pause/Resume Behavior:**
   - Every background widget must respect the `isPaused` flag.
   - When `isPaused` is true, stop the `Ticker`. When it switches to false, start the `Ticker` and reset the `_lastElapsed` timestamp to prevent massive position jumps.

3. **Repaint Listener Usage:**
   - When constructing `CustomPainter` delegates, always pass a `ValueNotifier` or other `Listenable` (e.g. `notifier`) to the `super(repaint: ...)` constructor. This ensures the canvas repaints automatically when the notifier updates, keeping widget builds (`build()`) at `O(1)`.

4. **Writing Tests:**
   - Code changes must be validated by running unit and widget tests in the `test/` directory.
   - Since custom painting is harder to check line-by-line, write widget tests that verify the presence of layout parameters, the `CustomPaint` widget presence, size calculations, and ensure that the widgets can mount/unmount and handle pause state changes without throwing errors.

---

## Contribution & Verification Checklist

- Run static analysis before committing:
  ```bash
  dart analyze
  ```
- Run the test suite:
  ```bash
  flutter test
  ```
- Verify new animation changes inside the `example` application.
