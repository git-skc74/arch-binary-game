# Binary Game

**Computer Architecture Term Project**

A terminal-based educational game written in MIPS Assembly that helps users practice binary-to-decimal and decimal-to-binary conversions.

## Requirements

* **MIPS MARS Simulator**: You need the MARS (MIPS Assembler and Runtime Simulator) environment to run this program.
* **Simulator Setting**: Ensure the following option is checked in the MARS settings:
  * `Settings` -> `Permit extended (pseudo) instructions and formats`

## File Structure

To run the game successfully, ensure all the following files are located in the **same directory**:

* `main.asm` (Main entry point)
* `board.asm`
* `conversion.asm`
* `generation.asm`
* `validation.asm`
* `SysCalls.asm`

## How to Run

1. Open the MIPS MARS simulator.
2. Open the `main.asm` file (`File` -> `Open`).
3. Click the **Assemble** button.
4. Click the **Run** button to start the game in the execution window.

## Gameplay

There are 10 levels ready for you. Each level adds one question, meaning level 1 has 1 question, level 2 has 2 questions, and level 10 has 10 questions.  
The questions are either `binary-to-decimal` or `decimal-to-binary` conversions. The number does not exceed 256 and 8 digits.  
Convert the number and enter the answer. The game will let you know whether it's right or wrong.

Enjoy Binary Game!
