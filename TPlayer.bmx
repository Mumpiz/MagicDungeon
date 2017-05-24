


Type TPlayer

	Global List:TList = New TList

	Field _x:Float, _y:Float
	
	Field _name:String
	
	Field _curHp:Int, _maxHp:Int, _xp:Int
	
	Field _gold:Int, _potions:Int
	
	Field _curFloor:Int, _maxFloor:Int
	
	Field _atk:Int, _vit:Int, _def:Int

	
	Function Create(hp:Int, xp:Int, gold:Int)
		Local p:TPlayer = New TPlayer
		p._curHp = hp
		p._maxHp = hp
		p._xp = xp
		p._gold = gold
		For Local t:TTile = EachIn TTile.List
				If t._frame = 7
					p._x = t._x
					p._y = t._y
					TTile.SetDiscovered(p._x, p._y)
				End If
			Next
	End Function
	
	
	Method New()	
		TPlayer.List.AddLast Self
	End Method
	
	Method Draw()
		DrawImage(Img_Player, Self._x, Self._y)
		SetAlpha 0.4
		DrawImage(Img_LightRadius, Self._x - 480 + 32, Self._y - 480)
		SetAlpha 1
		DrawText TPlayer(TPlayer.List.First())._potions, 587, 145
		DrawText TPlayer(TPlayer.List.First())._gold, 531,453
	End Method
	
	Method UpdateMoves()
		' Hoch
		If KeyUp And Self._y >= 32
			TTile.SetDiscovered(Self._x, Self._y - 32)
			If TTile.GetFrame(Self._x, Self._y - 32) <> 8
				TTile.SetDiscovered(Self._x, Self._y - 64)
				Self._y = Self._y - 32
			End If
		End If
		'Runter
		If KeyDwn And Self._y < 448
			TTile.SetDiscovered(Self._x, Self._y + 32)
			If TTile.GetFrame(Self._x, Self._y + 32) <> 8
				TTile.SetDiscovered(Self._x, Self._y + 64)
				Self._y = Self._y + 32
			End If
		End If
		' Links
		If KeyLeft And Self._x >= 32
			TTile.SetDiscovered(Self._x - 32, Self._y)
			If TTile.GetFrame(Self._x - 32, Self._y) <> 8
				TTile.SetDiscovered(Self._x - 64, Self._y)
				Self._x = Self._x - 32
			End If
		End If
		' Rechts
		If KeyRight And Self._x < 448
			TTile.SetDiscovered(Self._x + 32, Self._y)
			If TTile.GetFrame(Self._x + 32, Self._y) <> 8
				TTile.SetDiscovered(Self._x + 64, Self._y)
				Self._x = Self._x + 32
			End If
		End If
		
		' Leertaste
		If KeySpace
			OpenChest(Self)
			GoFloorDown(Self)
		End If
		'DrawText TTile.GetFrame(Self._x/32, Self._y/32), 0, 0
		
	End Method

End Type


Function RenderPlayer()
	For Local p:TPlayer = EachIn TPlayer.List
		p.Draw()
		p.UpdateMoves()
	Next
End Function


Function GoFloorDown(player:TPlayer)
		If TTile.GetFrame(player._x, player._y) = 6 ' Treppe hinunter
			FreeMap()
			GenerateMap()
			For Local t:TTile = EachIn TTile.List
				If t._frame = 7
					player._x = t._x
					player._y = t._y
					TTile.SetDiscovered(player._x, player._y)
				End If
			Next
		End If
		
End Function


Function OpenChest(player:TPlayer)
	If TTile.GetFrame(player._x, player._y) = 4 ' Schatzkiste
		TLootBox.GenerateItems = True
		TTile.SetFrame(player._x, player._y, 5)
	End If
End Function



