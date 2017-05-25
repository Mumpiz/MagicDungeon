

Local stairsDownExsist:Byte = False
	
	For Local y:Int =  0 To height - 1
		For Local x:Int = 0 To width - 1
		
			' Garantieren, dass auch eine Treppe nach unten existiert
			If y = height - 1 And x = width - 1 And stairsDownExsist = False
				TTile.Create(x*32, y*32, 2 )
				Exit
			End If
			
			Local rndObj:Int = Rand(0,40)
			If rndObj = 0 ' Schatzkiste
				TTile.Create(x*32, y*32, 1 )
				
			ElseIf rndObj = 1 ' Treppe runter
				If x > 2 And y > 2
					If stairsDownExsist = False
						TTile.Create(x*32, y*32, 2 )
						stairsDownExsist = True
					End If
				End If
				
			Else ' Normaler Boden
				TTile.Create(x*32, y*32, 0 )
			End If
		Next
	Next
