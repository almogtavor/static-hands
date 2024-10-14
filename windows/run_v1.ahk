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
CAPSLOCK & w::LWin

; Speed
CapsLock & 8::Send, {Up 5}
CapsLock & m::Send, {blind}^{Left 6}
CapsLock & .::Send, {blind}^{Right 6}
CapsLock & ,::Send, {Down 5}

; Keep window open
CapsLock & +::Winset, Alwaysontop, , A

; Change Case
CapsLock & 9::goSub, set_upper_case
CapsLock & 0::goSub, set_lower_case
CapsLock & -::goSub, set_title_case

set_upper_case:
set_lower_case:
set_title_case:
revert_clipboard := clipboardAll
clipboard =
send ^{c}
clipWait, 0.3

if (a_thisLabel = "set_upper_case")
    stringUpper, clipboard, clipboard
else if (a_thisLabel = "set_lower_case")
    stringLower, clipboard, clipboard
else if (a_thisLabel = "set_title_case")
    stringLower, clipboard, clipboard, T

send ^{v}
sleep 50
clipboard := revert_clipboard
return
