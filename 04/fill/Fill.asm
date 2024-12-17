// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
// 定義常數
@SCREEN
D=A            // D = SCREEN 基址
@screenBase
M=D            // 將 SCREEN 基址存入變數 screenBase

@SCREEN
D=A
@8192
D=D+A          // D = SCREEN + 8192
@screenEnd
M=D            // 定義螢幕結束地址 (screenEnd = SCREEN + 8192)

(INFINITE_LOOP)
// 讀取鍵盤輸入
@KBD
D=M            // D = KBD 的值

// 檢查鍵盤狀態
@BLACK_SCREEN
D;JNE          // 如果 D != 0 (鍵盤按下)，跳轉到 BLACK_SCREEN

@WHITE_SCREEN
0;JMP          // 如果 D == 0 (無按鍵)，跳轉到 WHITE_SCREEN

// 填滿黑色螢幕
(BLACK_SCREEN)
@screenBase
D=M            // D = SCREEN 基址
@i
M=D            // 初始化 i = SCREEN 基址

@-1
D=A            // D = -1 (黑色)

(FILL_BLACK_LOOP)
@i
A=M
M=D            // 當前記憶體位置填入黑色

@i
M=M+1          // i = i + 1

@screenEnd
D=M
@i
D=D-M          // D = screenEnd - i
@FILL_BLACK_LOOP
D;JGT          // 如果還沒到螢幕末尾，繼續填入黑色

@INFINITE_LOOP
0;JMP          // 返回無限循環

// 填滿白色螢幕
(WHITE_SCREEN)
@screenBase
D=M            // D = SCREEN 基址
@i
M=D            // 初始化 i = SCREEN 基址

@0
D=A            // D = 0 (白色)

(FILL_WHITE_LOOP)
@i
A=M
M=D            // 當前記憶體位置填入白色

@i
M=M+1          // i = i + 1

@screenEnd
D=M
@i
D=D-M          // D = screenEnd - i
@FILL_WHITE_LOOP
D;JGT          // 如果還沒到螢幕末尾，繼續填入白色

@INFINITE_LOOP
0;JMP          // 返回無限循環