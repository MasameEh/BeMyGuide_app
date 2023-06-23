

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';


class AIHandler{
  final _openAI = OpenAI.instance.build(
    //token: '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',
    token: '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',
    baseOption: HttpSetup(receiveTimeout: 20000),
  );
  Future<String> getResponse(String msg) async{
  try{
    final request = CompleteText(prompt: msg, model: kTranslateModelV3);
    final response = await _openAI.onCompleteText(request: request);
    if(response!= null){
      return response.choices[0].text.trim();
      }
      return 'something went wrong';
    }catch (e){
      return e.toString();
    }

  }
  void dispose(){
    _openAI.close();
  }
}