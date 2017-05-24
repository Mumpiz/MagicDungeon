


Type TInvSlot Extends TSlot
	
		
	Global List:TList = New TList
	Field _link:TLink
	
	
	Method New()
		Self._link = TInvSlot.List.AddLast Self
	End Method
	
	
	
	Function Render()
		For Local s:TInvSlot = EachIn TInvSlot.List
			If s._show = True
				s.Draw()
				s.DrawItemInfo()
				s.Update()
			End If
		Next
	End Function
	
	
	Function AddItem(item:TItem)
		For Local s:TInvSlot = EachIn TInvSlot.List
			If s._item = Null
				s._item = item
			End If
		Next
	End Function

End Type



Function CreateInventory(posX:Float = 496, posY:Float = 288, width:Int = 4, height:Int = 5)
	For Local y:Int = 0 To height - 1
		For Local x:Int = 0 To width - 1
			TInvSlot.Create(posX + x*32, posY + y*32, True, 0)
		Next
	Next
End Function



