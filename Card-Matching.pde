
//The game: there are two rows of cards and one extra card at the bottom. The goal of the game is to find one card from each row that matches the colour of the bottom card.


int screen = 0;  //controls the screen that you are seeing
PFont font; //setup the font
PImage stamp; //for the image in screen 0
int num = 8; //number of cards. throughout the code, I use num/2 because i created different arrays for row 1 and row 2 so the number of cards in each row is the total number divided by 2
int[] card1 = new int[num/2];  //array for the x-coordinates of the cards in the first row
int[] card2 = new int[num/2]; //array for the x-coordinates of the cards in the second row
int y1 = 70; //y coordinate of all the cards in the first row. Since they all have the same value, it is not an array
int y2 = 240; //y coordinate of all the cards in the second row.
boolean[] flip = new boolean[num]; //this checks to see if a card in the first row is flipped. it is a boolean array since the card can only be either flipped or unflipped.
boolean[] flip2 = new boolean[num]; //same as above but for row 2
int[] colours = new int[num/2]; //controls the fill colour of each card in the top row. Each card has a different colour which is why this is an array.
int[] colour2 = new int[num/2]; //controls the fill colour of each card in the bottom row.
int randcol; //the colour of the bottom box. Since there is only one box that has this value, it is not an array.
int count = 0; //checks to see if the card flipped in the top row is the colour of the 'extra' box.
int count2 = 0; //checks to see if the card flipped in the second row is the colour of the 'extra' box.



void setup(){
  //setup the screen size and loads the image to the game
  size(640, 480);
  stamp = loadImage("stamp.png");

  //row 1:
  //sets up the x-coordinate of each card in the first row
  card1[0] = 70; //e.x. the x-coordinate of the first card is 70
  card1[1] = 200;
  card1[2] = 330;
  card1[3] = 460;
  //row 2:
  //sets up the x-coordinate of each card in the second row. 
    //This is a seperate array since, although the values are the same, there is a card that matches in both the bottom and top, which means that they would need to be compared seperately
  card2[0] = 70;
  card2[1] = 200;
  card2[2] = 330;
  card2[3] = 460;
  //this makes sure that all the cards in both the top and bottom rows are unflipped so that when they are clicked they can be flipped. (flip[i] would be true when they are clicked). This part is not necessary, however, it makes sense logically to have the flip value be true when it is flipped
  for (int i = 0; i < num; i++) {
    flip[i] = false;
    flip2[i] = false;
  }
 
  //manually sets the fill colours of each card in the top row. 
  colours[0] = 255; //ex the top left card will be white
  colours[1] = 170;
  colours[2] = 0;
  colours[3] = 80;
 
  for (int i = 0; i < num / 2; i++) {
    colour2[i] = colours[i];  //assigns each element in the colour2 array a value. This is to ensure that the colour2 array already has one i value that matches one in the colours array. This way when the order is mixed up, it ensures that there is only one card that matches in both the top and bottom rows.
    randcol = colours[int(random(3))];  //makes the colour of the bottom box a random colour that matches the colour of one of the boxes in the top row
  }

  //matches a random card in the bottom row to the colour of the card in the top row. see the function for more details.
  cmatch(colour2);



}

