SuperStrict
Include "Media.bmx"
Include "Keys.bmx"
Include "TPlayer.bmx"
Include "TWearItem.bmx"
Include "TInventorySlot.bmx"
Include "TEquipSlot.bmx"
Include "TMouseSlot.bmx"
Include "TLootSlot.bmx"
Include "TStackItem.bmx"





GenerateMap()
CreateInventory()
CreateEquipSlots()
TLootBox.Create(250,150)

TMouseSlot.Create()
TTmpSlot.Create()

TPlayer.Create(100, 0, 0)

Local timer:TTimer = CreateTimer(30)
Repeat
	Cls
	SeedRnd(MilliSecs())
	
	

	DrawMap()

	

	UpdateInput()
	RenderPlayer()
	
	DrawImage Img_Panel, 480, 0
	
	
	
	UpdateInventorySlots(MH1, MH2)
	UpdateEquipSlots(MH1, MH2)
	RenderLootBox(MH1, MH2)
	UpdateMouseSlot(MH1, MH2)
	

	
	DrawText MouseX() + " | " + MouseY(), 0, 0
	DrawText TWearItem.List.Count(), 0, 20
	DrawText TPlayer(TPlayer.List.First())._gold + "   " + TPlayer(TPlayer.List.First())._potions, 0, 40
	
	Flip()

	WaitTimer(timer)

	If KeyHit(KEY_ESCAPE)
		TLootBox.GenerateItems = True
	End If
	
	
Until AppTerminate()

'DrawText MouseX() + " | " + MouseY(), 0, 0





