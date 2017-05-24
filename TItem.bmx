


' Basisklasse für Items

Type TItem

	Global List:TList = New TList
	
	' Gibt an, ob ein Item beim erstellen zur Liste hinzugefügt werden soll oder nicht
	Global ToList:Byte
	
	' Der Link in der Liste zum Item
	Field _link:TLink = New TLink

	' Der Name des Items
	Field _name:String
	
	' Definiert welche Art von Item es ist ( Waffe, Rüstung, Trank usw. )
	Field _type:Byte
	
	' Definiert welche Unterart von Item es ist. ZB. Was für eine Waffe ( Schwert, Axt, Dolch ), oder was für eine Rüstung ( Helm, Stiefel, Hände usw.)
	Field _subType:Byte
	
	' Wie selten ist ein Item und welche Quallität hat es. Umso seltener desto besser ist die Quallität und desto mehr Bonies sind auf dem Item.
	' Aber auch die Dropchance verringert sich umso besser ein Item ist
	Field _rarity:Byte
	
	
	' Definiert ob dieses Item stapelbar ist, also sich mehrere dieser Items in einem Inventarplatz befinden können.
	Field _stackable:Byte
	' Wieviele Items befinden sich in einem Inventarslot
	Field _amount:Int
	
	
	' Die Farbwerte wie ein Item im Inventar gezeichnet wird. Dadurch enteht selbst bei wenigen Icons der Eindruck von vielen verschiedenen Bildchen.
	Field _r:Byte, _g:Byte, _b:Byte
	
	' Die Frame-nummer (Icon) vom geladenen "Animimage" bzw. Iconsets.
	Field _frame:Int
	
	' Das Bild
	Field _image:TImage
	
	' Der Infotext welcher angezeigt wird, wenn man mit der Maus über das Item-Icon fährt
	Field _infoText[10]:String
	
	
	
	
	Method New()
		Self._r = 255
		Self._g = 255
		Self._b = 255
		If TItem.ToList = True
			Self._link = TItem.List.AddLast Self
		End If
	End Method
	
	
	Method Free()
		If Self._link
			TItem.List.Remove Self
			Self._link = Null
		End If
	End Method
	
	
	
	' Einzeichnen des Items im Inventar
	Method Draw(x:Float, y:Float) Final
		SetColor Self._r, Self._g, Self._b
		DrawImage Self._image, x, y, Self._frame
		SetColor 255, 255, 255
	End Method
	
	
	
	' Zeigen der Infos des Items (zB. wenn man mit dem Mauszeiger über das Item-Icon fährt)
	Method ShowInfo(x:Float, y:Float, gW:Int = 640, gH:Int = 480) Final
		Local rectWidth:Int, rectHeight:Int
		Local rectX:Int, rectY:Int
		
		' Infobox zeichnen
		If RectsOverlap(MouseX(), MouseY(), 1, 1, x, y, 32, 32) = True
			' Größe der Infobox, abhänging von der Menge der Infos
			For Local i:Int = 0 To 9
				If Self._infoText[i] <> Null Then rectHeight = rectHeight + 20
			Next
			rectWidth = TextWidth(Self._name) + 10
		
			' Position der Infobox, abhängig von der Mausposition
			rectX = MouseX() - rectWidth - 10
			If MouseY() <= gH/2
				rectY = MouseY()
			Else
				rectY = MouseY() - rectHeight
			End If
			
			' Das Rechteck (Hintergrund) zeichnen
			SetAlpha 0.5
				SetColor 0, 0, 0 
				DrawRect rectX, rectY, rectWidth, rectHeight
			SetAlpha 1
			
			' Die Farbe des Textes in abhängigkeit der Seltenheit des Items festlegen
			Select Self._rarity
				Case 1
					SetColor 255, 255, 255
				Case 2 
					SetColor 0, 200, 255
				Case 3
					SetColor 255, 255, 100
				Case 4
					SetColor 255, 130, 0
			End Select
			
			' Den Infotext zeichnen
			DrawText Self._name, rectX + 5, rectY + 5
			For Local i:Int = 0 To 9
				If Self._infoText[i] <> Null
					DrawText Self._infoText[i], rectX + 10, rectY + i*15
				End If
			Next
		End If
		SetColor 255, 255, 255
	End Method
	
	
	
	' Aktualisieren der Interaktionen mit dem Item im Inventar. ( Drauf klicken, verschieben, ausrüsten usw.)
	Method Update(mh1:Int, mh2:Int) Abstract
	
	
	' Getter
	Method GetObj:Object()
		If Self._link
			Return Self._link.Value()
		End If
	End Method
	Method GetLink:TLink()
		If Self._link
			Return Self._link
		End If
	End Method
	Method GetName:String()
		Return Self._name
	End Method
	Method GetType:Byte()
		Return Self._type
	End Method
	Method GetSubType:Byte()
		Return Self._subType
	End Method
	Method GetRarity:Byte()
		Return Self._rarity
	End Method
	Method GetStackable:Byte()
		Return Self._stackable
	End Method
	Method GetAmount:Int()
		Return Self._amount
	End Method
	Method GetR:Byte()
		Return Self._r
	End Method
	Method GetG:Byte()
		Return Self._g
	End Method
	Method GetB:Byte()
		Return Self._b
	End Method
	Method GetFrame:Int()
		Return Self._frame
	End Method
	
	' Setter
	Method SetName(name:String)
		Self._name = name
	End Method
	Method SetType(typ:Byte)
		Self._type = typ
	End Method
	Method SetSubType(subType:Byte)
		Self._subType = subType
	End Method
	Method SetRarity:Byte(rarity:Byte)
		Self._rarity = rarity
	End Method
	Method SetStackable:Byte(stackable:Byte)
		Self._stackable = stackable
	End Method
	Method SetAmount:Int(amount:Int)
		Self._amount = amount
	End Method
	Method SetR:Byte(r:Byte)
		Self._r = r
	End Method
	Method SetG:Byte(g:Byte)
		Self._g = g
	End Method
	Method SetB:Byte(b:Byte)
		Self._b = b
	End Method
	Method SetFrame:Int(frame:Int)
		Self._frame = frame
	End Method
	
	
	' Adder
	Method AddToName(name:String, space:Byte = True)
		If space = False
			Self._name = Self._name + name
		Else
			Self._name = Self._name + " " + name
		End If
	End Method
	Method AddToStack(amount:Int)
		Self._amount = Self._amount + amount
	End Method
	
	
	'Suber
	Method SubFromStack(amount:Int)
		Self._amount = Self._amount - amount
	End Method
	
End Type










