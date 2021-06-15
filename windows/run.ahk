#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; SetCapsLockState, AlwaysOff

CapsLock & i::Send, {blind}{Up}
CapsLock & j::Send, {blind}{Left}
CapsLock & l::Send, {blind}{Right}
CapsLock & k::Send, {blind}{Down}
CapsLock & u::Send, {blind}{home}
CapsLock & o::Send, {blind}{end}
CapsLock & h::Send, {blind}{delete}
CapsLock & y::Send, {blind}{PgUp}
CapsLock & n::Send, {blind}{PgDn}
CapsLock & `;::Send, {blind}{Backspace}
CapsLock & p::Send, {blind}{Insert}

CapsLock & f::Ctrl
CapsLock & d::Shift
CapsLock & s::Alt
CapsLock & w::LWin

; Speed
CapsLock & m::Send, {blind}^{Left 6}
CapsLock & .::Send, {blind}^{Right 6}

CapsLock & -::Winset, Alwaysontop, , A