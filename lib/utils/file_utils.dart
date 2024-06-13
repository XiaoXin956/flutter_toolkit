part of 'utils.dart';

/// 拆分文件
Future splitFile(File file,int subFileByteSize) async {
  // 1.获取文件的大小
  int size = await file.length();
  // 2.计算分割的数量
  int count = (size / subFileByteSize * 1024).ceil();
  // 3.获取文件的名称
  String fileName = file.path.split("/").last;
  // 4.获取文件的后缀
  String suffix = fileName.split(".").last;
  // 5.获取文件的父目录
  String parentPath = file.parent.path;
  // 6.创建一个目录
  Directory directory = Directory("$parentPath/$fileName");
  if (!await directory.exists()) {
    await directory.create();
  }
  // 7.读取文件
  IOSink? iosink;
  try {
    iosink = file.openWrite(mode: FileMode.writeOnlyAppend);
    // 8.分割文件
    for (int i = 0; i < count; i++) {
      // 8.1.创建一个新的文件
      File newFile = File("${directory.path}/$fileName.$i.$suffix");
      // 8.2.打开文件
      RandomAccessFile raf = await newFile.open(mode: FileMode.writeOnlyAppend);
      // 8.3.读取文件
      int start = i * subFileByteSize * 1024;
      int end = (i + 1) * subFileByteSize * 1024 - 1;
      if (end > size) {
        end = size - 1;
      }
      // 8.4.读取文件
      List<int> bytes = await file.readAsBytes();
      // 8.5.写入文件
      raf.writeFromSync(bytes, start, end - start + 1);
      // 8.6.关闭文件
      await raf.close();
    }
  } catch (e) {
    print(e);
  } finally {
    // 9.关闭文件
    if(iosink!=null){
      await iosink.close();
    }
  }
}

/// 拆分文件列表
Future<List<Uint8List>> splitFileList({required File file}) async {
  List<Uint8List> chunks = [];
  final fileBytes = await file.readAsBytes();
  const chunkSize = 20 * 1024; // 每个文件的大小
  for (var i = 0; i < fileBytes.length; i += chunkSize) {
    final end = (i + chunkSize < fileBytes.length) ? i + chunkSize : fileBytes.length;
    chunks.add(Uint8List.sublistView(fileBytes, i, end));
  }
  return Future.value(chunks);
}