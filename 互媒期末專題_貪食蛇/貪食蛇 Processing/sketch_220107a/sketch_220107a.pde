import processing.serial.*;
Serial myPort;
PImage menu, leave, home, replay;
PImage end;
PFont zigBlack;
String Winner;
Snake snack;
Snake snack2;
Candy candy[];
int pos = -1;
int flag, state;
boolean click;
int x1 = 500, y1 = 500, bt1 = 0, x2 = 500, y2 = 500, bt2 = 0;
void setup(){
  frameRate(10);
  zigBlack = createFont("GenEiMGothic2-Bold.ttf", 32);
  state = 0;
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 9600);
  size(800, 600);
  noStroke();
  
  snack = new Snake(100 + 15 + 30, 15 + 30, 50, 205, 50);
  snack2 = new Snake(600 + 100 - 15 - 30, 600 - 15 - 30, 70, 130, 180);
  candy = new Candy[5];
  for(int i = 0; i < 5; i++){
    candy[i] = new Candy();
  }
  menu = loadImage("menu.png");
  replay = loadImage("replay.png");
  leave = loadImage("leave.png");
  home = loadImage("home.png");
  end = loadImage("end.png");
}

void mousePressed(){
  click = true;
}

void draw(){
  getData();
  if(state != 1){
    x1 = 500;
    y1 = 500;
    x2 = 500;
    y2 = 500;
  }
  background(255);
  textFont(zigBlack, 100);
  if (state == 0){ // homepage
    snack = new Snake(100 + 15 + 30, 15 + 30, 50, 205, 50);
    snack2 = new Snake(600 + 100 - 15 - 30, 600 - 15 - 30, 70, 130, 180);
    //background(bg);
    fill(0, 168, 0);
    textAlign(CENTER);
    textSize(60);
    text("雙人對戰貪食蛇", 400, 150);
    rect(130, 350, 200, 100);
    rect(430, 350, 200, 100);
    fill(250, 250, 0);
    textAlign(CENTER);
    textSize(30);  
    text("Start", 230, 410);
    text("Manual", 530, 410);
    if (click == true && mouseButton == LEFT && mouseX > 130 && mouseX < 330 && mouseY > 350 && mouseY < 450)
    {
      click = false;
      state = 1;
      flag = 0;
    }
    if(click == true && mouseButton == LEFT && mouseX > 430 && mouseX < 630 && mouseY > 350 && mouseY < 450)
    {
      click = false;
      state = 2;
      flag = 0;
    }
    
    image(menu, 700, 500, 80, 80);
    if (click == true && mouseButton == LEFT && mouseX > 700 && mouseX < 780 && mouseY > 500 && mouseY < 580){
      click = false;
      flag++;
      if (flag > 1)
        flag = 0;
    }
    if (flag == 1)
    {
      image(replay, 710, 420, 80, 80);
        if (click == true && mouseButton == LEFT && mouseX > 710 && mouseX < 770 && mouseY > 420 && mouseY < 500){
          click = false;
          state = 1;
          flag = 0;
        }
    
      image(home, 660, 450, 50, 50);
        if (click == true && mouseButton == LEFT && mouseX > 660 && mouseX < 710 && mouseY > 450 && mouseY < 500){
          click = false;
          state = 0;
          flag = 0;
        }
        
      image(leave, 620, 510, 60, 60);
        if (click == true && mouseButton == LEFT && mouseX > 620 && mouseX < 680 && mouseY > 510 && mouseY < 570){
          click = false;
          exit();
        }
    }
  }
  else if (state == 1){ // game
    background(127);
    for(int i = 0 + 100; i < 600 + 100; i += 30){
      for(int j = 0; j <= 600; j += 30){
        if((i - 100 + j) % 60 == 0){
          fill(255, 255, 255);
          rect(i, j, 30, 30);
        }
        else{
          fill(220, 220, 220);
          rect(i, j, 30, 30);
        }
      }
    }
    for(int i = 0; i < 5; i++){
      candy[i].born();
      candy[i].display();
      if(candy[i].eaten(snack.x[0], snack.y[0])){
        if(candy[i].gold == 1){
          snack.snack_len += 3;
        }
        else{
          snack.snack_len++;
        }
      }
      if(candy[i].eaten(snack2.x[0], snack2.y[0])){
         if(candy[i].gold == 1){
          snack2.snack_len += 3;
        }
        else{
          snack2.snack_len++;
        }
      }
    }
    snack2.move(x2, y2);
    snack.move(x1, y1);
    if(snack.die_check(snack2)){
      state = 3;
      Winner = "P2";
      println("lose");
    }
    if(snack2.die_check(snack)){
      state = 3;
      Winner = "P1";
      println("lose");
    }
    snack.display();
    snack2.display();
    delay(125);


    // ------ menu ------
     image(menu, 700, 500, 80, 80);
    if (click == true && mouseButton == LEFT && mouseX > 700 && mouseX < 780 && mouseY > 500 && mouseY < 580){
      click = false;
      flag++;
      if (flag > 1)
        flag = 0;
    }
    if (flag == 1)
    {
      image(replay, 710, 420, 80, 80);
        if (click == true && mouseButton == LEFT && mouseX > 710 && mouseX < 770 && mouseY > 420 && mouseY < 500){
          click = false;
          state = 1;
          flag = 0;
        }
    
      image(home, 660, 450, 50, 50);
        if (click == true && mouseButton == LEFT && mouseX > 660 && mouseX < 710 && mouseY > 450 && mouseY < 500){
          click = false;
          state = 0;
          flag = 0;
        }
        
      image(leave, 620, 510, 60, 60);
        if (click == true && mouseButton == LEFT && mouseX > 620 && mouseX < 680 && mouseY > 510 && mouseY < 570){
          click = false;
          exit();
        }
    }

  }

  else if(state == 2)  //descript
  {
    //background(bg);
    x1 = 500;
    y1 = 500;
    x2 = 500;
    y2 = 500;
    textFont(zigBlack, 100);
    fill(0, 168, 0);
    textAlign(CENTER);
    textSize(65);
    text("遊戲說明", 400, 150);
    textSize(40);
    text("雙人對戰貪食蛇", 400, 250);
    text("Player 1 與 Player 2 同", 400, 300);
    text("時按下按鍵則開始遊戲，由搖", 400, 350);
    text("桿控制蛇的行徑方向，遊戲途", 400, 400);
    text("中，不可以撞擊牆壁與雙方身", 400, 450);
    text("體，如果撞擊則對方勝利。", 400, 500);
    
    image(menu, 700, 500, 80, 80);
    if (click == true && mouseButton == LEFT && mouseX > 700 && mouseX < 780 && mouseY > 500 && mouseY < 580){
      click = false;
      flag++;
      if (flag > 1)
        flag = 0;
    }
    if (flag == 1)
    {
      image(replay, 710, 420, 80, 80);
        if (click == true && mouseButton == LEFT && mouseX > 710 && mouseX < 770 && mouseY > 420 && mouseY < 500){
          click = false;
          state = 1;
          flag = 0;
        }
    
      image(home, 660, 450, 50, 50);
        if (click == true && mouseButton == LEFT && mouseX > 660 && mouseX < 710 && mouseY > 450 && mouseY < 500){
          click = false;
          state = 0;
          flag = 0;
        }
        
      image(leave, 620, 510, 60, 60);
        if (click == true && mouseButton == LEFT && mouseX > 620 && mouseX < 680 && mouseY > 510 && mouseY < 570){
          click = false;
          exit();
        }
    }
  }
  else if(state == 3){
    background(255);
    image(end, 300, 0, 200, 200);
    textAlign(CENTER);
    textSize(100);
    fill(0);
    text(Winner + " Win!!", 800 / 2, 600 / 2);
    textSize(40);
    text("Press Any Key To Restart...", 400, 500);
    if(click == true){
      click = false;
      //snack = new Snake(100 + 15 + 30, 15 + 30, 50, 205, 50);
      //snack2 = new Snake(600 + 100 - 15 - 30, 600 - 15 - 30, 70, 130, 180);
      state = 0;
    }
  }
}

