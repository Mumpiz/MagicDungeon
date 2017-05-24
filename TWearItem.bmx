


Type TWearItem
	
	Global List:TList = New TList

	' 0 Gold, 1 Waffe, 2 Kopf, 3 Hände, 4 Brust, 5 Füße, 6 Ring, 7 Heiltrank
	Field _typ:Byte
	
	Field _r:Byte, _g:Byte, _b:Byte
	

	' Bonies
	Field _minDmg:Int, _maxDmg:Int 'Nur Waffe
	Field _armorClass:Int ' Nur Rüstungsteile
	
	Field _hp:Int
	Field _atk:Int
	Field _str:Int
	Field _vit:Int
	Field _def:Int
	
	Field _name:String
	
	Field _frame:Int
	
	' 1 = common, 2 uncommon, 3 rare, 4 Legendary
	Field _rarity:Byte
	
	Method New()
		TWearItem.List.Addlast Self
	End Method
	
	Method Free()
		TWearItem.List.Remove Self
	End Method
	
	
	Function Create(	typ:Byte, r:Byte, g:Byte, b:Byte, ..
				minDmg:Int, maxDmg:Int, armorClass:Int, ..
				hp:Int, atk:Int, str:Int, vit:Int, def:Int, ..
				name:String, frame:Int, rarity:Byte)
				
		Local i:TWearItem = New TWearItem
		i._typ = typ
		i._r = r
		i._g = g
		i._b = b
		i._minDmg = minDmg
		i._maxDmg = maxDmg
		i._hp = hp
		i._atk = atk
		i._str = str
		i._vit = vit
		i._def = def
		i._name = name
		i._frame = frame
		i._rarity = rarity
	End Function
	
	
	Method Draw(x:Float, y:Float)
		SetColor Self._r, Self._g, Self._b
		DrawImage Img_WearItems, x, y, Self._frame
		SetColor 255, 255, 255
	End Method
	
	
	Method ShowInfo(x:Int, y:Int)
		Local posY:Float
		If MouseY() <= 240
			posY = MouseY()
		ElseIf MouseY() > 240
			posY = MouseY() - 100
		End If
		If RectsOverlap(MouseX(), MouseY(), 1, 1, x, y, 32, 32) = True
				SetAlpha 0.5
					SetColor 0, 0, 0
					DrawRect MouseX() - Len(Self._name)*8.5, posY, Len(Self._name)*8, 100
				SetAlpha 1
			
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
				
				
				Local x:Float = MouseX() - Len(Self._name)*8
				Local y:Float = posY
				DrawText Self._name, x + 5, y
				x = x + (Len(Self._name)*8.5)/5
				y = y + 20
				If Self._hp > 0
					DrawText "- HP + " + Self._hp, x, y
					y = y + 20
				End If
				If Self._vit > 0
					DrawText "- VIT + " + Self._vit, x, y
					y = y + 20
				End If
				If Self._atk > 0
					DrawText "- ATK + " + Self._atk, x, y
					y = y + 20
				End If
				If Self._str > 0
					DrawText "- STR + " + Self._str, x, y
					y = y + 20
				End If
				If Self._def > 0
					DrawText "- DEF + " + Self._def, x, y
					y = y + 20
				End If
					
			End If
		SetColor 255, 255, 255
	End Method
	
	
	Function Generate(dungeonFloor:Int, kind:Byte)
		
		' kind:Byte:
		' 0 Gold, 1 Schwert, 2 Axt, 3 Dolch, 4 Keule, 5 Morgenstern
		' 6 Eisenhelm, 7 Lederhut, 8 Stoffmütze, 9 Plattenhandschuhe, 10 Lederhandschuhe, 11 Plattenrüstung
		' 12 Lederrüstung, 13 Stoffcape, 14 Plattenstiefel, 15 Lederstiefel, 16 Goldring, 17 Silberring, 18 Heiltrank
	
		' 0 Gold, 1 Waffe, 2 Kopf, 3 Hände, 4 Brust, 5 Füße, 6 Ring, 7 Heiltrank
		Local typ:Int = ClassifyItemType(kind)
		
		Local name:String = ""
		Local dropChance:Int = Rand(0, 100)
		Local frame:Int = kind
		Local stat:Int[4]
		Local minDmg:Int = 0, maxDmg:Int = 0, armorClass:Int = 0
		Local bonusHp:Int, bonusStr:Int, bonusVit:Int, bonusAtk:Int, bonusDef:Int
		Local r:Byte = Rand(50, 255), g:Byte = Rand(50, 255), b:Byte = Rand(50, 255)
		
		
		
		Local rarity:Int = DefineRarity(dropChance)
		Local bonusPoints:Int = DefineBonusPoints(rarity, dungeonFloor)
		
		' Wenn Item eine Waffe
		If typ = 1 Then DefineWeaponDmg(dungeonFloor, minDmg, maxDmg, rarity)
		If typ >= 2 And typ <= 5 Then armorClass = DefineArmorClass(dungeonFloor, rarity)
		
		' Welche bonusstats bekommt das item ( +hp, +str etc. )
		' 1 bonusHp, 2 bonusStr, 3 bonusVit, 4 bonusDmg, 5 bonusDef
		DefineBonusStats(stat, rarity)
		
		
		' Wieviel Punkte bekommt jeder Bonusstat
		' 1 bonusHp, 2 bonusStr, 3 bonusVit, 4 bonusAtk, 5 bonusDef
		AllocateBonusPoints(bonusPoints, stat, bonusHp, bonusStr, bonusVit, bonusAtk, bonusDef)
		
		AllocateItemName(name, rarity, kind, typ, CalcBiggestBonusOnItem(bonusHp, bonusStr, bonusVit, bonusAtk, bonusDef))

		
		
		
		
		
		
		TWearItem.Create( typ, r, g, b, ..
				minDmg, maxDmg, armorClass, ..
				bonusHp, bonusAtk, bonusStr, bonusVit, bonusDef, ..
				name, frame, rarity)
		
	End Function
	
	
