# 期末作業說明
#### 組譯器
### 了解運作過程後請gpt導師協助完成和理解
## 預設符號表 (SYMBOL_TABLE) 的用途

1. 預設符號表保存了內建符號和它們的對應地址。

2. 在組譯過程中，當遇到符號（如 @SP 或 @R3）時，可以直接通過符號表查詢對應的地址並轉換為二進制碼

3. SP（堆疊指標），地址是 0。

4. LCL（本地變數指標），地址是 1。

![圖](https://github.com/a3668/_co/blob/master/pic/screen.png)

## nextVariableAddress 是用來為新的變數符號分配地址的

## C 指令的對應表

    •	dest（目標寄存器）：指令運算的結果存放的位置。
    •	comp（計算部分）：表示計算或操作（如 D+A）。
    •	jump（跳轉條件）：決定程式是否跳轉到特定指令。

## cleanLine

### 清理 Hack 程式中的每一行指令，移除多餘的部分（註解與空白），使其適合進一步處理

1. 清理註解：確保僅保留有意義的指令部分。
2. 移除空白：使指令純淨，便於後續分析與翻譯。

## firstPass

firstPass 函數的目的是在組譯過程中第一次掃描指令，用來處理符號表中的標籤符號 (label)，並將這些標籤和其對應的行號儲存到 SYMBOL_TABLE 中。

1. firstPass 的目的是處理 (LABEL) 標籤符號，並記錄標籤對應的行號。
2. 它只處理標籤，不會影響其他指令。
3. 優點是使標籤可以在後續指令中用作符號，組譯器可以查找其對應的行號並轉換為地址。

## translateAInstruction

### 這個函數的目的是將 Hack 組合語言中的 A 指令 翻譯成對應的 16 位二進制機器碼。

1. 判斷 symbol 是否是數字。
2. 如果是符號，查詢或更新符號表。
3. 將地址轉換為二進制表示。

## translateCInstruction

### 這個函數用於將 C 指令 翻譯成對應的 16 位二進制機器碼。

1. 分析指令結構，提取 dest, comp, 和 jump。
2. 利用對應表將它們轉換為二進制碼。
3. 組合成最終的機器碼。

## secondPass

### secondPass 函數的主要目的是進行組譯過程的第二輪掃描，將每一條指令（清理後的 Hack 程式行）翻譯成最終的二進制機器碼。

#### 功能：處理清理後的指令，將 A 指令與 C 指令轉換為二進制碼。

#### 邏輯核心：

1. 判斷指令類型。
2. 分別使用 translateAInstruction 或 translateCInstruction 翻譯。
