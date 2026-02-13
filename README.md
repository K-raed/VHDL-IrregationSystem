🌿 Smart Irrigation System – VHDL Design
Modular FPGA-Based Environmental Control Architecture
📌 Overview

This project implements a Smart Irrigation System using VHDL with a modular hardware architecture.

The system is designed to monitor environmental conditions and autonomously control irrigation activation based on temperature and humidity thresholds.

The design follows a structured multi-block architecture with a top-level integration module.

🎯 Project Objectives

Monitor environmental conditions (temperature & humidity)

Implement hardware-based decision logic

Automatically control irrigation activation

Design a modular and scalable VHDL architecture

Demonstrate synchronous digital system design principles

🏗 System Architecture

The design is composed of the following main blocks:

🔹 1. Bloc_température_humidité

Inputs: Temperature and humidity signals

Processes environmental sensor values

Provides processed signals to the control block

Implements threshold comparison logic

🔹 2. Bloc_Surveillance

Monitors environmental conditions continuously

Detects abnormal or critical states

Generates monitoring signals for system supervision

🔹 3. Bloc_Controle

Core decision-making unit

Receives signals from:

Bloc_température_humidité

Bloc_Surveillance

Evaluates irrigation conditions

Generates activation commands

🔹 4. Bloc_Activation

Controls irrigation actuator signal

Drives water pump / valve control output

Ensures proper activation timing

🔹 5. SmartIrrigationSystem (Top-Level Block)

Integrates all submodules

Manages signal routing between blocks

Defines system inputs and outputs

Coordinates full system operation

This top-level architecture ensures modularity, scalability, and clean signal hierarchy.

🔄 System Operation

1️⃣ Environmental inputs (temperature & humidity) are received
2️⃣ Bloc_température_humidité evaluates threshold conditions
3️⃣ Bloc_Surveillance verifies system status
4️⃣ Bloc_Controle determines irrigation necessity
5️⃣ Bloc_Activation triggers irrigation output

The system operates synchronously under clock control.

⚙️ Design Characteristics

Fully modular VHDL architecture

Clear separation between monitoring, control, and activation logic

Hardware-level decision implementation

Structured signal routing via top-level entity

Synthesizable digital design

🧠 Engineering Concepts Demonstrated

Structural VHDL design

Entity and architecture separation

Modular hardware decomposition

Synchronous system design

Digital threshold-based control logic

Hierarchical top-level integration

📁 Repository Structure (Example)
/Bloc_temperature_humidite.vhd
/Bloc_Surveillance.vhd
/Bloc_Controle.vhd
/Bloc_Activation.vhd
/SmartIrrigationSystem.vhd
/Simulation/
README.md
🛠 Technologies Used

VHDL

FPGA-based design methodology

Digital logic simulation tools

🚀 Possible Improvements

Add moisture sensor integration

Implement FSM-based control refinement

Add configurable threshold registers

Introduce power optimization logic

Add real-time monitoring interface