End Type



Function DefineArmorClass:Int(dungeonFloor:Int, rarity:Int)
	Select rarity
		Case 1 Return Rand(1, dungeonFloor)
		Case 2 Return dungeonFloor + rarity + Rand(0, rarity)
		Case 3 Return dungeonFloor + (rarity*2) + Rand(0, rarity)
		Case 4 Return dungeonFloor + (rarity*4) + Rand(0, rarity)
	End Select
End Function


Function DefineWeaponDmg(dungeonFloor:Int, minDmg:Int Var, maxDmg:Int Var, rarity:Int)
	Local dmgMin:Int, dmgMax:Int	
	Select rarity
		Case 1
			dmgMax = Rand(dungeonFloor/2, dungeonFloor)
			dmgMin = Rand(dungeonFloor/2, dungeonFloor) - (dmgMax/2)
		Case 2
			dmgMax = dungeonFloor + rarity + Rand(0, rarity)
			dmgMin = dungeonFloor + rarity + Rand(0, rarity) - (dmgMax/2)
		Case 3
			dmgMax = dungeonFloor + (rarity*2) + Rand(0, rarity)
			dmgMin = dungeonFloor + (rarity*2) + Rand(0, rarity) - (dmgMax/2)
		Case 4
			dmgMax = dungeonFloor + (rarity*4) + Rand(0, rarity)
			dmgMin = dungeonFloor + (rarity*4) + Rand(0, rarity) - (dmgMax/2)
	End Select
	If dmgMin <= 0 dmgMin = 1
	If dmgMax <= dmgMin Then dmgMax = dmgMin + (dmgMin/2) + 1
End Function




Function DefineRarity:Int(dropChance:Int)
	If dropChance <= 74
		Return 1
	ElseIf dropChance >= 75 And dropChance <= 95
		Return 2
	ElseIf dropChance >= 96 And dropChance <= 99
		Return 3
	ElseIf dropChance = 100
		Return 4
	End If
End Function


Function DefineBonusPoints:Int(rarity:Int, dungeonFloor:Int)
	Select rarity
		Case 1 Return Rand(1, dungeonFloor)
		Case 2 Return dungeonFloor + rarity + Rand(0, rarity)
		Case 3 Return dungeonFloor + (rarity*2) + Rand(0, rarity)
		Case 4 Return dungeonFloor + (rarity*4) + Rand(0, rarity)
	End Select
End Function


' Welche bonusstats bekommt das item ( +hp, +str etc. )
' 1 bonusHp, 2 bonusStr, 3 bonusVit, 4 bonusDmg, 5 bonusDef
Function DefineBonusStats(stat:Int[] Var, rarity:Int)
	For Local i:Int = 0 To rarity - 1
		stat[i] = Rand(1, 5)
	Next
End Function




' Wieviel Punkte bekommt jeder Bonusstat
		' 1 bonusHp, 2 bonusStr, 3 bonusVit, 4 bonusAtk, 5 bonusDef
Function AllocateBonusPoints(bonusPoints:Int, stat:Int[], bonusHp:Int Var, bonusStr:Int Var, bonusVit:Int Var, bonusAtk:Int Var, bonusDef:Int Var)
	Local tmpPoints:Int
	While bonusPoints >= 1
		For Local j:Int = 0 To 3
			Select stat[j]
				Case 1 'bonusHp
					tmpPoints = Rand(1, bonusPoints)
					bonusHp = bonusHp + tmpPoints 
					bonusPoints = bonusPoints - tmpPoints
					tmpPoints = 0
	
				Case 2 ' bonusStr
					tmpPoints = Rand(1, bonusPoints)
					bonusStr = bonusStr + tmpPoints
					bonusPoints = bonusPoints - tmpPoints
					tmpPoints = 0
	
				Case 3 ' bonusVit
					tmpPoints = Rand(1, bonusPoints)
					bonusVit = bonusVit + tmpPoints
					bonusPoints = bonusPoints - tmpPoints
					tmpPoints = 0
	
				Case 4 ' bonusAtk
					tmpPoints = Rand(1, bonusPoints)
					bonusAtk = bonusAtk + tmpPoints
					bonusPoints = bonusPoints - tmpPoints
					tmpPoints = 0
	
				Case 5 ' bonusDef
					tmpPoints = Rand(1, bonusPoints)
					bonusDef = bonusDef + tmpPoints
					bonusPoints = bonusPoints - tmpPoints
					tmpPoints = 0
			End Select
		Next
	Wend
