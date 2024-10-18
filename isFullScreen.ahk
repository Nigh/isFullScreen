/*! 
    Checks if a window is in fullscreen mode.
    ______________________________________________________________________________________________________________

	Usage: isFullScreen()
	Return: True/False

	GitHub Repo: https://github.com/Nigh/isFullScreen
*/
class isFullScreen
{
	
	static monitors:=this.init()
	static init()
	{
		a:=[]
		loop MonitorGetCount()
		{
			local Left, Top, Right, Bottom
			MonitorGet(A_Index, &Left, &Top, &Right, &Bottom)
			a.Push({l:Left,t:Top,r:Right,b:Bottom})
		}
		Return a
	}

	static Call()
	{
		local uid:=WinExist("A")
		if(!uid){
			Return False
		}
		local wid:="ahk_id " uid
		c:=WinGetClass(wid)
		If (uid = DllCall("GetDesktopWindow") Or (c = "Progman") Or (c = "WorkerW")){
			Return False
		}
		local cx, cy, cw, ch
		WinGetClientPos(&cx,&cy,&cw,&ch,wid)
		cl:=cx
		ct:=cy
		cr:=cx+cw
		cb:=cy+ch
		For , v in this.monitors
		{
			if(cl==v.l and ct==v.t and cr==v.r and cb==v.b){
				Return True
			}
		}
		Return False
	}
}
