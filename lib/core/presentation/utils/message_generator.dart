class MessageGenerator {
  static const Map<String, Map<String, String>> _messageMap = {
    "en": {
      "un-expected-error": "Some un expected error happened!",
      "un-expected-error-message": "Some un expected error happened!",
      "auth-welcome": "Vachak - The Word Puzzle!",
      "auth-visit-site-guide":
          "To explore in-depth instructions for utilizing this rapid starter Flutter project, head over to https://github.com/midhunarmid/flutter_util_hub to kick off your journey.",
    "LOAD_SOURCE_LANGUAGE_TITLE":"Preparing Your Language Options",
    "LOAD_SOURCE_LANGUAGE_DESC":"Gathering languages for you to choose from. Please wait a moment as we set up your language learning journey!",
    }
  };

  static const Map<String, Map<String, String>> _labelMap = {
    "en": {
      "OK": "OK",
    }
  };

  static String getMessage(String message) {
    return (_messageMap[getLanguage()] ?? {})[message] ?? message;
  }

  static String getLabel(String label) {
    return (_labelMap[getLanguage()] ?? {})[label] ?? label;
  }

  static String getLanguage() {
    // Implement multi language support here
    return "en";
  }
}
