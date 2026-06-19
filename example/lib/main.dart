import 'package:flutter/material.dart';
import 'package:flutter_moving_background/flutter_moving_background.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _darkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moving Background Example',
      themeMode: _darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: App(
        darkMode: _darkMode,
        onToggleDarkMode: (value) => setState(() => _darkMode = value),
      ),
    );
  }
}

enum BackgroundStyle {
  customCircles,
  sunsetPreset,
  auroraPreset,
  cyberpunkPreset,
  themedPreset,
  bubbles,
  rain,
  constellation,
  waves,
}

class App extends StatefulWidget {
  const App({
    super.key,
    required this.darkMode,
    required this.onToggleDarkMode,
  });

  final bool darkMode;
  final ValueChanged<bool> onToggleDarkMode;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  BackgroundStyle _selectedStyle = BackgroundStyle.auroraPreset;

  Widget _buildBackground(BuildContext context, Widget child) {
    switch (_selectedStyle) {
      case BackgroundStyle.customCircles:
        return MovingBackground(
          duration: const Duration(seconds: 8),
          animationType: AnimationType.pulse,
          backgroundColor:
              widget.darkMode ? const Color(0xFF0D0D1E) : Colors.grey.shade50,
          circles: [
            MovingCircle(
                color: Colors.amber.withValues(alpha: 0.6), radius: 350),
            MovingCircle(
                color: Colors.pink.withValues(alpha: 0.5), radius: 450),
            MovingCircle(
                color: Colors.blue.withValues(alpha: 0.4), radius: 400),
          ],
          child: child,
        );
      case BackgroundStyle.sunsetPreset:
        return MovingBackground.sunset(child: child);
      case BackgroundStyle.auroraPreset:
        return MovingBackground.aurora(child: child);
      case BackgroundStyle.cyberpunkPreset:
        return MovingBackground.cyberpunk(child: child);
      case BackgroundStyle.themedPreset:
        return MovingBackground.themed(context, child: child);
      case BackgroundStyle.bubbles:
        return BubbleBackground(
          numBubbles: 15,
          colors: const [Colors.teal, Colors.indigo, Colors.purpleAccent],
          minRadius: 40,
          maxRadius: 100,
          speed: 0.8,
          blurSigma: 12.0,
          backgroundColor:
              widget.darkMode ? const Color(0xFF0F0F1A) : Colors.white,
          child: child,
        );
      case BackgroundStyle.rain:
        return RainBackground(
          numberOfDrops: 120,
          fallSpeed: 1.5,
          hasTrail: true,
          numLayers: 4,
          colors: widget.darkMode
              ? const [Colors.lightBlueAccent, Colors.purpleAccent]
              : const [Colors.blue, Colors.teal],
          backgroundColor: widget.darkMode
              ? const Color(0xFF050510)
              : Colors.blueGrey.shade50,
          child: child,
        );
      case BackgroundStyle.constellation:
        return ConstellationBackground(
          particleCount: 50,
          maxDistance: 120.0,
          speed: 0.9,
          colors: widget.darkMode
              ? const [Colors.cyanAccent, Colors.pinkAccent, Colors.white]
              : const [Colors.blueAccent, Colors.purpleAccent, Colors.teal],
          lineColor: widget.darkMode
              ? const Color(0x22FFFFFF)
              : const Color(0x22000000),
          backgroundColor:
              widget.darkMode ? const Color(0xFF070714) : Colors.white,
          child: child,
        );
      case BackgroundStyle.waves:
        return WaveBackground(
          waveCount: 4,
          speed: 1.2,
          amplitude: 30.0,
          frequency: 0.006,
          colors: widget.darkMode
              ? const [
                  Color(0xFF8A2387),
                  Color(0xFFE94057),
                  Color(0xFFF27121),
                  Colors.orangeAccent
                ]
              : const [
                  Colors.blue,
                  Colors.teal,
                  Colors.cyan,
                  Colors.lightBlueAccent
                ],
          backgroundColor: widget.darkMode
              ? const Color(0xFF0A0518)
              : Colors.lightBlue.shade50,
          child: child,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = widget.darkMode ? Colors.white : Colors.black87;
    final cardColor = widget.darkMode
        ? Colors.black.withValues(alpha: 0.45)
        : Colors.white.withValues(alpha: 0.7);

    return Scaffold(
      body: _buildBackground(
        context,
        SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Glassmorphic title card
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 32.0),
                    child: Row(
                      spacing: 10,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Dark Mode",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: textColor),
                        ),
                        Switch(
                          value: widget.darkMode,
                          onChanged: widget.onToggleDarkMode,
                        ),
                      ],
                    ),
                  ),
                  // Style selection panel
                  Card(
                    color: cardColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(
                        color:
                            widget.darkMode ? Colors.white10 : Colors.black12,
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "SELECT BACKGROUND PATTERN",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              color: textColor.withValues(alpha: 0.6),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: BackgroundStyle.values.map((style) {
                              final isSelected = style == _selectedStyle;
                              final label = style.name
                                  .replaceAll('Preset', '')
                                  .replaceAll('custom', 'Custom ')
                                  .replaceAll('sunset', 'Sunset')
                                  .replaceAll('aurora', 'Aurora')
                                  .replaceAll('cyberpunk', 'Cyberpunk')
                                  .replaceAll('themed', 'Theme-Aware')
                                  .replaceAll('bubbles', 'Bouncing Bubbles')
                                  .replaceAll('rain', 'Parallax Rain')
                                  .replaceAll('constellation', 'Constellation')
                                  .replaceAll('waves', 'Flowing Waves');
                              return ChoiceChip(
                                label: Text(label),
                                selected: isSelected,
                                onSelected: (selected) {
                                  if (selected) {
                                    setState(() {
                                      _selectedStyle = style;
                                    });
                                  }
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
