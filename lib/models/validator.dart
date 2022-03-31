import 'dart:async';

mixin Validator{
  var emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      if(email.contains("@")){
        sink.add(email);
      }else{
        sink.addError("Invalid email provided!");
      }
    }
  );

  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){
      if(password.length > 4){
        sink.add(password);
      }else{
        sink.addError("Password should be at least 4 characters long!");
      }
    }
  );
}