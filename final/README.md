# 簡易組譯器專案完整說明

## 預設符號表 (SYMBOL_TABLE) 的用途

### 預設符號表保存了內建符號和它們的對應地址。

#### 在組譯過程中，當遇到符號（如 @SP 或 @R3）時，可以直接通過符號表查詢對應的地址並轉換為二進制碼

#### SP（堆疊指標），地址是 0。

#### LCL（本地變數指標），地址是 1。

[圖](/Users/kai/Desktop/te/_co/pic/screen.png)

### nextVariableAddress 的用途

#### nextVariableAddress 是用來為新的變數符號分配地址的。
