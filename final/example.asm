// 測試標籤和無條件跳轉
@2
D=A          // D = 2
@3
D=D+A        // D = 2 + 3
@RESULT
0;JMP        // 無條件跳轉到 RESULT

(RESULT)      // 標籤 RESULT
@0
M=D          // 將結果 D（5）存入 RAM[0]

// 測試條件跳轉
// 如果 2 > 1，則將 2 存入 RAM[1]；否則存入 0
@2
D=A          // D = 2
@1
D=D-A        // D = 2 - 1

@GREATER
D;JGT        // 如果 D > 0，跳轉到 GREATER

@0
D=A          // D = 0
@END
0;JMP        // 無條件跳轉到 END

(GREATER)     // D > 0 的情況
@2
D=A          // D = 2

(END)         // 結束
@1
M=D          // 將結果存入 RAM[1]

// 測試邏輯運算
// 計算 1 AND 3，結果存入 RAM[2]
@1
D=A          // D = 1
@3
D=D&A        // D = 1 AND 3
@2
M=D          // 將結果存入 RAM[2]

// 計算 1 OR 2，結果存入 RAM[3]
@1
D=A          // D = 1
@2
D=D|A        // D = 1 OR 2
@3
M=D          // 將結果存入 RAM[3]

// 無限循環，模擬器執行完畢後停在這裡
(INFINITE_LOOP)
@INFINITE_LOOP
0;JMP