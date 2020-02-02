Map<String, dynamic> addOrUpdateSetting(
  String key,
  dynamic value,
  Map<String, dynamic> settings,
) {
  if (settings.containsKey(key)) {
    settings[key] = value;
  } else {
    settings.putIfAbsent(key, () => value);
  }

  return settings;
}
