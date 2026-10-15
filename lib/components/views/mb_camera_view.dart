import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:my_boxy_ds/ui/design_tokens/design_tokens.dart';

class MBCameraView extends StatelessWidget {
  const MBCameraView({super.key, required this.onMediaCaptured});

  final ValueChanged<String> onMediaCaptured;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CameraAwesomeBuilder.custom(
        sensorConfig: SensorConfig.single(
          sensor: Sensor.position(SensorPosition.back),
          aspectRatio: CameraAspectRatios.ratio_1_1,
        ),
        saveConfig: SaveConfig.photoAndVideo(
          initialCaptureMode: CaptureMode.photo,
        ),
        previewFit: CameraPreviewFit.fitWidth,
        onMediaCaptureEvent: _handleMediaCapture,
        builder: (cameraState, preview) {
          return cameraState.when(
            onPreparingCamera: (_) => const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
            onPhotoMode: (state) => _CameraControls(state: state),
            onVideoMode: (state) => _CameraControls(state: state),
            onVideoRecordingMode: (state) => _CameraControls(state: state),
          );
        },
      ),
    );
  }

  void _handleMediaCapture(MediaCapture capture) {
    if (capture.status != MediaCaptureStatus.success) return;

    final path = capture.captureRequest.path;
    if (path != null) onMediaCaptured(path);
  }
}

class _CameraControls extends StatelessWidget {
  _CameraControls({required this.state});

  final CameraState state;
  late bool isVideo = state.captureMode == CaptureMode.video;

  @override
  Widget build(BuildContext context) {
    final frameSize = MediaQuery.sizeOf(context).width * .85;

    return Stack(
      children: [
        Positioned.fill(
          top: -80,
          child: IgnorePointer(
            child: CustomPaint(
              painter: _CameraFrameMaskPainter(frameSize: frameSize),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.paddingOf(context).top + 16,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              AwesomeFlashButton(state: state),
            ],
          ),
        ),
        Positioned(
          bottom: MediaQuery.paddingOf(context).bottom + 24,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: isVideo ? null : Colors.white
                    ),
                    onPressed: () => state.setState(CaptureMode.photo),
                    child: Text(
                      'FOTO',
                      style: TextStyle(
                        color: state.captureMode == CaptureMode.photo
                            ? AppColors.primary : Colors.grey,
                        fontFamily: AppFonts.mono,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: isVideo ? Colors.white : null
                    ),
                    onPressed: () => state.setState(CaptureMode.video),
                    child: Text(
                      'VÍDEO',
                      style: TextStyle(
                        color: state.captureMode == CaptureMode.video
                            ? AppColors.primary : Colors.grey,
                        fontFamily: AppFonts.mono,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AwesomeCameraSwitchButton(state: state),
                  GestureDetector(
                    onTap: () => _capture(state),
                    child: _ShutterButton(state: state),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _capture(CameraState state) {
    return state.when(
      onPhotoMode: (photoState) => photoState.takePhoto(),
      onVideoMode: (videoState) => videoState.startRecording(),
      onVideoRecordingMode: (recordingState) =>
          recordingState.stopRecording(),
    ) ?? Future<void>.value();
  }
}

class _CameraFrameMaskPainter extends CustomPainter {
  const _CameraFrameMaskPainter({required this.frameSize});

  final double frameSize;

  @override
  void paint(Canvas canvas, Size size) {
    final frame = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: size.center(Offset.zero),
        width: frameSize + 40,
        height: frameSize + 160,
      ),
      const Radius.circular(16),
    );
    final overlayPaint = Paint()..color = Colors.black.withValues(alpha: .9);

    canvas.saveLayer(Offset.zero & size, Paint());
    canvas.drawRect(Offset.zero & size, overlayPaint);
    canvas.drawRRect(frame, Paint()..blendMode = BlendMode.clear);
    canvas.restore();

    // canvas.drawRRect(
    //   frame,
    //   Paint()
    //     ..color = Colors.white.withValues(alpha: .8)
    //     ..style = PaintingStyle.stroke
    //     ..strokeWidth = 2,
    // );
  }

  @override
  bool shouldRepaint(covariant _CameraFrameMaskPainter oldDelegate) {
    return oldDelegate.frameSize != frameSize;
  }
}

class _ShutterButton extends StatelessWidget {
  _ShutterButton({
    required this.state
  });

  final CameraState state;
  late bool isVideo = state.captureMode == CaptureMode.video;

  @override
  Widget build(BuildContext context) {
    final isRecording = state is VideoRecordingCameraState;

    return Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(
        color: AppColors.white.withAlpha(60),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isRecording ? 30 : 60,
          height: isRecording ? 30 : 60,
          decoration: BoxDecoration(
            color: state.captureMode == CaptureMode.video
                ? Colors.red : AppColors.white,
            borderRadius: BorderRadius.circular(isRecording ? 8 : 40),
          ),
          child: Icon(
            isVideo ? LucideIcons.video : LucideIcons.camera,
            color: isVideo ? AppColors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
