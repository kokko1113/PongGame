int initialLeftPlayerY=300;
int initialRightPlayerY=300;
int leftPlayerY=initialLeftPlayerY;
int rightPlayerY=initialRightPlayerY;

int playerWidth=4;
int playerHeight=100;

int space=20; // 壁とプレイヤーとの距離

int ballSize=10;
int initialBallX=350;
int initialBallY=350;
int initialBallXSpped=4;
int initialBallYSpped=3;
int ballX=initialBallX;
int ballY=initialBallY;
int ballXSpeed=initialBallXSpped;
int ballYSpeed=initialBallYSpped;

boolean isFinished=true;
boolean isTime=false; //一時停止用のフラグ

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
void announceWinner(String winner){
    fill(0);
    textSize(50);
    text("winner :  "+winner,200,330);

    fill(255,0,0);
    if(winner=="LEFT"){
        rect(width-5,0,5,height);
    }else if(winner=="RIGHT"){
        rect(0,0,5,height);
    }
}

void restartGame(){
    isFinished=false;

    // すべての値を初期値に戻す
    leftPlayerY=initialLeftPlayerY;
    rightPlayerY=initialRightPlayerY;
    ballX=initialBallX;
    ballY=initialBallY;
    
    //ボールの最初の進行方向をランダムにした
    ballXSpeed=(random(1) < 0.5) ? initialBallXSpped : -initialBallYSpped;
    ballYSpeed=(random(1) < 0.5) ? initialBallXSpped : -initialBallYSpped;
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

public void setup(){
    size(700,700);
    background(255);
    
    restartGame();
}

public void draw(){
    if(isFinished || isTime) return;
    
    background(255); // 画面更新用
    
    fill(0);
    textSize(20);
    text("Enter :   restart        Esc :   time",100,20);

    makePlayers();

    // ボールのｘ座標が左プレイヤーを越したとき
    if(ballX <= playerWidth+space){
        if(!isHittedByLeftPlayer()){
            isFinished=true;
            announceWinner("RIGHT");
        }else{
            changeBallDerectionX();
        }
    }
    //ボールのｘ座標が右プレイヤーを越したとき
    else if(ballX >= width-(playerWidth+space)){
        if(!isHittedByRightPlayer()){
            isFinished=true;
            announceWinner("LEFT");
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
    
    // 試合終了時に再開
    if(key == ENTER || key == RETURN){
        restartGame();
    }
    // 中断する
    if (key == ESC) {
        key = 0; // ここで止めないとウィンドウが閉じる
        isTime = !isTime;
        textSize(100);
        fill(0);
        text("TIME",250,350);
    }
}

void mouseMoved() {
    leftPlayerY = mouseY;
}
