



' Arrow-Keys
Global KeyUp:Int
Global KeyDwn:Int
Global KeyLeft:Int
Global KeyRight:Int

' Leertaste
Global KeySpace:Int


' Maustasten
Global MH1:Int
Global MH2:Int




Function UpdateInput()
	' Arrow-Keys
	KeyUp = KeyHit(KEY_UP) Or KeyHit(KEY_W)
	KeyDwn = KeyHit(KEY_DOWN) Or KeyHit(KEY_S)
	KeyLeft = KeyHit(KEY_LEFT) Or KeyHit(KEY_A)
	KeyRight = KeyHit(KEY_RIGHT) Or KeyHit(KEY_D)
	
	' Leertaste
	KeySpace = KeyHit(KEY_SPACE)
	
	' Maustasten
	MH1 = MouseHit(1)
	MH2 = MouseHit(2)
	
End Function


Function RectsOverlap:Byte(x1:Int, y1:Int, w1:Int, h1:Int, x2:Int, y2:Int, w2:Int, h2:Int)
	If x1 < (x2 + w2) And y1 < y2 + h2 And (x1 + w1) > x2 And (y1 + h1) > y2 Then Return True
	Return False
End Function