# Hybrid Fixed-Priority + Round Robin Arbiter (FPGA Implementation)

This project implements a **Hybrid Arbiter** that supports:
- **Fixed Priority Arbitration** (when `prior = 1`)
- **Round Robin Arbitration** (when `prior = 0`)

It is fully designed in **Verilog HDL**, simulated in **Vivado**, and implemented on the **Basys3 FPGA (Artix-7)** board.

---

## 🚀 Features
- 4-requester arbiter (`req[3:0]`)
- 4 grant outputs (`grant[3:0]`)
- FSM-based Round Robin scheduling
- Fixed-priority override mode using a control signal
- Debounced reset + clock divider for Basys3
- Synthesizable and FPGA-ready design
- Verified using post-synthesis timing simulation

---

## 📌 Modes of Operation

### **1. Fixed Priority Mode (`prior = 1`)**
Priority order:
