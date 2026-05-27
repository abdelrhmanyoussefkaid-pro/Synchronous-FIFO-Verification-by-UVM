# 🧪 UVM-Based Verification Environment for Synchronous FIFO

> Advanced Functional Verification of a Parameterized FIFO Design using SystemVerilog & UVM

---

# 📘 Project Introduction

This project presents a complete **UVM-based verification environment** developed for a **Synchronous FIFO** memory design.

The environment was built using:

- SystemVerilog
- Universal Verification Methodology (UVM)
- Assertion-Based Verification
- Functional Coverage Techniques

The primary goal is to validate FIFO functionality under normal, stress, and corner-case operating conditions while ensuring protocol correctness and data integrity.

---

# 🎯 Verification Objectives

The verification plan focuses on validating:

✔ FIFO ordering correctness  
✔ Data integrity across transactions  
✔ Control signal synchronization  
✔ Full and empty boundary behavior  
✔ Overflow and underflow protection  
✔ Simultaneous read/write functionality

---

# 🧠 FIFO Functional Overview

FIFO stands for:

> **First In First Out**

The earliest data written into memory must always be the first data read out.

Maintaining this ordering under all traffic conditions is the key focus of this verification environment.

---

# ⚙️ DUT Configuration

## Configurable Parameters

| Parameter | Value |
|---|---|
| FIFO_WIDTH | 16 |
| FIFO_DEPTH | 8 |

---

## Internal Design Elements

| Component | Description |
|---|---|
| wr_ptr | Write pointer |
| rd_ptr | Read pointer |
| count | Occupancy counter |

---

## FIFO Status Flags

| Signal | Function |
|---|---|
| full | FIFO reached maximum capacity |
| empty | FIFO contains no valid data |
| almostfull | FIFO nearly full |
| almostempty | FIFO nearly empty |
| overflow | Invalid write on full FIFO |
| underflow | Invalid read on empty FIFO |
| wr_ack | Successful write indication |

---

# 🏗️ UVM Verification Architecture

The verification environment follows the standard layered UVM architecture.

---

## 🔹 Verification Components

| UVM Component | Responsibility |
|---|---|
| Sequence Item | Defines transaction fields |
| Sequence | Generates stimulus patterns |
| Driver | Drives DUT interface signals |
| Monitor | Samples DUT activity |
| Scoreboard | Checks DUT correctness |
| Coverage Collector | Measures functional coverage |

---

# 🔄 Verification Sequences

| Sequence | Purpose |
|---|---|
| Reset Sequence | Verify clean DUT initialization |
| Write Sequence | Validate FIFO write path |
| Read Sequence | Validate FIFO read path |
| Concurrent Sequence | Simultaneous read/write testing |
| Random Stress Sequence | High-volume randomized traffic |

---

# ✔ Assertion-Based Verification

SystemVerilog Assertions (SVA) were integrated to detect protocol violations automatically.

### Assertions Implemented

- Reset correctness
- Write acknowledge timing
- Overflow detection
- Underflow detection
- FIFO flag consistency
- Read data validity

---

# 📊 Functional Coverage

Coverage groups were created to monitor:

- Write/read enable combinations
- Full and empty flag transitions
- Overflow scenarios
- Underflow scenarios
- Concurrent transaction activity

---

# 🧪 Scoreboard & Reference Model

The scoreboard implements an internal FIFO queue as a reference model.

### Verification Responsibilities

✔ Compare DUT output against expected data  
✔ Verify FIFO ordering behavior  
✔ Detect data corruption or packet loss  
✔ Validate status flag correctness

---

# 📈 Verification Results

| Metric | Result |
|---|---|
| Correct Transactions | 3000+ |
| Error Transactions | 0 |
| Assertions Status | ✅ All Passed |
| Functional Coverage | ✅ Achieved |

---

# 📷 Waveform Analysis

Waveforms were analyzed for:

- Write-only operations
- Read-only operations
- Concurrent read/write operations
- FIFO boundary conditions

FIFO correctness was verified through:

```text
data_in sequence == data_out sequence
```

---

# 💻 Tools & Technologies

- SystemVerilog
- UVM (Universal Verification Methodology)
- QuestaSim
- SystemVerilog Assertions (SVA)
- Functional Coverage
- Transaction-Level Modeling (TLM)

---

# 📂 Repository Structure

```bash
FIFO_UVM_Project/
│
├── rtl/
│   └── FIFO.v
│
├── tb/
│   ├── fifo_transaction.sv
│   ├── fifo_sequence.sv
│   ├── fifo_driver.sv
│   ├── fifo_monitor.sv
│   ├── fifo_scoreboard.sv
│   ├── fifo_coverage.sv
│   ├── fifo_env.sv
│   ├── fifo_test.sv
│   └── top.sv
│
├── assertions/
│   └── fifo_sva.sv
│
├── sim/
│   └── run.do
│
└── README.md
```

---

# 🚀 Key Features

- Fully layered UVM architecture
- Modular reusable verification components
- Assertion-based protocol checking
- Automated scoreboard validation
- Functional coverage collection
- Randomized stress testing
- Scalable verification flow

---

# 📚 Verification Methodology Highlights

- Self-checking environment
- Transaction-level communication
- Reusable verification components
- Automated result comparison
- Coverage-driven verification

---

# 👨‍💻 Author

### Abdelrahman Youssef

Electronics & Communication Engineering Student

Interested in:

- Functional Verification
- Digital Design
- UVM Methodology
- FPGA Systems

