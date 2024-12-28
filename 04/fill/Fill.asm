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

// Fill.asm
// 這個程式會不斷偵測鍵盤輸入：
// 如果偵測到任意按鍵，將螢幕每個像素填為黑色 (每個 word 寫為 -1)；
// 如果沒有按鍵，將螢幕清空 (每個 word 寫為 0)。

// 預先定義符號：
//   SCREEN = 16384   (螢幕的起始位址)
//   KBD    = 24576   (鍵盤的記憶體對應位址)
//
//   我們使用 R13 來作為螢幕位址的迴圈指標 (pointer)。

//-----------------------
// 主程式迴圈 (LOOP)
//-----------------------
(LOOP)
    @KBD      // 讀取鍵盤狀態
    D=M
    @FILL
    D;JNE     // 如果 D != 0 (表示有按鍵被按下) -> 跳到 FILL
    @CLEAR
    0;JMP     // 否則 -> 跳到 CLEAR

//-----------------------
// 填滿螢幕 (FILL)
//-----------------------
(FILL)
    @SCREEN   // SCREEN=16384 (預先定義符號)
    D=A       // D = 16384
    @R13
    M=D       // R13 = 16384  (螢幕位址指標，從頂端開始)

(LOOP_FILL)
    // 先檢查：是否已寫到螢幕尾端？
    @R13
    D=M
    @END_SCREEN
    D=D-A     // D = R13 - 24576
    @FILL_DONE
    D;JEQ     // 如果 R13 == 24576，代表整個螢幕都填好了 -> 跳 FILL_DONE

    // 如果還沒到尾端，就把該位址填入 -1 (0xFFFF) -> 全黑
    @R13
    A=M       // A = 當前螢幕位址
    M=-1      // 這個 RAM word 置為 -1 (所有位元 = 1 -> 黑)

    // 將 R13(指標) 加一，準備寫下一個像素字
    @R13
    M=M+1
    // 寫完後回到迴圈繼續檢查
    @LOOP_FILL
    0;JMP

(FILL_DONE)
    // 若已填滿或鍵盤狀態中途改變(下次回到 LOOP 會再偵測一次)
    @LOOP
    0;JMP

//-----------------------
// 清除螢幕 (CLEAR)
//-----------------------
(CLEAR)
    @SCREEN
    D=A
    @R13
    M=D       // R13 = 16384

(LOOP_CLEAR)
    @R13
    D=M
    @END_SCREEN
    D=D-A     // D = R13 - 24576
    @CLEAR_DONE
    D;JEQ     // 如果 R13 == 24576，就表示已清到螢幕尾

    // 將當前位置填為 0 (全白)
    @R13
    A=M
    M=0

    // 指標加一繼續
    @R13
    M=M+1
    @LOOP_CLEAR
    0;JMP

(CLEAR_DONE)
    @LOOP
    0;JMP

//-----------------------
// 螢幕尾端 (END_SCREEN)
//-----------------------
// 這個符號對應值為 24576 (KBD)，
// 但在組譯時只是拿來做比較用。
//-----------------------
(END_SCREEN)
    @24576    // 這行實際上 A=24576
    0;JMP     // 後面沒特別動作，只是提供比較用常數
