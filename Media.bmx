



Graphics 640, 480
SetBlend ALPHABLEND





' Tileset
	Incbin "assets/img/tileset.png"
	Global Img_Tileset:TImage = LoadAnimImage("incbin::assets/img/tileset.png", 32, 32, 0, 9)
	
' Player
	Incbin "assets/img/Player.png"
	Global Img_Player:TImage = LoadImage("incbin::assets/img/Player.png")

' Lichtradius
	Incbin "assets/img/LightRadius.png"
	Global Img_LightRadius:TImage = LoadImage("incbin::assets/img/LightRadius.png")

' Panel
	Incbin "assets/img/panel.png"
	Global Img_Panel:TImage = LoadImage("incbin::assets/img/panel.png")
	
' Lootbox
	Incbin "assets/img/lootbox.png"
	Global Img_Lootbox:TImage = LoadImage("incbin::assets/img/lootbox.png")
	
' WearItems
	Incbin "assets/img/items1.png"
	Global Img_WearItems:TImage = LoadAnimImage("incbin::assets/img/items1.png", 32, 32, 0, 18)
	
' StackItems
	Incbin "assets/img/items2.png"
	Global Img_StackItems:TImage = LoadAnimImage("incbin::assets/img/items2.png", 32, 32, 0, 9)

' Font
	Incbin "assets/font/KeltCapsFreehand.ttf"
	Global Fnt_Kelt:TImageFont = LoadImageFont("Incbin::assets/font/KeltCapsFreehand.ttf", 15)
	SetImageFont(Fnt_Kelt)
	



Include "TTile.bmx"
SeedRnd(MilliSecs())