class Snake{
  int x[] = new int[100];
  int y[] = new int[100];
  int snack_len;
  int size = 30;
  int prev_pos = -1;
  int r, g, b;
  Snake(int _x, int _y, int _r, int _g, int _b){
    x[0] = _x;
    y[0] = _y;
    snack_len = 3;
    r = _r;
    g = _g;
    b = _b;
  }
  void move(int _x,int _y){
    if(_x <= 300 && prev_pos == 0){
      x[0] -= 30;
    }
    else if(_x >= 700 && prev_pos == 1){
      x[0] += 30;
    }
    else if(_y >= 700 && prev_pos == 2){
      y[0] -= 30;
    }
    else if(_y <= 300 && prev_pos == 3){
      y[0] += 30;
    }
    else{
      if(_x >= 700){
        x[0] -= 30;
        prev_pos = 0;
      }
      else if(_x <= 300){
        x[0] += 30;
        prev_pos = 1;
      }
      else if(_y <= 300){
        y[0] -= 30;
        prev_pos = 2;
      }
      else if(_y >= 700){
        y[0] += 30;
        prev_pos = 3;
      }
      else{
        if(prev_pos == 0){
          x[0] -= 30;
        }
        else if(prev_pos == 1){
          x[0] += 30;
        }
        else if(prev_pos == 2){
          y[0] -= 30;
        }
        else if(prev_pos == 3){
          y[0] += 30;
        }
      }
    }
    delay(1);
    for(int i = snack_len; i >= 1; i--){
      x[i] = x[i - 1];
      y[i] = y[i - 1];
    }
  }
  void display(){
    fill(this.r, this.g, this.b);
    for(int i = 0; i <= snack_len; i++){
      fill(r - 10 * i, g - 10 * i, b - 10 * i);
      circle(x[i], y[i], size);
    }
  }
  boolean die_check(Snake enemy){
    for(int i = 4; i <= this.snack_len; i++){
      if(x[0] == x[i] && y[0] == y[i]){
        return true;
      }
    }
    for(int i = 1; i <= enemy.snack_len; i++){
      if (x[0] == enemy.x[i] && y[0] == enemy.y[i]){
        return true;
      }
    }
    if(x[0] < 100 || x[0] > 700 || y[0] < 0 || y[0] > 600){
      return true;
    }
    return false;
  }
}

