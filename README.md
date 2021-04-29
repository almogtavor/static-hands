# hands-position-fixed-keyboard
 ⌨️ Remap keyboard keys in such way that doesn't require to move hands

## Installation

Install [AutoHotKey](https://www.autohotkey.com/), clone project, open hands-position-fixed-keyboard --> Windows --> open run.ahk with AutoHotkey.

#### To put ahk into effect automatically every time PC start

* Select run.ahk, and press Ctrl+C.
* Press Win+R to open the Run dialog, then enter shell:startup and click OK or Enter. This will open the Startup folder for the current user. To instead open the folder for all users, enter shell:common startup (however, in that case you must be an administrator to proceed).
* Right click inside the window, and click "Paste Shortcut". The shortcut to the script should now be in the Startup folder.

## Available commands

### Basic Features

|Key/Commands|Function|
|:----------:|:-------|
|CapsLock+j|Left|
|CapsLock+k|Down|
|CapsLock+i|Up|
|CapsLock+l|Right|
|CapsLock+u| To the start of the line (Home)|
|CapsLock+o| To the end of the line (End)|
|CapsLock+h| Delete|
|CapsLock+;| Backspace|
|CapsLock+m| Insert|
|CapsLock+y| PageUp|
|CapsLock+n| PageDown|

** Notice one-click CapsLock still functions the same

### Speed

|Key/Commands|Function|
|:----------:|:-------|
|CapsLock+s| Move 5 words backward|
|CapsLock+f| Move 5 words forward|
