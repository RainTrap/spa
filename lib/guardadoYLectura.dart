
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
Future<String> get localPath async{
  final path = await getApplicationDocumentsDirectory();
  return path.path;
}

Future<File> get localFile  async{
  final file = await localPath;
  return new File('$file/data.txt'); 
}
 
Future<void> deleteFileContent() async{
   final file = await localFile;

   file.delete();
}
Future<File>   writeData(String value)  async{
  final file = await localFile;
  return file.writeAsString('$value');
}
Future<String> readData() async{

  try{
    final file = await localFile;
    String data = await file.readAsString();
    print("-------------------------------");
    print("Reading data...");
    print(data);
    print("-------------------------------");
    return data;
      
}catch(e){
    return 'error: empty file';
}

}

Future<File>  guardarHorarios(List<String> value)  async{
  final file = await localFile;
  print("saving data...");
  String valor = "horarios:\n";
  for (var item in value) {
    valor += item + "\n";
  }
  valor += "*";
  
  return file.writeAsString('$valor');
} 

Future<List<String>> leerHorarios() async{
  List<String> horarios = [];
  try{
    var terminado = false;
    var horariosFile =  readData();
    horariosFile.then((onValue){
        print(onValue);
        if(onValue !=  null){
        int index = onValue.lastIndexOf(r'horarios:');
        print("index: $index");
        while(!terminado){
          String horario = "";
          while(!terminado){
            if(onValue[index] == '\n'){
              index+=1; 
              break;
            } 
            else horario += onValue[index];
            if(onValue[index]  == '*') terminado = true;
            index+=1; 
          }
          if(horario != "horarios:" && horario != "*") horarios.add(horario);
        }
      }else{
        print("null file");
      }
    });
    
    return horarios;

}catch(e){
    print(e);
    return null;
}
}