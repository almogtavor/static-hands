#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; SetCapsLockState, AlwaysOff

CapsLock & i::
{
    ; While GetKeyState("Ctrl", "P")
    ; {
    ;     Send {Ctrl Up}
    ; }
    ; While GetKeyState("Shift", "P")
    ; {
    ;     Send {Shift Up}
    ; }
    Send, {blind}{Up}
    return
    f::Ctrl
    d::Shift
    return
}
CapsLock up::
{
    Send {Ctrl Up}
    Send {Shift Up}
    return
}
; f up::
; {

;         Send {Ctrl Up}
;         Send {Shift Up}
;     return
; }
; d up::
; {
;         Send {Ctrl Up}
;         Send {Shift Up}
;     return
; }
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
; #If GetKeyState(CapsLock , 'P')
; {
;     f::Ctrl
;     d::Shift
; }
; CapsLock::
; 	tooltip A PRESSED
; 	return

; ~a up::
; 	tooltip A RELEASED
; 	return

; CapsLock & s::Send, {blind}^{Left 5}
; CapsLock & f::Send, {blind}^{Right 5}

; Features
; CapsLock & b::Send, {blind}^{Left 2}