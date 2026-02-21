# 3DS Game Maker (MVP)

This project is a buildable Nintendo 3DS homebrew foundation for a 2D game maker with:

- Start screen with touch + button navigation
- Level editor (tile/free-draw, 4 layers, undo/redo, scroll, zoom)
- Sprite editor (frame drawing, palette, duplicate/delete frames)
- Animation studio (playback, FPS control, loop toggle, sprite-sheet export to PPM)
- Test play mode with a Mario-style demo level, enemy, coins, flagpole end
- Save/load project on SD (`sdmc:/3ds/game_maker/project.bin`)

## Build

```bash
cd /Users/soares10/3ds-game-maker
make
```

Outputs:

- `3ds_game_maker.elf`
- `3ds_game_maker.3dsx`

## CIA Packaging

```bash
mkdir -p /Users/soares10/3ds-game-maker/out
makerom -f cia \
  -o /Users/soares10/3ds-game-maker/out/3ds_game_maker.cia \
  -elf /Users/soares10/3ds-game-maker/3ds_game_maker.elf \
  -rsf /Users/soares10/3ds-game-maker/3ds_game_maker.rsf \
  -desc app:2
```

## Controls

- Start: D-Pad + A, touch buttons, START quick Test Play
- Level Editor:
  - Touch draw
  - `B` erase while touching
  - `L/R` layer switch
  - `X` grid snap toggle
  - `Y` free-draw toggle
  - Circle Pad or C-Pad to scroll map
  - `START` Test Play, `SELECT` back to menu
- Sprite Editor:
  - Touch draw on canvas
  - Touch palette on right
  - 2 layers per frame (`CPAD left/right` toggles active layer)
  - Multi-page project (Flipnote-like pages):
    - touch right panel for `NEW PAGE`, `PREV PAGE`, `NEXT PAGE`
    - page limit: 16
  - `L/R` tool cycle (`Pen`, `Eraser`, `Fill`, `Line`, `Rect`)
  - `A/B` next/prev frame
  - `X` duplicate frame
  - `Y` delete frame
  - `Up/Down` reorder frame
  - `D-Pad left/right` flip frame H/V
  - `D-Pad up/down` brush size +/-
  - `Left/Right` frame hold -/+
  - touch right panel to increment frame SFX slot and toggle overlay visibility
  - touch `REC MIC` / `STOP MIC` to record voice clip for current page+frame
  - while mic is recording, page changes are blocked
  - `START` animation studio
  - `SELECT` save and return
- Animation Studio:
  - `A` play/pause
  - `B` loop on/off
  - `D-Pad up/down` FPS +/-
  - `D-Pad left/right` frame hold -/+
  - `Y` 3D depth simulation toggle
  - `X` export sprite sheet (`sdmc:/3ds/game_maker/spritesheet.ppm`)
  - `UP` export GIF companion bundle (`sdmc:/3ds/game_maker/gif_export`)
  - `L/R` scrub frames

## GIF companion export

`UP` in Animation Studio exports:

- `sdmc:/3ds/game_maker/gif_export/frame_###.ppm`
- `sdmc:/3ds/game_maker/gif_export/frames.txt`
- `sdmc:/3ds/game_maker/gif_export/manifest.csv`
- `sdmc:/3ds/game_maker/gif_export/convert_to_gif.sh`

Run `convert_to_gif.sh` on PC (with `ffmpeg`) to generate `output.gif`.
- Test Play:
  - `Left/Right` move
  - `A` jump/double jump
  - `B` dash
  - `X` debug overlay
  - `Y` slow-motion
  - `START` restart level
  - `SELECT` menu

## Notes

This is an MVP architecture: many advanced items from the full spec are scaffolded (logic mode flag, settings/backlight simulation, dual-screen editor flow) and ready for deeper expansion.

The app now shows on-screen status toasts for save/load/export/mic actions to make workflows easier to verify on hardware.
