





Type TMouseSlot
	Global List:TList = New TList
	
	Field _item:TWearItem
	
	Function Create()
		Local m:TMouseSlot = New TMouseSlot
	End Function
	
	Method New()
		Self._item:TWearItem = Null
		TMouseSlot.List.AddLast Self
	End Method


	Method Draw()
		If Self._item <> Null
			Self._item.Draw(MouseX()-16, MouseY()-16)
		End If
	End Method

End Type


Function UpdateMouseSlot(mh1:Int, mh2:Int)
	For Local s:TMouseSlot = EachIn TMouseSlot.List
		If s._item <> Null
			s.Draw()
		End If
	Next
End Function



Type TTmpSlot
	Global List:TList = New TList
	
	Field _item:TWearItem
	
	Function Create()
		Local m:TTmpSlot= New TTmpSlot
	End Function
	
	Method New()
		Self._item:TWearItem = Null
		TTmpSlot.List.AddLast Self
	End Method
End Type



