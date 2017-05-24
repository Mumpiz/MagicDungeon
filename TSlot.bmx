

' Basisklasse für ein Inventarslot welches ein Item beinhalten kann


Type TSlot
	
	' X und Y Koordinaten
	Field _x:Float, y:Float
	
	' Das Item welches der Slot in sich beinhaltet
	Field _item:TItem
	
	' Definiert, ob dieser Slot gezeichnet werden soll oder nicht
	Field _show:Byte
	
	' Nur für die Equipslots wichtig, damit sichergestellt ist, dass man zB. nicht ein Waffenitem in ein Rüstungsslot stecken kann
	Field _type:Int = 0
	
	
	Function Create(x:Float, y:Float, show:Byte, typ:Byte = 0) Final
		Local s:TSlot = New TSlot
		s._x = x
		s._y = y
		s._type = typ
		s._show = show
	End Function
	
	
	
	Method Draw() Final
		If Self._show = True
			If Self._item <> Null
				Self._item.Draw(Self._x, Self._y)
			End If
		End If
	End Method
	
	Method DrawItemInfo() Final
		If Self._show = True
			If Self._item <> Null
				Self._item.ShowInfo(Self._x, Self._y)
			End If
		End If
	End Method
	
	
	Method Update(mh1:Int, mh2:Int) Abstract
	
End Type


Function RenderAllSlots()
	TInvSlot.Render()
End Function











