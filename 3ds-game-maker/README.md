# JumpForge 3DS

JumpForge 3DS is a Nintendo 3DS homebrew game-making toolkit with a touch-first level editor, sprite/animation tools, enemy setup, and instant platformer test play.

## Features

- Touch-driven level editor with tile layers, undo/redo, and zoom
- Sprite editor with drawing tools, frame timeline, and page workflow
- Animation studio with playback controls and export helpers
- Enemy maker with behavior and stat tuning
- One-button platformer test mode (move/jump/play loop)
- Save slots with backup recovery support

## Why This Project

JumpForge 3DS is designed for people who want to prototype 2D platformer ideas directly on Nintendo 3DS hardware using homebrew tools.

## Tech Stack

- C++17
- devkitPro / devkitARM
- libctru
- makerom / smdhtool / 3dsxtool

## Build

```bash
cd 3ds-game-maker
make
```

Output files:

- `3ds_game_maker.elf`
- `3ds_game_maker.3dsx`

## Build CIA

```bash
mkdir -p out
makerom -f cia \
  -o out/3ds_game_maker.cia \
  -elf 3ds_game_maker.elf \
  -rsf 3ds_game_maker.rsf \
  -desc app:2
```

## Controls (Quick)

- `PLAY` on start menu launches platformer test mode
- Platformer: `Left/Right` move, `A` jump, `B` dash
- `SELECT` returns to menu

## Installation

- Homebrew Launcher: copy `.3dsx` to SD card and launch
- CFW/Home Menu: install `.cia` using your preferred installer

## Project Status

Active prototype. Core systems are playable and expanding.

## Keywords

Nintendo 3DS homebrew, 3DS game maker, platformer creator, level editor, sprite editor, animation studio, devkitPro, libctru.

## License

Add your preferred license here (MIT recommended for open collaboration).
