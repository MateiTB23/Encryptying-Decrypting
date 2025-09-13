import controlP5.*; // import controlP5 libary for making ui stuff like input fields and textfields

// In this implementation of viginere and ceaser cipher i will use ASCII encoded characther for simplicity
// Here is a link for the wiki of ASCII table: https://en.wikipedia.org/wiki/ASCII
// The algorithims ive created support all characthers in the english alphabet both upper and lower cased,
// other characther which are not a letter, shall not be encrypted

ControlP5 cp5;
Textfield inputText, keywordText, decryptText; // Text input fields and keyword field
Button caesarEncryptButton, caesarDecryptButton, vigenereEncryptButton, vigenereDecryptButton; // Buttons for different operations
String caesarEncryptedText = ""; // Store Caesar encrypted text
String caesarDecryptedText = ""; // Store Caesar decrypted text
String vigenereEncryptedText = ""; // Store Vigenere encrypted text
String vigenereDecryptedText = ""; // Store Vigenere decrypted text
String keyword = "KEY"; // Replace with your Vigenère keyword;

void setup() {
  size(1000, 800); // Set the window size
  
  cp5 = new ControlP5(this); //create a new instance of Controlp5 variable in this sketch and store in cp5 variable
  
  // Create a text input field, and customize how it looks
  inputText = cp5.addTextfield("input")
                 .setPosition(50, 50)
                 .setSize(400, 40)
                 .setFont(createFont("Arial-BoldMT", 16)) // Set font and size
                 .setColorLabel(0)
                 .setColorBackground(color(185))
                 .setColorActive(color(200));
  
  // Create a keyword input field for Vigenère and customize how it looks
  keywordText = cp5.addTextfield("keyword")
                 .setPosition(50, 120)
                 .setSize(200, 40)
                 .setLabel("Vigenere Keyword")
                 .setColorLabel(0)
                 .setFont(createFont("Arial-BoldMT", 16)) // Set font and size
                 .setColorBackground(color(185))
                 .setColorActive(color(200));
  
   // Create a text input field for the encrypted text you want to decrypt and customize how it looks
  decryptText = cp5.addTextfield("decrypttext")
                 .setPosition(500, 50)
                 .setSize(400, 40)
                 .setFont(createFont("Arial-BoldMT", 16)) // Set font and size
                 .setColorLabel(0)
                 .setColorBackground(color(185))
                 .setColorActive(color(200));
  
  // Create Caesar cipher "Encrypt" button
  caesarEncryptButton = cp5.addButton("CaesarEncrypt")
                     .setPosition(50, 200)
                     .setSize(200, 40)
                     .setLabel("Caesar Encrypt")
                     .setFont(createFont("Arial-BoldMT", 16)) // Set font and size
                     .setColorBackground(color(185))
                     .setColorActive(color(200));
  
  // Create Caesar cipher "Decrypt" button
  caesarDecryptButton = cp5.addButton("CaesarDecrypt")
                     .setPosition(260, 200)
                     .setSize(200, 40)
                     .setLabel("Caesar Decrypt")
                     .setFont(createFont("Arial-BoldMT", 16)) // Set font and size
                     .setColorBackground(color(185))
                     .setColorActive(color(200));
  
  // Create Vigenère cipher "Encrypt" button and customize how it looks
  vigenereEncryptButton = cp5.addButton("VigenereEncrypt")
                     .setPosition(50, 260)
                     .setSize(200, 40)
                     .setLabel("Vigenere Encrypt")
                     .setFont(createFont("Arial-BoldMT", 16)) // Set font and size
                     .setColorBackground(color(185))
                     .setColorActive(color(200));
  
  // Create Vigenère cipher "Decrypt" button and customize how it looks
  vigenereDecryptButton = cp5.addButton("VigenereDecrypt")
                     .setPosition(260, 260)
                     .setSize(200, 40)
                     .setLabel("Vigenere Decrypt")
                     .setFont(createFont("Arial-BoldMT", 16)) // Set font and size
                     .setColorBackground(color(185))
                     .setColorActive(color(200));
}

String originalInputText = ""; // Empty string to store the original input text for both Caesar and Vigenère

