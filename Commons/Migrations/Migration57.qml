import QtQuick 6.11

QtObject {
  id: root

  function migrate(adapter, logger, rawJson) {
    logger.i("Settings", "Migrating settings to v57 (cavaFrameRate -> spectrumFrameRate)");

    if (rawJson && rawJson.audio && rawJson.audio.cavaFrameRate !== undefined) {
      adapter.audio.spectrumFrameRate = rawJson.audio.cavaFrameRate;
      logger.i("Settings", "Migrated cavaFrameRate:", rawJson.audio.cavaFrameRate, "-> spectrumFrameRate");
    }

    return true;
  }
}
