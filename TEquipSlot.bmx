


Type TEquipSlot
	Global List:TList = New TList

	Field _x:Float, _y:Float
	
	Field _typ:Int
	
	Field _item:TWearItem
	
	
	
	Function Create(x:Float, y:Float, typ:Int)
		Local s:TEquipSlot = New TEquipSlot
		s._x = x
		s._y = y
		s._typ = typ
	End Function
	
	
	Method New()
		TEquipSlot.List.AddLast Self
	End Method
	
	Method Draw()
		If Self._item <> Null
			Self._item.Draw(Self._x, Self._y)
		EndIf 
		If TMouseSlot(TMouseSlot.List.First())._item <> Null
			SetAlpha 0.3
			If TMouseSlot(TMouseSlot.List.First())._item._typ = Self._typ Then HighlightSlot()
			SetAlpha 1
		End If
	End Method
	
	
	Method DrawItemInfo()
		If Self._item <> Null
			Self._item.ShowInfo(Self._x, Self._y)
		End If
	End Method
	
	
	Method HighlightSlot()
		DrawOval(Self._x, Self._y, 32, 32)
	End Method
	
	
	Method Update(mh1:Int, mh2:Int)
		If mh1 = True
			If RectsOverlap(MouseX(), MouseY(), 1, 1, Self._x, Self._y, 32, 32) = True
				If TMouseSlot(TMouseSlot.List.First())._item = Null
					TMouseSlot(TMouseSlot.List.First())._item = Self._item
					Self._item = Null
					
				ElseIf TMouseSlot(TMouseSlot.List.First())._item <> Null
					
					If Self._item = Null
						If TMouseSlot(TMouseSlot.List.First())._item._typ = Self._typ
							Self._item = TMouseSlot(TMouseSlot.List.First())._item
							TMouseSlot(TMouseSlot.List.First())._item = Null
						End If
						
					ElseIf Self._item <> Null
						If TMouseSlot(TMouseSlot.List.First())._item._typ = Self._typ
							TTmpSlot(TTmpSlot.List.First())._item = Self._item
							Self._item = TMouseSlot(TMouseSlot.List.First())._item
							TMouseSlot(TMouseSlot.List.First())._item = TTmpSlot(TTmpSlot.List.First())._item
							TTmpSlot(TTmpSlot.List.First())._item = Null
						End If
					End If
				End If
			End If
		End If
	End Method
	
	


End Type



Rem
	typ = 0  Waffe			
	typ = 1  Kopf					
	typ = 2  Hände				
	typ = 3  Brust				
	typ = 4  Füße		
	typ = 5  Ring
	typ = 6  Gem
End Rem
Function CreateEquipSlots(posX:Float = 512, posY:Float = 32)
	TEquipSlot.Create(posX, posY+96, 4) 	' Füße
	TEquipSlot.Create(posX, posY+64, 3) 	' Brust
	TEquipSlot.Create(posX, posY+32, 2) 	' Hände
	TEquipSlot.Create(posX, posY, 0) 		' Waffe
	TEquipSlot.Create(posX+32, posY, 5) 	' Ring
	TEquipSlot.Create(posX+64, posY, 1) 	' Kopf
End Function



Function UpdateEquipSlots(mh1:Int, mh2:Int)
	For Local s:TEquipSlot = EachIn TEquipSlot.List
		s.Draw()
		s.DrawItemInfo()
		s.Update(mh1, mh2)
	Next
End Function














