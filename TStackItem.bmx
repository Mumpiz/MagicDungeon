



Type TStackItem
	Field _name:String
	Field _frame:Int
	
	Field _typ:Byte
	
	Field _amount:Int
	
	Function Create:TStackItem(amount:Int, typ:Byte)
		Local s:TStackItem = New TStackItem
		s._amount = amount
		s._typ = typ
		s._frame = typ
		
		If typ = 0 s._name = amount + " Gold"
		If typ = 1 s._name = amount + " x Healthpotion"
		Return s
	End Function
	
	
	Method Draw(x:Float, y:Float)
		DrawImage Img_StackItems, x, y, Self._frame
	End Method
	
	Method ShowInfo(x:Float, y:Float)
		If RectsOverlap(MouseX(), MouseY(), 1, 1, x, y, 32, 32) = True
			SetAlpha 0.5
			SetColor 0, 0, 0
			DrawRect MouseX() - Len(Self._name)*9, MouseX() - 30, Len(Self._name)*8, 10
			SetAlpha 1
			SetColor 255, 255, 255
			Local x:Float = MouseX() - Len(Self._name)*8
			Local y:Float = MouseY() - 20
			DrawText Self._name, x + 5, y
		End If
	End Method
	
End Type




