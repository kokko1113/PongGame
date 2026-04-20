int leftPlayerY=0;
int rightPlayerY=0;

int playerWidth=4;
int playerHeight=100;

int space=20; // 壁とプレイヤーとの距離

int ballSize=10;
int initialBallX=50;
int initialBallY=50;
int initialBallXSpped=8;
int initialBallYSpped=5;
int ballX=initialBallX;
int ballY=initialBallY;
int ballXSpeed=initialBallXSpped;
int ballYSpeed=initialBallYSpped;

boolean isFinished=false;
boolean isTime=false;

// プレイヤー(ラケット)の表示を行う
void makePlayers(){
    fill(128);
    noStroke();
    // 左のプレイヤー
    leftPlayerY=constrain(leftPlayerY, 0, height-playerHeight);
    rect(space,leftPlayerY,playerWidth,playerHeight);

    // 右のプレイヤー
    rightPlayerY=constrain(rightPlayerY, 0, height-playerHeight);
    rect(width-(playerWidth+space),rightPlayerY,playerWidth,playerHeight);
}

void moveBall(){
    ballX+=ballXSpeed;
    ballY+=ballYSpeed;

    fill(255);
    stroke(0);
    ellipse(ballX,ballY,ballSize,ballSize);
}

void changeBallDerectionX(){
    ballXSpeed=-ballXSpeed;
}
void changeBallDerectionY(){
    ballYSpeed=-ballYSpeed;
}

// 結果を表示
void announceResult(String winner){
    fill(0);
    textSize(50);
    text("Finished!",250,330);

    fill(255,0,0);
    if(winner=="LEFT"){
        rect(width-5,0,5,height);
    }else if(winner=="RIGHT"){
        rect(0,0,5,height);
    }
}

void restartGame(){
    isFinished=false;

    ballX=initialBallX;
    ballY=initialBallY;
    ballXSpeed=initialBallXSpped;
    ballYSpeed=initialBallYSpped;
}

//ボールが左ラケットに当たったか判定
boolean isHittedByLeftPlayer(){
    println(ballY,leftPlayerY);
    boolean isHitted = ballY>=leftPlayerY && ballY<=leftPlayerY+playerHeight;
    println(isHitted);
    if(isHitted){
        return true;
    }else{
        return false;
    }
}
//ボールが右ラケットに当たったか判定
boolean isHittedByRightPlayer(){
    // println(ballY,rightPlayerY);
    boolean isHitted = ballY>=rightPlayerY && ballY<=rightPlayerY+playerHeight;
    // println(isHitted);
    if(isHitted){
        return true;
    }else{
        return false;
    }
}
// ボールが壁に接触したか
boolean isGameOver(){
    if(ballX<=0 || ballX>=width-ballSize){
        return true;
    }else{
        return false;
    }
}

public void setup(){
    size(700,700);
    background(255);
}
public void draw(){
    if(isFinished || isTime) return;
    
    background(255); // 画面更新用

    makePlayers();

    // ボールのｘ座標が左プレイヤーを越したとき
    if(ballX<=playerWidth+space){
        if(!isHittedByLeftPlayer()){
            if(isGameOver()){
                isFinished=true;
                announceResult("RIGHT");
            }
        }else{
            changeBallDerectionX();
        }
    }
    //ボールのｘ座標が右プレイヤーを越したとき
    else if(ballX>=width-(playerWidth+space)){
        if(!isHittedByRightPlayer()){
            if(isGameOver()){
                isFinished=true;
                announceResult("LEFT");
            }
        }else{
            changeBallDerectionX();
        }
    }

    if(ballY<=0||ballY>=height-ballSize){
        changeBallDerectionY();
    }
    
    moveBall();
}

void keyPressed() {
    // 右プレイヤー操作
    if(keyCode==UP){
        rightPlayerY-=20;
    }else if(keyCode==DOWN){
        rightPlayerY+=20;
    }
    // 左プレイヤー操作
    if(key=='w'){
        leftPlayerY-=20;
    }else if(key=='s'){
        leftPlayerY+=20;
    }
    // 試合終了時に再開
    if(key=='r'){
        restartGame();
    }
    // 中断する
    if (key == ESC) {
        key = 0; // ここで止めないとウィンドウが閉じる
        isTime = !isTime;
    }
}

void mouseMoved() {
    leftPlayerY = mouseY;
}