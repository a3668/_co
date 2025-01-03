#ALU
ALU（算術邏輯單元）的 out 輸出是基於 zx, nx, zy, ny, f, 和 no 信號對輸入 x 和 y 進行的運算結果。具體來說，ALU 的運算過程如下： 1. 處理 x 輸入：
• zx（zero the x input）：如果 zx 為 1，則將 x 設為 0（即 x = 0）。
• nx（negate the x input）：如果 nx 為 1，則將 x 取反（即 x = ~x，將所有位反轉）。 2. 處理 y 輸入：
• zy（zero the y input）：如果 zy 為 1，則將 y 設為 0（即 y = 0）。
• ny（negate the y input）：如果 ny 為 1，則將 y 取反（即 y = ~y）。 3. 選擇運算方式：
• f（選擇加法或與運算）：如果 f 為 1，則 out = x + y（即執行加法運算）；如果 f 為 0，則 out = x & y（即執行按位與運算）。 4. 處理輸出：
• no（negate the output）：如果 no 為 1，則將最終的 out 取反（即 out = ~out）。

總結：

out 是根據以下幾個條件運算得到的：
• 首先處理 x 和 y 輸入，根據 zx, nx, zy, 和 ny 信號對其進行操作。
• 然後根據 f 信號選擇加法運算 (x + y) 或按位與運算 (x & y)。
• 最後，根據 no 信號，決定是否對輸出進行取反操作。

## 二補數表示法：-x = x'+1

在二補數系統中，正數的表示方式是普通的二進制數，而負數則是通過對該正數的二進制表示取反（求反碼）後，再加 1 來得到。例如：
• 假設我們有一個正數 x，它的二進制表示為 x。
• 要得到 -x 的表示： 1. 先對 x 進行取反：即將每一位（bit）反轉（0 變 1，1 變 0）。這個步驟得到的是反碼（complement of x），表示為 x'。 2. 再將結果加 1：對反碼加 1 就得到了二補數的負數表示，即 x' + 1。 2. 具體例子：
假設我們以 8 位數字為例：
• x = 3，其二進制表示為 00000011。
• 要得到 -3 的二補數表示，按照上述步驟： 1. 先對 3 取反：00000011 → 11111100（反碼 x'）。 2. 再加 1：11111100 + 1 → 11111101（這就是 -3 的二補數表示）。 3. 為什麼這樣表示負數？
二補數的設計有一個很大的優點，即它可以實現簡單的加法和減法運算。加法運算的規則對正數和負數是一致的，這意味著我們可以用相同的電路來處理加法，無需額外的邏輯來處理負數。具體來說，二補數系統的加法操作對負數和正數都是有效的，並且還避免了「符號位加法」可能出現的麻煩。
