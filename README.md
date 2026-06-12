# Mini SoC Verification Project

## Overview

The Mini SoC Verification Project is a complete end-to-end SystemVerilog project designed to learn SoC verification concepts through the development and verification of a small but realistic System-on-Chip (SoC).

The project intentionally starts with basic register verification and gradually progresses toward full SoC verification involving:

* APB Protocol
* AXI-Lite Protocol
* Register Verification
* Interrupt Verification
* Bus Functional Models (BFMs)
* Monitors
* Scoreboards
* Functional Coverage
* Assertions
* Integration Verification
* SoC Verification
* UVM Migration

The primary objective is to understand verification concepts before introducing UVM.

---

# Project Objectives

This project is designed to teach:

## Design Concepts

* Register Design
* APB Slave Design
* AXI-Lite Interface Design
* Address Decoding
* Interrupt Generation
* Finite State Machines

## Verification Concepts

* Directed Testing
* Register Verification
* Protocol Verification
* Transaction-Level Modeling
* Monitor Development
* Scoreboard Development
* Functional Coverage
* Assertion-Based Verification
* Regression Testing
* Coverage Closure

---

# Mini SoC Architecture

```text
                     AXI-Lite Master
                            |
                            |
                  +------------------+
                  | AXI-Lite to APB  |
                  | Bridge           |
                  +--------+---------+
                           |
                        APB Bus
                           |
        +------------------+------------------+
        |                  |                  |
        |                  |                  |
      GPIO               TIMER              DMA
    APB Slave          APB Slave         APB Slave
```

---

# IP Blocks

## GPIO Controller

Provides:

* GPIO Enable Control
* Direction Configuration
* Input Sampling
* Output Driving
* Interrupt Generation

### Registers

| Register      |
| ------------- |
| GPIO_CTRL     |
| GPIO_DIR      |
| GPIO_DATA_OUT |
| GPIO_DATA_IN  |
| GPIO_STATUS   |

---

## Timer Controller

Provides:

* One-Shot Timer
* Periodic Timer
* Timeout Interrupt

### Registers

| Register     |
| ------------ |
| TIMER_CTRL   |
| TIMER_LOAD   |
| TIMER_COUNT  |
| TIMER_STATUS |

---

## DMA Controller

Provides:

* Simplified DMA Operation
* Transfer Completion Interrupt
* Error Reporting

### Registers

| Register     |
| ------------ |
| DMA_CTRL     |
| DMA_SRC_ADDR |
| DMA_DST_ADDR |
| DMA_SIZE     |
| DMA_STATUS   |

---

# Bus Architecture

## APB3

The GPIO, TIMER and DMA peripherals are implemented as APB3 slaves.

### APB Signals

```text
PCLK
PRESETn

PSEL
PENABLE
PWRITE

PADDR
PWDATA

PRDATA
PREADY
PSLVERR
```

---

## AXI-Lite

The SoC exposes a single AXI-Lite slave interface.

### AXI Channels

```text
AW - Write Address
W  - Write Data
B  - Write Response

AR - Read Address
R  - Read Data
```

---

# Address Map

| Peripheral | Base Address |
| ---------- | ------------ |
| GPIO       | 0x0000_0000  |
| TIMER      | 0x0000_1000  |
| DMA        | 0x0000_2000  |

---

# Verification Architecture

```text
                 +-------------+
                 |    TEST     |
                 +------+------+
                        |
                        |
                 +------+------+
                 | APB BFM     |
                 +------+------+
                        |
                        |
                 +------+------+
                 |    DUT      |
                 +------+------+
                        |
                        |
                 +------+------+
                 | APB Monitor |
                 +------+------+
                        |
               +--------+--------+
               |                 |
               |                 |
         +-----+------+   +------+------+
         | Scoreboard |   | Coverage    |
         +------------+   +-------------+
```

---

# Project Structure

```text
mini_soc/

├── docs/
│
│   MINI_SOC_SPEC_v1.0
│   RAS_v1.0
│   VPLAN_v1.0
│   TESTPLAN_v1.0
│   VERIFICATION_ARCHITECTURE_v1.0
│   COVERAGE_PLAN_v1.0
│   PROJECT_ROADMAP_v1.0
│
├── rtl/
│
│   apb_if.sv
│   gpio_apb.sv
│   timer_apb.sv
│   dma_apb.sv
│   apb_decoder.sv
│   mini_soc_top.sv
│
│   axi_lite_if.sv
│   axi2apb_bridge.sv
│
├── tb/
│
│   interfaces/
│
│   bfm/
│
│   monitor/
│
│   scoreboard/
│
│   coverage/
│
│   assertions/
│
│   common/
│
├── tests/
│
├── sim/
│
└── README.md
```

---

# Verification Flow

The project verification flow is:

```text
Specification
      ↓
RTL Development
      ↓
BFM Development
      ↓
Directed Tests
      ↓
Monitor
      ↓
Scoreboard
      ↓
Coverage
      ↓
Assertions
      ↓
Integration Verification
      ↓
Full Regression
      ↓
Coverage Closure
      ↓
Project Signoff
```

---

# Learning Roadmap

## Stage 1

Foundation

* APB Interface
* GPIO RTL
* APB BFM
* GPIO Verification

---

## Stage 2

Block Verification

* Timer RTL
* Timer Verification
* DMA RTL
* DMA Verification

---

## Stage 3

Verification Infrastructure

* Monitor
* Transaction Classes
* Scoreboard
* Coverage
* Assertions

---

## Stage 4

Integration Verification

* APB Decoder
* Mini SoC Top
* Interrupt Verification

---

## Stage 5

SoC Verification

* AXI-Lite Interface
* AXI BFM
* AXI-to-APB Bridge
* Full SoC Verification

---

## Stage 6

UVM Migration

* Driver
* Monitor
* Scoreboard
* Sequences
* Register Model (RAL)

---

# Expected Learning Outcomes

By the end of this project, the engineer should understand:

* Register Verification
* APB Protocol Verification
* AXI-Lite Protocol Verification
* Bus Functional Models
* Transaction-Level Verification
* Monitors
* Scoreboards
* Functional Coverage
* Assertions
* Interrupt Verification
* Address Decoding
* Integration Verification
* SoC Verification
* UVM Fundamentals

---

# Project Status

Documentation Status

* [ ] MINI_SOC_SPEC_v1.0
* [ ] RAS_v1.0
* [ ] VPLAN_v1.0
* [ ] TESTPLAN_v1.0
* [ ] VERIFICATION_ARCHITECTURE_v1.0
* [ ] COVERAGE_PLAN_v1.0
* [ ] PROJECT_ROADMAP_v1.0

Implementation Status

* [ ] APB Interface
* [ ] GPIO RTL
* [ ] APB BFM
* [ ] GPIO Verification
* [ ] Timer RTL
* [ ] Timer Verification
* [ ] DMA RTL
* [ ] DMA Verification
* [ ] Monitor
* [ ] Scoreboard
* [ ] Coverage
* [ ] Assertions
* [ ] Integration Verification
* [ ] AXI-Lite Verification
* [ ] Full Regression

---

# License

This project is intended for educational and learning purposes focused on SoC Design and Verification concepts.

---

End of README
