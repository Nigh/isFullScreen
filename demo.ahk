#Requires AutoHotkey >=v2.0 
#include isFullScreen.ahk

h2FontStyle:="s32 w600 cc07070 q5"
textFontStyle:="s12 w400 cblack q5"
btextFontStyle:="s14 w800 cblack q5"

monitors:=[]
loop MonitorGetCount()
{
	MonitorGet(A_Index, &Left, &Top, &Right, &Bottom)
	monitors.Push({l:Left,t:Top,r:Right,b:Bottom})
}

testgui := Gui("+ToolWindow +AlwaysOnTop -DPIScale +OwnDialogs","isFullScreen")
testgui.SetFont(, "MV Boli")

testgui.SetFont(h2FontStyle)
testgui.Add("Text", "x10 y10 w500 section", "isFullScreen")

testgui.SetFont(textFontStyle)
testgui.Add("Text", "xs y+30 w100", "WinTitle:")
winname:=testgui.Add("Text", "x+10 w500", "asdasd")

testgui.Add("Text", "xs y+10 w100", "WinClass:")
winclass:=testgui.Add("Text", "x+10 w500", "asdasd")

testgui.SetFont(btextFontStyle)
testgui.Add("Text","xs y+10 w100", "Monitors")
testgui.Add("Text","x+10 wp", "Left")
testgui.Add("Text","x+10 wp", "Top")
testgui.Add("Text","x+10 wp", "Right")
testgui.Add("Text","x+10 wp", "Bottom")
testgui.SetFont(textFontStyle)
loop monitors.Length
{
	testgui.Add("Text","xs y+10 wp", "No." A_index ":")
	testgui.Add("Text","x+10 wp", monitors[A_Index].l)
	testgui.Add("Text","x+10 wp", monitors[A_Index].t)
	testgui.Add("Text","x+10 wp", monitors[A_Index].r)
	testgui.Add("Text","x+10 wp", monitors[A_Index].b)
}
testgui.SetFont(btextFontStyle)
testgui.Add("Text", "xs y+30 wp", "Current:")
testgui.Add("Text","xs y+10 wp", "client")
testgui.Add("Text","x+10 wp", "X")
testgui.Add("Text","x+10 wp", "Y")
testgui.Add("Text","x+10 wp", "W")
testgui.Add("Text","x+10 wp", "H")
testgui.SetFont(textFontStyle)

clientdim_x:=testgui.Add("Text","xs y+10 wp", "")
clientdim_x:=testgui.Add("Text","x+10 wp", "x2222")
clientdim_y:=testgui.Add("Text","x+10 wp", "y2222")
clientdim_w:=testgui.Add("Text","x+10 wp", "w2222")
clientdim_h:=testgui.Add("Text","x+10 wp", "h2222")

testgui.SetFont(h2FontStyle)
isfull:=testgui.Add("Text","xs y+30 w500", "No")

testgui.OnEvent("Close", GuiClose)
GuiClose(thisGui) {  ; Declaring this parameter is optional.
    ExitApp
}
testgui.Show()
settimer(scan, 500)
Return

scan()
{
	global
	uid:=WinExist("A")
	if(!uid){
		Return
	}
	wid:="ahk_id " uid
	WinGetClientPos(&cx,&cy,&cw,&ch,wid)
	clientdim_x.value:=cx
	clientdim_y.value:=cy
	clientdim_w.value:=cw
	clientdim_h.value:=ch
	winname.Value:=WinGetTitle(wid)
	winclass.Value:=WinGetClass(wid)
	if(isFullScreen()){
		isfull.Value:="It's FullScreen Now"
	}else{
		isfull.Value:="Not FullScreen"
	}
}