class Candy{
  int x, y;
  int size = 30;
  int gold = 0;
  boolean alive = false;
  void display(){
    if(alive == true){
      if(gold == 1){
        fill(255, 255, 0);
      }
      else{
        fill(255, 0, 0); 
      }
      circle(x, y, 30);
    }
  }
  void born(){
    if(alive == false){
      gold = 0;
      alive = true;
      if(random(0, 1) > 0.9){
        gold = 1;
      }
        boolean flag = true;
        while(flag == true){
          flag = false;
          this.x = int(random(45 + 100 + 30, 600 + 100 - 30));
          this.y = int(random(45 + 30, 600 - 30));
          while((this.x -100) % 30 != 0){
            this.x--;
          }
          while((this.y) % 30 != 0){
            this.y--;
          }
          this.x += 15;
          this.y += 15;
        }
        for(int i = 0; i <= snack.snack_len; i++){
          if(snack.x[i] == x && snack.y[i] == x){
            flag = true;
          }
        }
        for(int i = 0; i <= snack2.snack_len; i++){
          if(snack2.x[i] == x && snack2.y[i] == x){
            flag = true;
          }
        }
        for(int i = 0; i < 5; i++){
          if(candy[i].x == x && candy[i].y == y){
            flag = true;
          }
        }
      }
  }
  boolean eaten(int snack_x, int snack_y){
    if((snack_x - this.x) * (snack_x - this.x) + (snack_y - this.y) * (snack_y - this.y) < size * size){
      alive = false;
      return true;
    }
    return false;
  }
}
void getData() {
  String msg;
  if (myPort.available() > 0) {
    msg = myPort.readStringUntil('\n');
    if (msg != null)
    {
          msg = trim(msg);
          //println(msg);
          String[] token = msg.split(",");
          if(token.length < 6){
            return;
          }
          println(token);
          x1=int(token[0]);
          y1=int(token[1]);
          bt1=int(token[2]);
          //println(x1, x2, bt1);
          x2=int(token[3]);
          y2=int(token[4]);
          bt2=int(token[5]);
          //println(x1, x2, bt1);
    }
  }
}
