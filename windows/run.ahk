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

; Select Current Word
CapsLock & q::Send, ^{Left}+^{Right}
;     ; selText=tSe
;     selText:=getSelText()
;     if(selText="")
;     {
;         Send, ^{Left}
;         Send, +^{Right}
;     }
;     else {
;         Send, ^{Left}
;         Send, +^{Right}
;         Send, %selText%
;         Send, +^{Right}
;     }
    
; CapsLock & c::Send, ^{Left}+^{Right}
; CapsLock & v::Send, ^{Left}+^{Right}

getSelText()
{
    ClipboardOld:=ClipboardAll
    Clipboard:=""
    SendInput, ^{c}
    ClipWait, 0.1
    if(!ErrorLevel)
    {
        selText:=Clipboard
        Clipboard:=ClipboardOld
        StringRight, lastChar, selText, 1
        if(Asc(lastChar)!=10) ;if last char is not line feed
        {
            return selText
        }
    }
    Clipboard:=ClipboardOld
    return
}

; Features
; CapsLock & b::Send, {blind}^{Left 2}
