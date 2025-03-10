#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance Force
#MaxThreads 5 
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
brush := false
run Photoshop_Lasso.ahk
run Photoshop_MagicWand.ahk
Loop {
if WinActive("ahk_class Photoshop")
{
SetTitleMatchMode, Slow
DetectHiddenText, off
WinGetText, text 
; msgbox, %text%
IfInString, text, Subject
{
        suspend, off
        SetTitleMatchMode 2
        ScriptSuspend("PhotoshopLasso.ahk", true)  ; Suspended.
        ScriptSuspend("PhotoshopAs.ahk", false) ; Unsuspend.
} else IfInString, text, °
{
	brush := true
	suspend, off
	;SoundBeep, 750
	SetTitleMatchMode 2
	ScriptSuspend("PhotoshopLasso.ahk", true)  ; Suspend.
    ScriptSuspend("PhotoshopAs.ahk", true) ; Suspended.
}
else IfInString, text, Feather
{
	suspend, off
	SetTitleMatchMode 2
	ScriptSuspend("PhotoshopLasso.ahk", false) ; Unsuspend.
    ScriptSuspend("PhotoshopAs.ahk", true) ; Suspended.
} else
{
	brush := false
	suspend, on
	SetTitleMatchMode 2
	ScriptSuspend("PhotoshopLasso.ahk", true)  ; Suspended.
    ScriptSuspend("PhotoshopAs.ahk", true) ; Suspended.
	; SoundBeep
}
sleep 600
}
else
{
WinWaitActive, ahk_class Photoshop
; SoundBeep, 1200
}
; debug soundbeep, really helps me out.
; SoundBeep
}
return
#IfWinActive ahk_class Photoshop
$+tab::tab
$tab::0
$!tab::!tab
^tab::tab
$r::^z
$^r::^r
$n::!^+n
^n::^n

#IfWinActive

; https://stackoverflow.com/questions/14492650/check-if-script-is-suspended-in-autohotkey
ScriptSuspend(ScriptName, SuspendOn)
{
    ; Get the HWND of the script's main window (which is usually hidden).
    dhw := A_DetectHiddenWindows
    DetectHiddenWindows On
    if scriptHWND := WinExist(ScriptName " ahk_class AutoHotkey")    
    {
        ; This constant is defined in the AutoHotkey source code (resource.h):
        static ID_FILE_SUSPEND := 65404

        ; Get the menu bar.
        mainMenu := DllCall("GetMenu", "ptr", scriptHWND)
        ; Get the File menu.
        fileMenu := DllCall("GetSubMenu", "ptr", mainMenu, "int", 0)
        ; Get the state of the menu item.
        state := DllCall("GetMenuState", "ptr", fileMenu, "uint", ID_FILE_SUSPEND, "uint", 0)
        ; Get the checkmark flag.
        isSuspended := state >> 3 & 1
        ; Clean up.
        DllCall("CloseHandle", "ptr", fileMenu)
        DllCall("CloseHandle", "ptr", mainMenu)

        if (!SuspendOn != !isSuspended)
            SendMessage 0x111, ID_FILE_SUSPEND,,, ahk_id %scriptHWND%
        ; Otherwise, it's already in the right state.
    }
    DetectHiddenWindows %dhw%
}
