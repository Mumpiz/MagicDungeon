


Type TInventorySlot
	
	Global List:TList = New TList

	Field _x:Float, _y:Float
	
	Field _item:TWearItem
	
	
	
	Function Create(x:Float, y:Float)
		Local s:TInventorySlot = New TInventorySlot
		s._x = x
		s._y = y
	End Function
	
	
	Method New()
		TInventorySlot.List.AddLast Self
	End Method
	
	Method Draw()
		If Self._item <> Null
			Self._item.Draw(Self._x, Self._y)
		End If
	End Method
	
	Method DrawItemInfo()
		If Self._item <> Null
			Self._item.ShowInfo(Self._x, Self._y)
		End If
	End Method
	
	
	Method Update(mh1:Int, mh2:Int)
		If mh1 = True
		
			' Spieler löscht item
			If MouseX() < 450
				'Notify "!!"
				TWearItem.List.Remove TMouseSlot(TMouseSlot.List.First())._item
				TMouseSlot(TMouseSlot.List.First())._item = Null
			End If
		
			If RectsOverlap(MouseX(), MouseY(), 1, 1, Self._x, Self._y, 32, 32) = True
			
				If TMouseSlot(TMouseSlot.List.First())._item = Null
					TMouseSlot(TMouseSlot.List.First())._item = Self._item
					Self._item = Null
					
				ElseIf TMouseSlot(TMouseSlot.List.First())._item <> Null
					If Self._item = Null
						Self._item = TMouseSlot(TMouseSlot.List.First())._item
						TMouseSlot(TMouseSlot.List.First())._item = Null
						
					ElseIf Self._item <> Null
						TTmpSlot(TTmpSlot.List.First())._item = Self._item
						Self._item = TMouseSlot(TMouseSlot.List.First())._item
						TMouseSlot(TMouseSlot.List.First())._item = TTmpSlot(TTmpSlot.List.First())._item
						TTmpSlot(TTmpSlot.List.First())._item = Null
					End If
				End If
			End If
		End If
	End Method
	

End Type


Function UpdateInventorySlots(mh1:Int, mh2:Int)
	For Local s:TInventorySlot = EachIn TInventorySlot.List
		s.Draw()
		s.DrawItemInfo()
		s.Update(mh1, mh2)
	Next
End Function


Function PutItemInInventory:Byte(item:TWearItem)
	For Local s:TInventorySlot = EachIn TInventorySlot.List
		If s._item = Null
			s._item = item
			Return True
		End If
	Next
	Return False
End Function


Function CreateInventory(posX:Float = 496, posY:Float = 288, width:Int = 4, height:Int = 5)
	For Local y:Int = 0 To height - 1
		For Local x:Int = 0 To width - 1
			TInventorySlot.Create(posX + x*32, posY + y*32)
		Next
	Next
End Function






















