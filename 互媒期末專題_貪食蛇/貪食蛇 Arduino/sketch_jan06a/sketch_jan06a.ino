int x1Value = 0 ;
int y1Value = 0 ;
int x2Value = 0 ;
int y2Value = 0 ;
int aValue = 0 ; 
int bValue = 0 ;

void setup()  
{ 
  Serial.begin(9600) ;
  pinMode(8,INPUT); 
  pinMode(9,INPUT); 
  digitalWrite(8,HIGH); 
  digitalWrite(9,HIGH);
} 
int prex1 = 0, prex2 = 0, prey1 = 0, prey2 = 0;
void loop() 
{ 
  x1Value = analogRead(A0);  
  y1Value = analogRead(A1); 
  aValue = digitalRead(8);
   
  x2Value = analogRead(A2);  
  y2Value = analogRead(A3);   
  bValue = digitalRead(9);
  if(abs(prex1 - x1Value) + abs(prey1 - y1Value) > 200 || abs(prex2 - x2Value) + abs(prey2 - y2Value) > 200){
    Serial.print(y1Value,DEC);
    Serial.print(",");
    Serial.print(x1Value,DEC);
    Serial.print(",");
    Serial.print(!aValue);
    Serial.print(",");
    Serial.print(y2Value,DEC);
    Serial.print(",");
    Serial.print(x2Value,DEC);
    Serial.print(",");
    Serial.print(!bValue);
    Serial.print("\n"); 
  }
//  Serial.print(y1Value,DEC);
//  Serial.print(",");
//  Serial.print(x1Value,DEC);
//  Serial.print(",");
//  Serial.print(!aValue);
//  Serial.print(",");
//  Serial.print(y2Value,DEC);
//  Serial.print(",");
//  Serial.print(x2Value,DEC);
//  Serial.print(",");
//  Serial.print(!bValue);
//  Serial.print("\n"); 
  prex1 = x1Value;
  prey1 = y1Value;
  prex2 = x2Value;
  prey2 = y2Value;
  delay(50);
}
