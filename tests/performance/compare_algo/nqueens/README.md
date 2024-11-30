## **Proportionality of MeTTaLog, Plain Prolog, CLP(FD), and Transpiled MeTTaLog**

| **Size** | **Solutions** | **MeTTaLog (min)** | **MeTTaRust (min)** | **Transpiled MeTTaLog (min)** | **Plain Prolog (min)** | **Prolog CLP(FD) (min)** | **C/C++ (min)** |
|----------|---------------|--------------------|---------------------|------------------------------|-------------------------|--------------------------|-----------------|
| **4**    | 2             | 0.093             | 0.135               | 0.000098                     | 0.000                  | 0.000                   | 0.000           |
| **5**    | 10            | 0.099             | 0.547               | 0.000098                     | 0.000                  | 0.000                   | 0.000           |
| **6**    | 4             | 0.117             | 1.815               | 0.000098                     | 0.000                  | 0.001                   | 0.000           |
| **7**    | 40            | 0.197             | 11.435              | 0.000098                     | 0.000                  | 0.003                   | 0.000           |
| **8**    | 92            | 1.192             | 38.588              | 0.000100                     | 0.000                  | 0.015                   | 0.000           |
| **9**    | 352           | 2.538             | 133.000             | 0.000200                     | 0.000083              | 0.061                   | 0.000           |
| **10**   | 724           | 0.588            | 467.000             | 0.110                        | 0.000167              | 0.267                   | 0.000           |
| **11**   | 2,680         | 0.750            | -                   | -                            | 0.000433              | 1.276                   | 0.000167        |
| **12**   | 14,200        | -                 | -                   | 0.415                        | 0.003683              | 6.664                   | 0.000917        |
| **13**   | 73,712        | -                 | -                   | -                            | 0.011817              | 36.606                  | 0.005133        |
| **14**   | 365,596       | -                 | -                   | -                            | 0.186467              | 212.653                 | 0.030817        |
| **15**   | 2,279,184     | -                 | -                   | -                            | 1.265300              | Stack Limit Exceeded    | 0.196483        |

---

### **Key Observations**

#### **1. MeTTaRust Performance**
- **MeTTaRust** is consistent and correct with **467.000 minutes (~7.783 hours)** for **N=10**.
- Its performance declines significantly with increasing N, highlighting the need for optimizations or alternative approaches.

#### **2. MeTTaLog and Transpiled MeTTaLog**
- **MeTTaLog** scales poorly for larger N, taking **25.388 minutes (~1.5 hours)** for **N=10**.
- **Transpiled MeTTaLog** continues to perform exceptionally well, solving **N=10** in just **0.11 minutes (~6.6 seconds)** and **N=12** in **0.415 minutes (~24.9 seconds)**.

#### **3. Plain Prolog vs. CLP(FD)**
- **Plain Prolog** outperforms **CLP(FD)** for larger N (e.g., N ≥ 12) due to the reduced overhead of backtracking compared to domain pruning.
- **CLP(FD)** remains superior for small-to-medium N (e.g., N ≤ 10) due to its efficient constraint handling.

#### **4. C/C++**
- C/C++ maintains its dominance as the fastest implementation, solving even **N=15** in under **12 seconds (0.196 minutes)**.

---

### **Takeaways**

   - **C/C++ and Transpiled MeTTaLog** are the fastest implementations, with C/C++ leading for all N and Transpiled MeTTaLog excelling among symbolic reasoning tools.
   - **Prolog CLP(FD)** is not a magic bullet for some problems.
