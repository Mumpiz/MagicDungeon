



Graphics 640, 480
SetBlend ALPHABLEND





' Tileset
	Incbin "tileset.png"
	Global Img_Tileset:TImage = LoadAnimImage("incbin::tileset.png", 32, 32, 0, 9)
	
' Player
	Incbin "Player.png"
	Global Img_Player:TImage = LoadImage("incbin::Player.png")

' Lichtradius
	Incbin "LightRadius.png"
	Global Img_LightRadius:TImage = LoadImage("incbin::LightRadius.png")

' Panel
	Incbin "panel.png"
	Global Img_Panel:TImage = LoadImage("incbin::panel.png")
	
' Lootbox
	Incbin "lootbox.png"
	Global Img_Lootbox:TImage = LoadImage("incbin::lootbox.png")
	
' WearItems
	Incbin "items1.png"
	Global Img_WearItems:TImage = LoadAnimImage("incbin::items1.png", 32, 32, 0, 18)
	
' StackItems
	Incbin "items2.png"
	Global Img_StackItems:TImage = LoadAnimImage("incbin::items2.png", 32, 32, 0, 9)

' Font
	Incbin "KeltCapsFreehand.ttf"
	Global Fnt_Kelt:TImageFont = LoadImageFont("Incbin::KeltCapsFreehand.ttf", 15)
	SetImageFont(Fnt_Kelt)
	



Include "TTile.bmx"
SeedRnd(MilliSecs())