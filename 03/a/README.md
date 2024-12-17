# Bit 解釋

## 邏輯

1.  ### DFF：負責儲存位元值並在時鐘上升沿時更新輸入。

    ### Mux：根據 load 選擇 DFF 的輸入來源：

2.  **當 load == 1**：
    - 輸出會更新為輸入值 in。
3.  **當 load == 0**：
    - 輸出維持不變，保持先前的值。

---

# Register 解釋

1. **控制邏輯**

   - load 信號會同步影響所有 Bit：

     - **當 load == 1**：
       - 每個 Bit 將對應的輸入值 in[i] 儲存起來。
     - **當 load == 0**：
       - 每個 `Bit` 保持之前儲存的值，輸出不變。

   - 16 個 Bit 元件會同時接收輸入和 load 控制信號，並根據邏輯決定是否更新輸出。

---

# RAM8 解釋

1. 寫入操作 (load == 1)：
   DMux8Way 解碼 address，啟動對應的 load 信號。
   選中的 Register 將輸入值 in 儲存起來。
2. 讀取操作 (out)：
   Mux8Way16 根據 address，從 8 個寄存器中選擇對應的輸出，並將其傳送到 out。

---

# RAM64 解釋

1. 寫入操作 (load == 1)
   tep 1：DMux8Way
   使用 address[3..5]（高 3 位元）解碼 load 信號，啟動對應的 RAM8 模組的 load 信號。
   例如，當 address[3..5] == 000 時，啟動 RAM8 的 load0。

   Step 2：RAM8 寫入
   將 address[0..2]（低 3 位元）傳遞給被啟動的 RAM8，指定該 RAM8 內部的記憶位置。
   選中的 RAM8 將輸入值 in 儲存起來。

2. 讀取操作
   Step 3：Mux8Way16
   使用 address[3..5] 選擇 8 個 RAM8 中的輸出，並將該輸出傳送到 out。
   例如，當 address[3..5] == 001 時，選擇 RAM8 的 out1。

---
