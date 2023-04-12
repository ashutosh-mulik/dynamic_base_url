library shake;

import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:sensors_plus/sensors_plus.dart';

/// ShakeDetector class for phone shake functionality
class ShakeDetector {
  /// Shake detection threshold
  final double shakeThresholdGravity = 2.7;

  /// Minimum time between shake
  final int shakeSlopTimeMS = 500;

  /// Time before shake count resets
  final int shakeCountResetTime = 3000;

  /// Number of shakes required before shake is triggered
  final int minimumShakeCount = 1;

  int mShakeTimestamp = DateTime.now().millisecondsSinceEpoch;
  int mShakeCount = 0;

  /// StreamSubscription for Accelerometer events
  StreamSubscription? streamSubscription;

  /// Starts listening to accelerometer events
  void startListening(VoidCallback onShake) {
    streamSubscription = accelerometerEvents.listen(
      (AccelerometerEvent event) {
        double x = event.x;
        double y = event.y;
        double z = event.z;

        double gX = x / 9.80665;
        double gY = y / 9.80665;
        double gZ = z / 9.80665;

        // gForce will be close to 1 when there is no movement.
        double gForce = sqrt(gX * gX + gY * gY + gZ * gZ);

        if (gForce > shakeThresholdGravity) {
          var now = DateTime.now().millisecondsSinceEpoch;
          // ignore shake events too close to each other (500ms)
          if (mShakeTimestamp + shakeSlopTimeMS > now) {
            return;
          }

          // reset the shake count after 3 seconds of no shakes
          if (mShakeTimestamp + shakeCountResetTime < now) {
            mShakeCount = 0;
          }

          mShakeTimestamp = now;
          mShakeCount++;

          if (mShakeCount >= minimumShakeCount) {
            onShake();
          }
        }
      },
    );
  }

  /// Stops listening to accelerometer events
  void stopListening() {
    streamSubscription?.cancel();
  }
}
