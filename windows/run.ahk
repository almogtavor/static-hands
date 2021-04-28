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
CapsLock & m::Send, {blind}{Insert}


; Speed
CapsLock & s::Send, {blind}^{Left 5}
CapsLock & f::Send, {blind}^{Right 5}

; Features
; CapsLock & b::Send, {blind}^{Left 2}