String censor(String messageText) {
  final List profanity3 = [

    'sex', //3
    
    'ass', //3
   
    'fag', //3
   
  ]; 
  final List profanity4 = [
    'fuck', //4
    
    'shit', //4
    'cunt', //4
    
    'dick', //4
   
    'cock', //4
    
    'boob', //4
    
    'tits', //4
    'nigg', //4
    
    'chut', //4
    'chod', //4
    
  ]; 

    final List profanity5 = [
    
    'bitch', //5
   
    'pussy', //5
    
    'penis', //5
   
    'whore', //5
   
    'gaand', //5
   
    'kutta', //5
    'rundi', //5
    'randi', //5
    'saala', //5
    
  ]; 

    final List profanity6 = [
   
    'vagina', //6
    
    'breast', //6
    
    
    'retard', //6
    
    'kamina', //6
    
    'bhangi', //6
  ]; 

    final List profanity7 = [
    
    'bastard', //7
    
  ]; 

    final List profanity8 = [
    
    'bhosdike', //8
  
  ]; 

    final List profanity10 = [
    
    'prostitute', //10
 
  ]; 
  profanity3.forEach((badWord) {
    String lowerCaseMessage = messageText.toLowerCase();
    if (lowerCaseMessage.contains(badWord)) {
      messageText = lowerCaseMessage.replaceAll(badWord, '***');
    }
  });
    profanity4.forEach((badWord) {
    String lowerCaseMessage = messageText.toLowerCase();
    if (lowerCaseMessage.contains(badWord)) {
      messageText = lowerCaseMessage.replaceAll(badWord, '****');
    }
  });
     profanity5.forEach((badWord) {
    String lowerCaseMessage = messageText.toLowerCase();
    if (lowerCaseMessage.contains(badWord)) {
      messageText = lowerCaseMessage.replaceAll(badWord, '*****');
    }
  });
      profanity6.forEach((badWord) {
    String lowerCaseMessage = messageText.toLowerCase();
    if (lowerCaseMessage.contains(badWord)) {
      messageText = lowerCaseMessage.replaceAll(badWord, '******');
    }
  });
       profanity7.forEach((badWord) {
    String lowerCaseMessage = messageText.toLowerCase();
    if (lowerCaseMessage.contains(badWord)) {
      messageText = lowerCaseMessage.replaceAll(badWord, '*******');
    }
  });
       profanity8.forEach((badWord) {
    String lowerCaseMessage = messageText.toLowerCase();
    if (lowerCaseMessage.contains(badWord)) {
      messageText = lowerCaseMessage.replaceAll(badWord, '********');
    }
  });
       profanity10.forEach((badWord) {
    String lowerCaseMessage = messageText.toLowerCase();
    if (lowerCaseMessage.contains(badWord)) {
      messageText = lowerCaseMessage.replaceAll(badWord, '**********');
    }
  });
  return messageText;
}