void controlEvent(ControlEvent event) {
  if (event.isAssignableFrom(Button.class)) { // When a button is clicked
    if (event.getName().equals("CaesarEncrypt")) { // if the event the button starts equals Ceaser Encrypt
      originalInputText = inputText.getText(); // Store the text from the input field in the empty originalInput text variable from before
      caesarEncryptedText = caesarEncrypt(originalInputText, 3); // Call Ceaser Encrypt function on originalInputText with Caesar cipher encrypt with a shift of 3, and store in caesarEncryptedText
      caesarDecryptedText = ""; // Clear Caesar decryption text
      
      
      inputText.clear(); // Clear the input text field
    } else if (event.getName().equals("CaesarDecrypt")) {  // if the events name equals CeaserDecrypt we Decrypt using Caesar decryption
      caesarDecryptedText = caesarDecrypt(decryptText.getText(), 3); // Call Ceaser decrypt function for the decrypted text from the decrypt text field with a shift of 3
      
      
      inputText.clear(); // Clear the input text field
    } else if (event.getName().equals("VigenereEncrypt")) {  //if the events name equals VigenereEncrypt we Encrypt using Viginere Encryption
      originalInputText = inputText.getText(); // Store the text from the input field in the empty originalInput text variable
      String vigenereKeyword = keywordText.getText(); // Get Vigenere keyword from the input field keywordText and store it in vigenereKeyword string
      vigenereEncryptedText = vigenereEncrypt(originalInputText, vigenereKeyword); // Vigenère cipher encrypt on originalInputText with vigenereKeyword and stored in vigenereEncryptedText
      vigenereDecryptedText = ""; // Clear Vigenère decryption text
      
     
      inputText.clear(); // Clear the input text field
    } else if (event.getName().equals("VigenereDecrypt")) { //if the events name equals VigenereDecrypt we decrypt using Viginere decryption
      vigenereDecryptedText = vigenereDecrypt(decryptText .getText(), keywordText.getText()); // Decrypt using Vigenère decryption on the text from input decryptText field with our vigenere keyword
      
      inputText.clear();// Clear the input text field
    }
  }
}

void draw() {
  textSize(20); // set text size to 20
  fill(0); // fill the color black to the text
  
  background(240);
  text("Caesar Encrypted Text:", 50, 340); // Display Caesar encrypted text
  text("Caesar Decrypted Text:", 50, 440); // Display Caesar decrypted text
  text("Vigenere Encrypted Text:", 390, 340); // Display Vigenere encrypted text
  text("Vigenere Decrypted Text:", 390, 440); // Display Vigenere decrypted text
  
  text(originalInputText, 50, 140); // Display the original input text
  text(caesarEncryptedText, 50, 410); // Display Caesar encrypted text
  text(caesarDecryptedText, 50, 470); // Display Caesar decrypted text
  text(vigenereEncryptedText, 390, 410); // Display Vigenere encrypted text
  text(vigenereDecryptedText, 390, 470); // Display Vigenere decrypted text
}

// Caesar cipher encryption function
String caesarEncrypt(String text, int shift) { // function encrypt which has 2 arguments  called text and shift, and returns the encrypted text
  String encryptResult = ""; // clear encryptResult
  for (int i = 0; i < text.length(); i++) {
    char c = text.charAt(i); // for loop through each letter of our text, which it temporarely saves in char c
    if (Character.isLowerCase(c)) {//checks if characther c is lower cased
      char shifted = (char) ((c - 'a' + shift) % 26 + 'a'); // shifts the characther c, by subtracting the char 'a' to convert it into ASCII value, and then adding the shift, afterwards saying modulo 26, to make sure it dosent go out of the alphabet, and finishing of by plussing char 'a' to reconvert it to normal
      encryptResult += shifted; //adds the shifted characther we stored in the previous line to string encryptResult
    } else if (Character.isUpperCase(c)) { // else it checks if characther c is upper cased, it does this as char 'a' and char 'A' do not have the same ASCII value, so its a safety feature to make sure there dosent happen any bugs
      char shifted = (char) ((c - 'A' + shift) % 26 + 'A');  // shifts the characther c, by subtracting the char 'A' to convert it into ASCII value, and then adding the shift, afterwards saying modulo 26, to make sure it dosent go out of the alphabet, and finishing of by plussing char 'A' to reconvert it to normal
      encryptResult += shifted; //adds the shifted characther we stored in the previous line to string encryptResult
    } else {
      encryptResult += c; // else if characther is neither uppercase or lowercase, for example a space, it adds it to encryptResults as it is
    }
  }
  return encryptResult; // then it returns encryptResults, once its looped through the whole text
}

// Caesar cipher decryption function
String caesarDecrypt(String text, int shift) { // function decrypt which has 2 arguments  called text and shift  and returns the decrypted text
  String result = ""; // clears string result
  for (int i = 0; i < text.length(); i++) {
    char c = text.charAt(i); // for loop through each letter of our text, which it temporarely saves in char c
    if (Character.isLowerCase(c)) { //checks if characther c is lower cased
      char shifted = (char) ((c - 'a' - shift + 26) % 26 + 'a'); // shifts the characther c, by subtracting the char 'a' to convert it into ASCII value, and then adding the shift, afterwards saying modulo 26, to make sure it dosent go out of the alphabet, and finishing of by plussing char 'a' to reconvert it to normal
      result += shifted;  //adds the shifted characther we stored in the previous line to string result
    } else if (Character.isUpperCase(c)) {  // else it checks if characther c is upper cased, it does this as char 'a' and char 'A' do not have the same ASCII value, so its a safety feature to make sure there dosent happen any bugs
      char shifted = (char) ((c - 'A' - shift + 26) % 26 + 'A'); // shifts the characther c, by subtracting the char 'A' to convert it into ASCII value, and then adding the shift, afterwards saying modulo 26, to make sure it dosent go out of the alphabet, and finishing of by plussing char 'A' to reconvert it to normal
      result += shifted;//adds the shifted characther we stored in the previous line to string result
    } else {
      result += c; //  else if characther is neither uppercase or lowercase, for example a space, it adds it to result as it is
    }
  }
  return result; // then it returns result, once its looped through the whole text
}

