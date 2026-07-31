# Speech models are NOT bundled in the APK.
#
# On first launch Compass downloads Russian Whisper.cpp models into
# application support storage via SpeechEngine / ModelManager:
#
#   ggml-small-q5_1.bin  (default)
#   ggml-base-q5_1.bin   (fallback)
#
# See lib/speech/speech_model_catalog.dart
