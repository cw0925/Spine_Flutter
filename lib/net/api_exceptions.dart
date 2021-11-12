class JsonDeserializeException implements Exception {
  String type;
  dynamic data;

  JsonDeserializeException(this.type, this.data);

  @override
  String toString() {
    if (this.data == null) return "JsonDeserializeException: Deserialize $type failed";
    return "JsonDeserializeException: Deserialize $type failed: ${this.data.toString()}";
  }
}