// Vigenère cipher encryption function
String vigenereEncrypt(String text, String keyword) { // declare string viginereEncrypt which has 2 variables passed called text and keyword
  String encryptedText = ""; //clear the encrypted text
  int keywordIndex = 0; // initialize variable keywordIndex which is integer and assign value 0

  for (int i = 0; i < text.length(); i++) {
    char currentChar = text.charAt(i);  // for loop through each letter of our text, which it temporarely saves in char currentChar

    if (Character.isLetter(currentChar)) { //checks if the currentChar is a letter, otherwise let the characther unencrypted
      char keywordChar = keyword.charAt(keywordIndex % keyword.length());  // we check the characther at the keyword index, taking into account that the keyword can be shorter than the text, a situation in which we will say modulo keyword length, meaning that we will make the word repeat itself, for example if the keyword was cat, and text was hello it would go catca

      
      boolean isUpperCase = Character.isUpperCase(currentChar); // We initialize a boolean called isUpperCase where we store if the current char is upper case

      
      currentChar = Character.toUpperCase(currentChar); //Convert both characters to uppercase for consistent shifting, as the characther 'a' and 'A' will not have the same ASCII values
      keywordChar = Character.toUpperCase(keywordChar); // Convert both characters to uppercase for consistent shifting, as the characther 'a' and 'A' will not have the same ASCII values

      // Calculate the shift amount based on the keyword character's position in the uppercase alphabet
      int shift = keywordChar - 'A'; 

      char encryptedChar = (char) ((currentChar + shift - 'A') % 26 + 'A'); //shifts the characther currentChar, by adding the shift then subtracting the char 'A' to convert it into ASCII value,  afterwards saying modulo 26, to make sure it dosent go out of the alphabet, and finishing of by plussing char 'A' to reconvert it to normal


      // Convert back to lowercase if the original character was lowercase
      if (!isUpperCase) { 
        encryptedChar = Character.toLowerCase(encryptedChar); // make sure to set the right casing for the encrypted character, based on the orignal characted casing
      }

      encryptedText += encryptedChar;//adds encrypted characther to string encryptedText

      keywordIndex++; // increments keywordIndex by 1
    } else {
      encryptedText += currentChar;// else if characther is not a letter, add it to encryptedText unchanged
    }
  }

  return encryptedText; // return encryptedText
}

// Vigenère cipher decryption function
String vigenereDecrypt(String text, String keyword) { // declare string viginereDecrypt which has 2 variables passed called text and keyword
  String decryptedText = ""; ////clear the encrypted text
  int keywordIndex = 0; // asign value 0 to keywordIndex

  for (int i = 0; i < text.length(); i++) {
    char currentChar = text.charAt(i); // for loop through each letter of our text, which it temporarely saves in char currentChar

    if (Character.isLetter(currentChar)) { //checks if the currentChar is a letter, otherwise let the characther as it is
      char keywordChar = keyword.charAt(keywordIndex % keyword.length()); // we check the characther at the keyword index, taking into account that the keyword can be shorter than the text, a situation in which we will say modulo keyword length,
      //meaning that we will make the word repeat itself, for example if the keyword was cat, and text was hello it would go catca


      boolean isUpperCase = Character.isUpperCase(currentChar); // We initialize a boolean called isUpperCase where we store if the current char is upper case


      currentChar = Character.toUpperCase(currentChar); //Convert both characters to uppercase for consistent shifting, as the characther 'a' and 'A' will not have the same ASCII values
      keywordChar = Character.toUpperCase(keywordChar); //Convert both characters to uppercase for consistent shifting, as the characther 'a' and 'A' will not have the same ASCII values


      int shift = keywordChar - 'A'; // Calculate the shift amount based on the keyword character's position in the alphabet


      //shifts the characther currentChar, by adding the shift then subtracting the char 'A' to convert it into ASCII value,  afterwards saying modulo 26, to make sure it dosent go out of the alphabet, and finishing of by plussing char 'A' to reconvert it to normal
      char decryptedChar = (char) ((currentChar - shift - 'A' + 26) % 26 + 'A');

      // Convert back to lowercase if the original character was lowercase
      if (!isUpperCase) {
        decryptedChar = Character.toLowerCase(decryptedChar);
      }

      decryptedText += decryptedChar; //add the decrypted characther to decryptedText

      keywordIndex++; // increment keywordIndex by 1
    } else {
      // Append spaces and other non-letter characters as-is
      decryptedText += currentChar;
    }
  }

  return decryptedText; // return decryptedText
}
