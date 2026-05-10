# Super Mario Bros — x86 Assembly (MASM)

> A fully functional Super Mario Bros clone built entirely in **x86 MASM Assembly Language** for the Computer Organization and Assembly Language (COAL) course at FAST-NUCES.

---

## About

This project recreates the classic side-scrolling Mario platformer experience entirely in **text-mode console** using the Irvine32 library. Despite running in a terminal, it features real physics, enemy AI, scrolling maps, sound effects, and a persistent high score system.
**Language:** MASM x86 Assembly  

---

## Features

-  **Two levels** — a standard level and a challenging Boss level with increasing difficulty
-  **Smooth movement** with gravity-based jumping and horizontal map scrolling
-  **Multiple enemy types** — Goombas, Koopas, Shells, and jumping Sentinel enemies (Boss level)
-  **Collectibles** — coins, power-up crates, stars, and mystery boxes
-  **Turbo Star Power** — speed doubles temporarily when Mario collects a star
-  **Full collision engine** — ground, ceiling, side, pitfall, and enemy collision detection
-  **Sound system** — background music per level + event sounds (jump, coin, death, power-up, win)
-  **Persistent high scores** — saved to `scores.txt`, sorted and displayed in-game
-  **Pause, menu navigation, lives & timer system**

---

## Controls

| Key | Action |
|-----|--------|
| `W` | Jump |
| `A` | Move Left |
| `D` | Move Right |
| `P` | Pause |

---

## Scoring System

| Action | Points |
|--------|--------|
| Coin collected | +10 |
| Goomba defeated | +100 |
| Koopa shell elimination | +200 |
| Mystery Box opened | +200 + coin |
| Sentinel defeated | +500 |
| Power-up collected | +1000 |

> Every 100 points above the last bonus threshold awards an extra life.
---

## Tech Stack

| Component | Technology |
|-----------|------------|
| Language | MASM x86 Assembly |
| Library | Irvine32.inc |
| Sound | WinMM `PlaySound` API |
| Rendering | Text-mode via `SetTextColor` + `Gotoxy` |
| Storage | File I/O (`scores.txt`) |

---

## How to Run

1. Install [MASM32](http://www.masm32.com/) and the [Irvine32 library](http://asmirvine.com/)
2. Open the project in **Visual Studio** with MASM configured
3. Build and run `24i-0782 Mario.asm`
4. Make sure all `.wav` files are in the **same directory** as the executable

> This is a Windows-only project (uses Win32 APIs for sound and console rendering).

---

## Author
Rameen Fatima 
