int readingTime(String content){
  final wordCount = content.split(RegExp(r'\s+')).length;
  final readingTime = wordCount/220;
  return readingTime.ceil();
}