void draw(){
  //sets background of all the screens
  background(131, 219, 250);
  if (screen == 0){  //sets up the welcome screen (screen 0)
    fill(232, 210, 176); //default card colour
    //draws postcard
    rect(75, 100, 500, 300); 
    font = loadFont("BookAntiqua-Italic-48.vlw");  //sets up font
    textFont(font); //sets up font
    fill(0); //text color: black
    textSize(40);
    //postcard text
    text("welcome to...", 360, 240);
    textSize(60);
    text("Memory Cards", 150, 340);
    //white corner square
    fill(255);
    rect(500, 130, 50, 50);
    //adds the stamp image to the postcard
    stamp.resize(120, 80);
    image(stamp, 140, 150);
    //instruction to move to the next screen
    text("press any key to start!", 40, 70);
  }

 
 
 //MAIN GAME SCREEN
  if (screen == 2){
   //for loop creates a rectangle (card) at each x-coordinate and y-coordinate that were previously defined.
    for (int i = 0; i < num/2; i++){
      rect(card1[i], y1, 100, 100);
      rect(card2[i], y2, 100, 100);
    }
    //for loop used to iterate through the element number of the arrays
    for (int i = 0; i < num/2; i++) {
      //row 1: this code checks/draws the cards in row 1
        //checks to see if the card is flipped over
        if (flip[i]) {
          //if the card is flipped, it fills the card with the colour that was previously assigned to the array.
          fill(colours[i]); //the fill only applies to the card that is clicked because the card function draws a square on top of the original square, so there is only one card drawn after the fill is added until the code loops
          card(card1[i], y1); 
          if (colours[i] == randcol){  //this checks to see if the colour of the box is the same as the colour of the bottom box.
                fill(131, 219, 250);   //if the colour is the same, it creates another card on top of the flipped card by using its x-coordinate from the card1 array and y coordinate and makes it the same colour as the background.
                card(card1[i], y1);
                fill(0); 
                textSize(20);
                text("found", card1[i] + 20, y1 + 20); //it also adds text to let the person know they found the right card. this text is placed on the card using the x and y coordinate of that card
                count = 1;  //this is used later to end the game.
              } 
              
        } else {
          // The card is not flipped over. It makes the initial card with the default fill colour at the x and y coordinates (for the first row) that were already defined.
          fill(232, 210, 176);  
          rect(card1[i], y1, 100, 100);
        }
        //row 2: this code checks/draws the cards in row 2
        //this section of code basically does what the part above did except for row 2 (using the x and y coordinates that were already stored in the card2 array and y2 variable)
        if (flip2[i]) {
          fill(colour2[i]);
          card(card2[i], y2);
              if (colour2[i] == randcol){
                fill(131, 219, 250);
                card(card2[i], y2);
                fill(0);
                textSize(20);
                text("found", card2[i] + 20, y2 + 20);
                count2 = 1;
              }
        } else {
          fill(232, 210, 176);
          rect(card2[i], y2, 100, 100);
        }
        
        //this draws out the bottom card that the player is supposed to match to with the fill that was randomly determined earlier
        fill(randcol);
        card(270, 370);
        
      
      }
      
      //these variables only equal one if the card from each respective row that matches has been found, otherwise their value is 0. If both have a value of 1, they can move to the win screen
      if (count == 1 && count2 == 1){
        screen++; //adds to the screen number so they move to screen 3
      }
  }
  
  
  if (screen == 3){  //only runs this code if the screen code is 3
    fill(0);
    text("congrats on finishing!", width/2, height/2);  //text that congratulates the player for matching
  }
  
  //this is the screen that comes after the welcome. It gives instructions.
  if (screen == 1){ //if statement to ensure that this only happens if it is on screen 1
    //writes out the instructions for the game
    textSize(20);
    fill(0);
    text("instructions: ", 10, 100);
    text("find one box from each row that matches the colour of the bottom box", 10, 120);
    text("click the mouse to continue", 10, 300);
  }
 
}


void keyPressed(){
  //at the welcome screen, if any key is pressed it switches to the next (instruction) screen
  if(screen == 0){
    screen++;
  }
 
}

void mousePressed(){
  //at the instruction screen, if the mouse is clicked, the screen goes onto the next (main) screen
  if(screen == 1){
   screen++ ;
  }
  
  //runs if the mouse is pressed and the player is on the main screen
  if(screen == 2){
  for (int i = 0; i < num/2; i++) {  //for loop iterates through each element in the card arrays. this allows it to figure out which card is clicked
    //top row
    if (mouseX > card1[i] && mouseX < card1[i] + 100 && mouseY > y1 && mouseY < y1 + 100) {  
      //uses the x coordinate of the card and its width and compares it to the mouse position. If the mouse is in between the x-coordinate and the x-coordinate+the width, it moves on to checking the y.
      //uses the x coordinate of the card and its height and compares it to the mouse position. If the above conditions are met and if the mouse is in between the x-coordinate and the x-coordinate+the height, it runs this code.
      flip[i] = !flip[i]; // Flip the card if it's clicked. so if the card is clicked, it switches between true (default fill) or false (unique colour) depending on whether or not it was filled before using the for logic gate
    }
    //bottom row
    if (mouseX > card2[i] && mouseX < card2[i] + 100 && mouseY > y2 && mouseY < y2+ 100) {
      //does the same thing as the if statement for card1 but for the bottom row
      flip2[i] = !flip2[i];
      
    }
  }
  }
 
}

//this function draws a square at the specified x and y coordinates with a height of 100. This is used to streamline the process of the cards that are being drawn on top in the main code if the card is clicked/flipped
void card(int x, int y){
  rect(x, y, 100, 100);
}

//this is used to match the colours of the bottom row to a random element of the colours of the top row
void cmatch(int[] col) {  //parameter takes in the entire colour2 array and creates another array with those same values for the function
  for (int i = 0; i < num/2; i++) {   //for loop iterates through every element of the array
    int b = int(random(num/2));   //selects a random element from the "col" array
    int temp = col[i];  //stores the value for the current element to an element in the temporary array
    col[i] = col[b];    //makes the random value chosen in b the value of the col array for that element. so if b was 3 and i was 1, col[1] would become col[3]. This allows the element number to stay the same but the value to switch
    //note: the line above is why it was important to make the colour2 array already have values the same as the colours of the top row, since this function just switches around the colours but does not change their actual value.
    col[b] = temp;   //stores the randomly chosen element's value and stores it in the temp array. this allows the original value of col[i] to remain intact so that the value can still be used for another card.
  }
}