End Function





Function AllocateItemName:Int(name:String Var, rarity:Int, kind:Byte, typ:Int, biggestItemBonus:String)
	
	If rarity = 2
		name = name + "Good "
	ElseIf rarity = 3
		name = name + "Rare "
	ElseIf rarity = 4
		name = name + "Legendary "
	End If
		
		
	
	Select kind
		
	' Waffe
		Case 0 name = name + "Sword"
		Case 1 name = name + "Axe"
		Case 2 name = name + "Dagger"
		Case 3 name = name + "Club"
		Case 4 name = name + "Mace"

	' Rüstung
		Case 5 name = name + "Iron Helmet"
		Case 6 name = name + "Leather Cap"
		Case 7 name = name + "Cloth Cap"
				
		Case 8 name = name + "Iron Gloves"
		Case 9 name = name + "Leather Gloves"
				
		Case 10 name = name + "Iron Armor"
		Case 11 name = name + "Leather Armor"
		Case 12 name = name + "Cloak Armor"
				
		Case 13 name = name + "Iron Boots"
		Case 14 name = name + "Leather Boots"

	' Ring
		Case 15 name = name + "Ring"
		Case 16 name = name + "Ring"
		
	' Gem
		Case 17 name = name + "Gem"
		
	End Select

	
	Select biggestItemBonus
		Case "hp"
			name = name + " of Life"
		Case "str"
			name = name + " of Strength"
		Case "vit"
			name = name + " of Vitality"
		Case "dmg"
			name = name + " of Attack"
		Case "def"
			name = name + " of Defense"
	End Select
End Function




Function ClassifyItemType:Byte(kind:Byte)
	If kind >= 0 And kind <= 4 Return 0
	If kind >= 5 And kind <= 7 Return 1
	If kind >= 8 And kind <= 9 Return 2
	If kind >= 10 And kind <= 12 Return 3
	If kind >= 13 And kind <= 14 Return 4
	If kind >= 15 And kind <= 16 Return 5
	If kind = 17 Return 6
End Function




Function CalcBiggestBonusOnItem:String(bonusHp:Int, bonusStr:Int, bonusVit:Int, bonusAtk:Int, bonusDef:Int)
	Local biggestBonus:String
		
	If bonusHp > bonusStr
		If bonusHp > bonusVit
			If bonusHp > bonusAtk
				If bonusHp > bonusDef
					biggestBonus = "hp"
				End If
			End If
		End If
	End If
	If bonusStr > bonusHp
		If bonusStr > bonusVit
			If bonusStr > bonusAtk
				If bonusStr > bonusDef
					biggestBonus = "str"
				End If
			End If
		End If
	End If
	If bonusVit > bonusHp
		If bonusVit > bonusStr
			If bonusVit > bonusAtk
				If bonusVit > bonusDef
					biggestBonus = "vit"
				End If
			End If
		End If
	End If
	If bonusAtk > bonusHp
		If bonusAtk > bonusStr
			If bonusAtk > bonusVit
				If bonusAtk > bonusDef
					biggestBonus = "dmg"
				End If
			End If
		End If
	End If
	If bonusDef > bonusHp
		If bonusDef > bonusStr
			If bonusDef > bonusVit
				If bonusDef > bonusAtk
					biggestBonus = "def"
				End If
			End If
		End If
	End If
	
	Return biggestBonus
End Function













' Nur zu Debugzwecken
Function PrintItems(rarity:Int)
	Local cnt:Int = 1
	
	Print " ------------------- "
	
	For Local i:TWearItem = EachIn TWearItem.List
		If i._rarity >= rarity
			Print "Item: " + cnt
			Print i._name
			Print "Itemtype.: " + i._typ
			Print "Framenr.: " + i._frame
			Print " Rarity: " + i._rarity
			Print "Bonus Hp: " + i._hp
			Print "Bonus Vit: " + i._vit
			Print "Bonus Str: " + i._str
			Print "Bonus Dmg: " + i._atk
			Print "Bonus Def: " + i._def
			Print "r: " + i._r + "  g: " + i._g + "  b: " + i._g
			Print " "
			
			cnt = cnt + 1
		End If
	Next
	
	Print " ------------------- "
	
End Function










