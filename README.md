# Squib's Brackeys Tutorial Game

My first game made in **Godot**, built while following Brackeys' beginner Godot tutorial.

This is a small 2D platformer project where the player runs, jumps, rolls, collects coins, breaks bottles, avoids hazards, and tries to finish the level with lives remaining.

## Tutorial Credit

This project was made while following Brackeys' Godot beginner tutorial:

[How to make a Video Game - Godot Beginner Tutorial](https://www.youtube.com/watch?v=LOhfqjmasi0)

Huge thanks to Brackeys for making beginner-friendly game development tutorials.

## About the Game

The goal is to complete the level by collecting coins and breaking bottles.

Current objectives:

- Collect **30 coins**
- Break **12 bottles**
- Avoid hazards and enemies
- Finish with as many lives left as possible
- Try to get a good completion time

## Features

- 2D platformer movement
- Running and jumping
- Rolling
- Roll-to-break bottle objects
- Coin collection
- Slime enemy behavior
- Killzone / hazard system
- Lives system
- Timer
- HUD for lives, coins, bottles, and time
- Start menu
- Game over screen
- Win screen

## Controls

| Action | Key |
| --- | --- |
| Move Left | `A` or `Left Arrow` |
| Move Right | `D` or `Right Arrow` |
| Jump | `Space` |
| Roll | `Shift` |
| Interact / Action | `F` |

## Built With

- [Godot Engine](https://godotengine.org/)
- GDScript

## Project Structure

```text
.
├── assets/             # Sprites, sounds, music, fonts, and asset credits
├── scenes/             # Godot scenes for the player, level, HUD, menus, objects, etc.
├── scripts/            # GDScript files for gameplay logic
├── project.godot       # Godot project file
├── game.gd             # Main game scene script
└── StartMenu.gd        # Menu base/start menu related script
