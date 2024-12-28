# Fill.asm 解釋

## **功能**

此程式實現了一個不斷檢測鍵盤輸入的功能，並根據鍵盤的狀態填充螢幕：

1. **如果偵測到任意鍵按下**：將螢幕的每個像素填為「黑色」(`-1`)。
2. **如果沒有鍵被按下**：清空螢幕，將每個像素填為「白色」(`0`)。

### **記憶體對應**

- **螢幕 (`SCREEN`) 起始地址**：`16384`。
  - 螢幕包含 `8192` 個 16-bit 的記憶體單元，從 `16384` 到 `24576`。
- **鍵盤 (`KBD`) 地址**：`24576`。
  - 當有鍵按下時，`M[24576] != 0`；否則 `M[24576] == 0`。

---

## **邏輯結構**

### 1. **主迴圈 (LOOP)**

主程式不斷檢測鍵盤輸入：

- 如果有鍵按下 (`KBD != 0`)，跳轉到填黑螢幕的程式 `(FILL)`。
- 如果沒有鍵按下 (`KBD == 0`)，跳轉到清空螢幕的程式 `(CLEAR)`。

### 2. **填黑螢幕 (FILL)**

- 從螢幕起始地址 (`16384`) 開始，將每個記憶體位置填入 `-1`（黑色）。
- 不斷遞增指標，直到螢幕結束地址 (`24576`)。

### 3. **清空螢幕 (CLEAR)**

- 從螢幕起始地址 (`16384`) 開始，將每個記憶體位置填入 `0`（白色）。
- 不斷遞增指標，直到螢幕結束地址 (`24576`)。

---

# Mult.asm 解釋

## **功能**

此程式實現了兩個非負整數的乘法運算，並將結果儲存在記憶體中：

- **輸入**：
  - `R0` (RAM[0])：第一個乘數。
  - `R1` (RAM[1])：第二個乘數。
- **輸出**：
  - `R2` (RAM[2])：乘積結果。

**條件**：

- 假設 `R0 ≥ 0` 且 `R1 ≥ 0`。
- 假設 `R0 * R1 < 32768`。

**注意**：

- 原始輸入值 `R0` 和 `R1` 不會被修改。

---

## **邏輯結構**

程式通過將 `R0` 多次相加的方式來實現乘法，`R1` 的值用作迴圈計數器，以下是程式的主要步驟：

1. **初始化結果變數**：

   - 將 `R2` 初始化為 `0`，用於累加乘法結果。

2. **保存計數器值**：

   - 使用 `R3` 作為計數器，保存 `R1` 的值，確保原始值不變。

3. **迴圈計算**：

   - 每次迴圈將 `R0` 的值加到 `R2` 中。
   - 遞減計數器 `R3`，直到計數器為 `0` 時結束。