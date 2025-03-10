# Photoshop ahk
## This repo is a collection of photoshop ahk scripts I use on a daily basis.
### Features
This ahk script detects the active tool on photoshop and creates custom remaps for a faster workflow
It also disables itself when a tool that's one one of the preset tools is selected to prevent conflicts with the type tool or other tools.

## Requirements
Ahk version 1.1
https://www.autohotkey.com/

Photoshop must have the Options bar enabled, it is used as a hook to identify the active tool

Download the Actions.atn file and click on the menu button of the actions pannel to load it.

---

### By default the script works best with the tools set to the following keys
 - Magic wand: W
 - Lasso tool: F
 - Rotate tool: Unbinded
## Usage

#### When the active tool isn't one of the following the key mappings will be disabled to not conflict with the type tool or other keybinds
Lasso tool, brush tool, Eraser, All Marquee tools

#### General
 - R : Undo
 - tab: 0 (useful for brush tool and eraser to return to default opacity)
 - n : New layer

#### Lasso and Marquee tools
 - F : Fills
 - CTRL+F: F11 (Bind the Fill layer action to F11)
 - G : Delete and clears the selection
#### Magic wand tool
 - W : F12 (Bind the "if selection expand" action to F12)
 - G : Delete and clears the selection
