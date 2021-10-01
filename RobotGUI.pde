import processing.serial.*; //Importing the Serial library.
Serial myPort; // Creating a port variable.
int r,g,b; // initializing colours.
String T= "Rover Controller X"; // Creating word strings for the interface.
String D= "Drive Controls"; 
String C= "Camera Controls";
String X= "Auxiliary Controls";
String T1= "FWD";
String T2= "RHT";
String T3= "LFT";
String T4= "BWD";
String T5= "Light On";
String T6= "Light Off";
String LT= "←";
String RT= "→";
String UT= "↑";
String DT= "↓";
String TEST= "ScreenTest";
String CLR= "Clear Screen";
String DD= "Display Dist";
String DHT= "Display DHT";

void setup()
{
  size(1000,600); // Creating the display window and defining its' size.
 
  r = 0; // Setting up the colours.
  g = 0;
  b = 0;

println(Serial.list()); // IMPORTANT: prints the availabe serial ports.
String portName = Serial.list()[0]; // change the 0 to a 1 or 2 etc, to match your port (Play with it until you find the one that works for you- It's probably 11!)
  myPort = new Serial(this, portName, 9600); // Initializing the serial port.
}
 
void draw()
{
   
  background(102,0,255); // Setting up the background's colour- Purple.
  // Print random Objects
  fill(204,204,204);
  rect(0, 290, 1000, 50,7); // (int x, int y, int width, int height, edge type)
  //
  // Draw Drive Controls
  fill (255,255,255); // Painting the Arrows White.
  rect(750, 170, 100, 100,7); // BWD rectangle  (int x, int y, int width, int height)
  rect(750, 60, 100, 100,7); //FWD for 5secs triangle
  rect(860, 170, 100, 100, 7); //RHT for 5secs triangle
  rect(640, 170, 100, 100, 7); //LFT for 5secs triangle         
  //
  // Draw Extra functions
  fill (255,255,255); //
  rect(178, 400, 100, 100,7); // Light On
  rect(288, 400, 100, 100,7); // Light Off
  rect(398, 400, 100, 100,7); // Display Distance
  rect(508, 400, 100, 100,7); // Display Temperature and Humidity
  rect(618, 400, 100, 100,7); // Clear Screen
  rect(728, 400, 100, 100,7); // Test Screen
  
  //
  // Draw Camera Controls
  fill (255,255,255); //
  rect(150, 170, 100, 100,7); // Camera Down 
  rect(150, 60, 100, 100,7); // Camera Up
  rect(260, 170, 100, 100, 7); // Camera Right
  rect(40, 170, 100, 100, 7); // Camera Left
  //
  // Print Headings
  textSize(32); // Defining the headlines size
  fill (0,0,0); // painting the headline black.
  text(T, 354, 26);  // Heading TXT
  //
  // Print Sub-Headings
  textSize(20); // Defining the headlines size
  fill (255,255,255); // painting the headline black.
  text(D, 730, 46);  // Drive Controls TXT
  text(C, 115, 46);  // Camera Controls TXT
  fill (255,0,0);
  text(X, 410,320); // Auxiliary Controls TXT
  //
  // Print Keys for Drive controls
  textSize (20); // The arrow keys text size- 20
  fill (0,0,0); // coloring .
  text(T1, 780, 130); //FWD
  text(T2, 885, 230);//RHT
  text(T3, 680, 230); //LFT
  text(T4, 780, 230);//BWD
  //
  // Print Keys for Extra Functions
  textSize(14);
  text(T5, 200, 455); // Light On
  text(T6, 308, 455); // Light Off
  text(DD, 406, 455); // Display Distance
  text(DHT, 515, 455); // Display Temperature and Humidity
  text(CLR, 625, 455); // Clear Screen
  text(TEST, 740, 455); // Tets Screen
  //
  // Print Keys for Camera controls
  textSize (20); // The arrow keys text size- 20
  fill (0,0,0); // 
  text(UT, 194, 130); // UP
  text(RT, 299, 230);// Down
  text(LT, 80, 230); // Left
  text(DT, 194, 230);// Right
  //
  // Print Keys for button labels
  textSize (15); // 
  fill (0,0,0); // 
  text("(z)", 220, 475); //
  text("(x)", 330, 475); //
  text("(c)", 440, 475); //
  text("(v)", 550, 475); //
  text("(b)", 660, 475); //
  text("(n)", 770, 475); //
  //
  text("(w)",190,155); //
  text("(a)",80,265); //
  text("(s)",190,265); //
  text("(d)",300,265); //
  //
  text("(I)",790,155); //
  text("(J)",690,265); //
  text("(K)",790,265); //
  text("(L)",900,265); //
  
  //
}
 
void keyPressed()
{
 
 
  switch (key) {//Switch case: Sending different signals and filling different arrows red according to which button was pressed.   
  
     case 'i': //In case the UP button was pressed:
     myPort.write('i'); // Send the signal 1w
     println("Drive Forwards 2 seconds!"); // + Print "UP!" (Debugging only) 
     fill(255,0,0); // + Fill the up triangle with red.
     rect(750, 60, 100, 100,7);
 
     break;
     
    case 'k':
    myPort.write('k');
    println("Reverse 2 seconds!");
    fill(255,0,0);
    rect(750, 170, 100, 100,7);

    break;
    
    case 'j':
    myPort.write('j');
    println("Turn Left 2 seconds!");
    fill(255,0,0);
    rect(640, 170, 100, 100, 7);
  
    break;
    
    case 'l':
    myPort.write('l');
    println("Turn Right 2 seconds!");
    fill(255,0,0);
    rect(860, 170, 100, 100, 7);
   
    break;
    
    case 'w' :
    myPort.write ('w');
    println("Camera Up!");
    fill(255,0,0);
    rect(150, 60, 100, 100,7);

    break;
    
    case 's':
    myPort.write ('s');
    println("Camera Down!");
    fill(255,0,0);
    rect(150, 170, 100, 100,7);

    break;
    
    case 'a':
    myPort.write ('a');
    println("Camera Left!");
    fill(255,0,0);
    rect(40, 170, 100, 100, 7);

    break;
    
    case 'd':
    myPort.write ('d');
    println("Camera Right!");
    fill(255,0,0);
    rect(260, 170, 100, 100, 7);

    break;
    
    case 'z':
    myPort.write ('z');
    println("Light On!");
    fill(255,0,0);
    rect(178, 400, 100, 100,7);

    break;
    
    case 'x' :
    myPort.write ('x');
    println("Lights Off!");
    fill(255,0,0);
    rect(288, 400, 100, 100,7);

    break;
    
    case 'c' :
    myPort.write ('c');
    println("Display Distance!");
    fill(255,0,0);
    rect(398, 400, 100, 100,7);

    break;
    
    case 'v' :
    myPort.write ('v');
    println("Display Temp and Humidity!");
    fill(255,0,0);
    rect(508, 400, 100, 100,7);

    break;
    
    case 'b' :
    myPort.write ('b');
    println("Clear Screen!");
    fill(255,0,0);
    rect(618, 400, 100, 100,7);

    break;
    case 'n' :
    myPort.write ('n');
    println("Screen Test!");
    fill(255,0,0);
    rect(728, 400, 100, 100,7);

    break;
    case ' ' :
    myPort.write (' ');
    println("Stop!");
    break;
    default:
    break;
  }
}
