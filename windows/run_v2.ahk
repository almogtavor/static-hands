#Requires AutoHotkey v2.0
SendMode "Input"  ; Superior speed and reliability
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory
SetCapsLockState "AlwaysOff"

; Remap keys using CapsLock as a modifier
CapsLock & i::Send "{Blind}{Up}"
CapsLock & j::Send "{Blind}{Left}"
CapsLock & l::Send "{Blind}{Right}"
CapsLock & k::Send "{Blind}{Down}"
CapsLock & u::Send "{Blind}{Home}"
CapsLock & o::Send "{Blind}{End}"
CapsLock & h::Send "{Blind}{Delete}"
CapsLock & y::Send "{Blind}{PgUp}"
CapsLock & n::Send "{Blind}{PgDn}"
CapsLock & `;::Send "{Blind}{Backspace}"
CapsLock & p::Send "{Blind}{Insert}"
CapsLock & 4::Send "{Blind}{$ 2}"  ; LaTeX conversion

; Modifier keys
; Modifier keys with CapsLock
CapsLock & f::Send "{Ctrl down}" ; Press and hold Ctrl
CapsLock & f up::Send "{Ctrl up}" ; Release Ctrl

CapsLock & d::Send "{Shift down}" ; Press and hold Shift
CapsLock & d up::Send "{Shift up}" ; Release Shift

CapsLock & s::Send "{Alt down}" ; Press and hold Alt
CapsLock & s up::Send "{Alt up}" ; Release Alt

CapsLock & w::Send "{LWin down}" ; Press and hold Windows
CapsLock & w up::Send "{LWin up}" ; Release Windows


; Speed up navigation
CapsLock & 8::Send "{Blind}{Up 5}"
CapsLock & m::Send "{Blind}{Left 6}"
CapsLock & .::Send "{Blind}{Right 6}"
CapsLock & ,::Send "{Blind}{Down 5}"

; Keep window always on top
CapsLock & +::WinSetAlwaysOnTop "A"
