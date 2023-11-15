import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_elements/ui/weather_page.dart';
import 'package:vector_math/vector_math_64.dart';

part 'shader_painter.dart';

/// A widget that displays a weather condition using a shader.
///
/// The [WeatherShaderWidget] is designed to visualize different weather conditions using
/// fragment shaders. It takes a [WeatherCondition] as input and adjusts the shader's
/// uniforms accordingly.
///
/// Mapping Shader Parameters to Fragment Program Variables:
/// - `iTime` (index 0): Elapsed time for animation.
/// - `iResolution` (indices 1, 2): Width and height of the widget.
/// - `iChannel0` (index 0): Represents the background image texture.
class WeatherShaderWidget extends StatefulWidget {
  /// Creates a [WeatherShaderWidget] for a specific weather condition.
  ///
  /// The [weatherCondition] parameter determines the type of weather condition to
  /// visualize. The widget adjusts the shader's uniforms based on the provided
  /// weather condition.
  const WeatherShaderWidget(this.weatherCondition, {super.key});

  /// The weather condition to display.
  final WeatherCondition weatherCondition;

  @override
  State<WeatherShaderWidget> createState() => _WeatherShaderWidgetState();
}

/// The state for the [WeatherShaderWidget] widget.
///
/// This state class manages the animation controller for the shader and
/// calculates the elapsed time since the widget's initialization.
class _WeatherShaderWidgetState extends State<WeatherShaderWidget>
    with SingleTickerProviderStateMixin {
  /// The animation controller responsible for animating the shader.
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  )..repeat();

  @override
  void initState() {
    super.initState();
    // Load the background image if set.
    if (widget.weatherCondition.hasBackgroundImage) {
      _loadImage();
    }
  }

  @override
  void dispose() {
    // Dispose the animation controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  /// The time when the widget was initialized.
  int _startTime = 0;

  /// Returns the elapsed time since the widget was initialized.
  double get _elapsedTimeInSeconds =>
      (DateTime.now().millisecondsSinceEpoch - _startTime) / 1000;

  /// The background image to be used for the shader.
  ui.Image? _image;

  /// Loads the background image associated with the current weather condition.
  ///
  /// This method uses the [loadImageFromAsset] function to load the image from
  /// the specified asset path in the [WeatherCondition].
  ///
  /// The loaded image is stored in the [_image] state variable, and the widget
  /// is rebuilt to display the updated background.
  Future<void> _loadImage() async {
    _image = await loadImageFromAsset(widget.weatherCondition.backgroundImage);
    setState(() {});
  }

  /// Loads an image from the specified asset path and returns a [ui.Image] Future.
  ///
  /// Parameters:
  ///
  /// - [assetPath] The path to the asset containing the image.
  ///
  /// Returns:
  ///
  /// A [Future] that completes with the loaded [ui.Image].
  Future<ui.Image> loadImageFromAsset(String assetPath) async {
    // Load the image data from the asset.
    final ByteData data = await rootBundle.load(assetPath);

    // Completer to handle the asynchronous image decoding.
    final Completer<ui.Image> completer = Completer();

    // Decode the image from the loaded data and complete the Future.
    ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
      completer.complete(img);
    });

    // Return the Future for the loaded image.
    return completer.future;
  }

  /// Builds the widget tree for the [WeatherShaderWidget].
  @override
  Widget build(BuildContext context) {
    // Initialize the start time when the widget is first built.
    _startTime = DateTime.now().millisecondsSinceEpoch;

    // Get the size of the current MediaQuery
    final size = MediaQuery.sizeOf(context);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: FutureBuilder<ui.FragmentShader>(
        // Load the shader from the shaders folder.
        future: _loadShader(widget.weatherCondition.shader),
        builder: (context, snapshot) {
          // Check if data is available and the condition regarding the background image matches the loaded image state.
          if (snapshot.hasData &&
              (widget.weatherCondition.hasBackgroundImage ==
                  (_image != null))) {
            final shader = snapshot.data!;

            // Set the shader's width and height parameters.
            shader
              // Set width: Corresponds to shader's `iResolution.x` uniform
              ..setFloat(1, size.width)
              // Set height: Corresponds to shader's `iResolution.y` uniform
              ..setFloat(2, size.height);

            return AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                // Set shader parameters including elapsed time and the background image if set.
                shader
                    // Set elapsed time: Corresponds to shader's `iTime`
                    .setFloat(0, _elapsedTimeInSeconds);

                if (widget.weatherCondition.hasBackgroundImage) {
                  // Set _image: Corresponds to shader's `iChannel0` uniform
                  // Set this only if the background image is set.
                  shader.setImageSampler(0, _image!);
                }
                return CustomPaint(
                  painter: ShaderPainter(shader),
                );
              },
            );
          } else {
            // Display a CircularProgressIndicator while loading the shader.
            return const SizedBox.square(
              dimension: 32,
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

/// Loads and returns a [ui.FragmentShader] from an asset using the specified [shaderName].
///
/// This method loads a shader program from the assets folder with the given [shaderName]
/// and returns the corresponding [ui.FragmentShader].
///
/// Parameters:
///
/// - [shaderName] The name of the shader file to load.
Future<ui.FragmentShader> _loadShader(String shaderName) async {
  // Load the shader program from the assets folder.
  ui.FragmentProgram program =
      await ui.FragmentProgram.fromAsset('shaders/$shaderName');

  // Return the fragment shader from the program.
  return program.fragmentShader();
}
