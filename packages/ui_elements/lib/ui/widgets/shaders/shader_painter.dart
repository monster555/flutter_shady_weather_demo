part of 'weather_shader_widget.dart';

/// A custom painter that applies a fragment shader to the provided canvas.
class ShaderPainter extends CustomPainter {
  /// The fragment shader to be applied to the canvas.
  final ui.FragmentShader shader;

  /// Creates a [ShaderPainter] with the specified [shader].
  ///
  /// The [shader] represents the fragment shader to be applied to the canvas.
  ShaderPainter(this.shader);

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      // Translate to the bottom right corner of the canvas.
      ..translate(size.width, size.height)
      // Rotate the canvas by 180 degrees.
      ..rotate(180 * degrees2Radians)
      ..drawRect(
        // Draw a rectangle.
        Rect.fromLTWH(0, 0, size.width, size.height),
        // Apply the shader to the rectangle.
        Paint()..shader = shader,
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate != this;
}
