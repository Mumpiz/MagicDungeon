


Type TLootSlot

	Field _x:Float, _y:Float
	
	Field _wearItem:TWearItem
	Field _stackItem:TStackItem
	
	
	
	Function Create:TLootSlot(x:Float, y:Float)
		Local s:TLootSlot = New TLootSlot
		s._x = x
		s._y = y
		Return s
	End Function
	
	Method Draw()
		If Self._wearItem <> Null
			Self._wearItem.Draw(Self._x, Self._y)
		End If
		If Self._stackItem <> Null
			Self._stackItem.Draw(Self._x, Self._y)
		End If
	End Method
	
	
	Method DrawItemInfo()
		If Self._wearItem <> Null
			Self._wearItem.ShowInfo(Self._x, Self._y)
		End If
		If Self._stackItem <> Null
			Self._stackItem.ShowInfo(Self._x, Self._y)
		End If
	End Method
	
	Method Update(mh1:Int, mh2:Int)
		If RectsOverlap(MouseX(), MouseY(), 1, 1, Self._x, Self._y, 32, 32) = True
			If mh1 = True
				FlushMouse()
				If Self._wearItem <> Null
					If PutItemInInventory(Self._wearItem) = True
						Self._wearItem= Null
					End If
				End If
				If Self._stackItem <> Null
					If Self._stackItem._typ = 0 ' Gold
						TPlayer(TPlayer.List.First())._gold = TPlayer(TPlayer.List.First())._gold + Self._stackItem._amount
						Self._stackItem = Null
					ElseIf Self._stackItem._typ = 1 ' Potion
						TPlayer(TPlayer.List.First())._potions = TPlayer(TPlayer.List.First())._potions + Self._stackItem._amount
						Self._stackItem = Null
					End If
				End If
			End If
		End If
	End Method
	
End Type








Type TLootBox
	Global List:TList = New TList
	Global GenerateItems:Byte = False 

	Field _x:Float, _y:Float
	
	Field _slot:TLootSlot[4]
	
	Field _show:Byte = False
	
	Function Create(x:Float, y:Float)
		Local l:TLootBox = New TLootBox
		l._x = x
		l._y = y
		l._slot[0] = TLootSlot.Create(l._x+18, l._y+20)
		l._slot[1] = TLootSlot.Create(l._x+18+32, l._y+20)
		l._slot[2] = TLootSlot.Create(l._x+18, l._y+20+32)
		l._slot[3] = TLootSlot.Create(l._x+18+32, l._y+20+32)
	End Function
	
	Method New()
		TLootBox.List.AddLast Self
	End Method
	
	
	Method Render(mh1:Int, mh2:Int)
		Local cnt:Int
		Local goldGenerated:Byte = False
		Local potionGenerated:Byte = False
		Local whichSort:Int ' 0 - 4 = Gold, 5 - 10 = Equip, 11 = Potion
		
			If TLootBox.GenerateItems = True And Self._show = False
			
				cnt = Rand(1, 4)
				
				For Local i:Int = 0 To cnt - 1
					whichSort = Rand(0, 11)
					
					' Gold
					If whichSort >= 0 And whichSort <= 4
						If goldGenerated = False
							Self._slot[i]._stackItem = TStackItem.Create(Rand(0,5) + 6, 0) '5 = DungeonLevel
							goldGenerated = True
						Else
							whichSort = 5
						End If
					End If
					' Potion
					If whichSort = 11
						If potionGenerated = False
							Self._slot[i]._stackItem = TStackItem.Create(1, 1) '5 = DungeonLevel
							potionGenerated = True
						Else
							whichSort = 5
						End If
					End If
					' Equip
					If whichSort >= 5 And whichSort <= 10
						TWearItem.Generate(5, Rand(0, 17))
						Self._slot[i]._wearItem = TWearItem(TWearItem.List.Last())
					End If
				Next
				TLootBox.GenerateItems = False
				Self._show = True
			End If
			
			If Self._show = True
				SetColor 0, 0, 0
				SetAlpha 0.7
				DrawRect Self._x+4, Self._y+4, 95, 95
				SetAlpha 1
				SetColor 255, 255, 255
				DrawImage Img_LootBox, Self._x, Self._y
				SetColor 0,0,0
				DrawText "close", Self._x + 33, Self._y + 91
				SetColor 255, 255, 255
				
				Local allEmpty:Byte = True
				For Local i:Int = 0 To 3
					Self._slot[i].Draw()
					Self._slot[i].DrawItemInfo()
					Self._slot[i].Update(mh1, mh2)
					If Self._slot[i]._wearItem <> Null Or Self._slot[i]._stackItem <> Null Then allEmpty = False
				Next
				If allEmpty = True
					TLootBox.GenerateItems = False
					Self._show = False
				End If
				
				' x - Button und close - button
				If mh1 = True
					If RectsOverlap(MouseX(), MouseY(), 1, 1, Self._x + 83, Self._y, 20, 20) Or RectsOverlap(MouseX(), MouseY(), 1, 1, Self._x + 29, Self._y + 90, 48, 20)
						For Local i:Int = 0 To 3
							If Self._slot[i]._wearItem <> Null
								TWearItem.List.Remove Self._slot[i]._wearItem
								Self._slot[i]._wearItem = Null
								TLootBox.GenerateItems = False
								Self._show = False
							End If
							If Self._slot[i]._stackItem <> Null
								Self._slot[i]._stackItem = Null
								TLootBox.GenerateItems = False
								Self._show = False
							End If
						Next
					End If
				End If

			
			End If
	End Method
	
	
End Type

Function RenderLootBox(mh1:Int, mh2:Int)
	TLootBox(TLootBox.List.First()).Render(mh1, mh2)
End Function




