


Type TTile
	
	Global List:TList = New TList

	Field _x:Float, _y:Float
	Field _frame:Int
	Field _discovered:Byte = False

	Method New()
		TTile.List.AddLast(Self)
	End Method
	
	
	Function Create(x:Float, y:Float, frame:Int)
		Local t:TTile = New TTile
		t._x = x
		t._y = y
		t._frame = frame
	End Function
	
	Method Free()
		TTile.List.Remove(Self)
	End Method
	
	Method Draw()
		If Self._discovered = True Then DrawImage( Img_Tileset, Self._x, Self._y, Self._frame)	
	End Method
	
	Function GetFrame:Int(x:Float, y:Float)
		For Local t:TTile = EachIn TTile.List
			If t._x = x
				If t._y = y
					Return t._frame
				End If
			End If
		Next
	End Function
	
	Function SetFrame(x:Float, y:Float, frame:Int)
		For Local t:TTile = EachIn TTile.List
			If t._x = x
				If t._y = y
					t._frame = frame
				End If
			End If
		Next
	End Function
	
	Function SetDiscovered(x:Float, y:float)
		For Local t:TTile = EachIn TTile.List
			If t._x = x
				If t._y = y
					t._discovered = True
				End If
			End If
		Next
	EndFunction
	
	

End Type



Function GenerateMap(width:Int = 15, height:Int = 15)
	
	Local stairsDownExsist:Byte = False
	
	
	For Local y:Int =  0 To height - 1
		For Local x:Int = 0 To width - 1
			
			' Garantieren, dass auch eine Treppe nach unten existiert
			If y = height - 1 And x = width - 1 And stairsDownExsist = False
				TTile.Create(x*32, y*32, 6 )
				Exit
			End If
			
			Local rndObj:Int = Rand(0,50)
			
			If rndObj = 0 ' Schatzkiste
				TTile.Create(x*32, y*32, 4 )
				
			ElseIf rndObj = 1 ' Treppe runter
				If x > 5 And y > 5
					If stairsDownExsist = False
						TTile.Create(x*32, y*32, 6 )
						stairsDownExsist = True
					Else
						TTile.Create(x*32, y*32, 0 )
					End If
				Else
					TTile.Create(x*32, y*32, 0 )
				End If
				
			ElseIf rndObj = 2 ' Riss im Boden
				TTile.Create(x*32, y*32, 1 )
			
			ElseIf rndObj = 3 ' Monsterskelett
				TTile.Create(x*32, y*32, 2 )
				
			ElseIf rndObj = 4 ' Menschenskelett
				TTile.Create(x*32, y*32, 3 )
				
			ElseIf rndObj >= 5 And rndObj <= 12' Wand
				If x >= 1 And y >= 1
					TTile.Create(x*32, y*32, 8 )
				Else
					TTile.Create(x*32, y*32, 0 )
				End If
				
			Else ' Normaler Boden
				TTile.Create(x*32, y*32, 0 )
			End If
		Next
	Next
	
	'Local target:TEntity = TEntity(Self._targetLink.Value())
	Local stairsUpX:Int = Rand(0,width-1)
	Local stairsUpY:Int = Rand(0,height-1)
	Repeat
		If TTile.GetFrame(stairsUpX*32, stairsUpY*32) <> 6
			TTile.SetFrame(stairsUpX*32,stairsUpY*32,7)
			Exit
		End If
	Forever
	
End Function


Function FreeMap()
	For Local t:TTile = EachIn TTile.List
		t.Free()
	Next
End Function


Function DrawMap()
	For Local t:TTile = EachIn TTile.List
		t.Draw()
	Next
End Function











