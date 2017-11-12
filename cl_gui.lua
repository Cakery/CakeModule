CreateClientConVar("cake_nlr_disable",1,true,false)

concommand.Add( "cake_nlr", function( ply, cmd, args, str )
if cvars.Number("cake_nlr_disable")!=1 then return end

local Form = vgui.Create( "DFrame" )
Form:SetPos( ScrW()/2-180,ScrH()/2 -20) -- Position form on your monitor
Form:SetSize( 380, 200 ) -- Size form
Form:SetTitle( "NLR" ) -- Form set name
Form:SetVisible( true ) -- Form rendered ( true or false )
Form:SetDraggable( false ) -- Form draggable
Form:ShowCloseButton( false ) -- Show buttons panel

Form:MakePopup()

local Panel = vgui.Create( "DPanel",Form )
Panel:SetPos( 10, 30 ) -- Set the position of the panel
Panel:SetSize( 360, 140 ) -- Set the size of the pan


local DLabel=vgui.Create("DLabel",Panel)
DLabel:SetPos( 80, 40 )
DLabel:SetText("You have died! You can not return to where\n      you just died for at least 5 minutes.\n\n(You have also lost a max of $"..GAMEMODE.Config.deathfee.." from your wallet)")
DLabel:SetTextColor(Color(255,0,0,255))
DLabel:SizeToContents( ) 
DLabel:SetAutoStretchVertical( true) 
--DLabel:SetHighlight(true)
DLabel:SetWrap( true ) 



local DermaButton = vgui.Create( "DButton" )    // Create the button
DermaButton:SetParent( Form )             // Set its parent to the panel

DermaButton:SetText( "I have read and Understood this " )                 // Set the text on the button
DermaButton:SetPos( 80, 170 )                    // Set the position on the frame
DermaButton:SetSize( 250, 30 )                  // Set the size
DermaButton.DoClick = function()              // A custom function run when clicked ( note: it a . instead of : )
    Form:Close()            // Run the console command "say hi" when you click it ( command, args )
end

--if LocalPlayer():GetUserGroup()=="superadmin" then
local MenuBar = vgui.Create( "DMenuBar", Form)
MenuBar:DockMargin( -3, -6, -3, 0 ) --corrects MenuBar pos

local M1 = MenuBar:AddMenu( "Options" )
M1:AddOption("Do not show this again",function() LocalPlayer():ConCommand("cake_nlr_disable 0")  end):SetIcon( "icon16/page_white_go.png" )
--end
end )

concommand.Add("cake_rpname",function(ply)
local Form = vgui.Create( "DFrame" )
Form:SetPos( ScrW()/2-180,ScrH()/2 -20) -- Position form on your monitor
Form:SetSize( 380, 200 ) -- Size form
Form:SetTitle( "Please set a RP name!" ) -- Form set name
Form:SetVisible( true ) -- Form rendered ( true or false )
Form:SetDraggable( false ) -- Form draggable
Form:ShowCloseButton( false ) -- Show buttons panel
Form:SetBackgroundBlur(true)

Form:MakePopup()


local FirstName = vgui.Create( "DTextEntry", Form )	-- create the form as a child of frame
FirstName:SetPos( 77, 50 )
FirstName:SetSize( 225, 20 )
FirstName:SetText( "First Name..." )


local LastName = vgui.Create( "DTextEntry", Form )	-- create the form as a child of frame
LastName:SetPos( 77, 80 )
LastName:SetSize( 225, 20 )
LastName:SetText( "Last Name..." )

local DermaButton = vgui.Create( "DButton" )    // Create the button
DermaButton:SetParent( Form )             // Set its parent to the panel

DermaButton:SetText( "Set RP name" )                 // Set the text on the button
DermaButton:SetPos( 120, 150 )                    // Set the position on the frame
DermaButton:SetSize( 150, 30 )                  // Set the size
DermaButton.DoClick = function()              // A custom function run when clicked ( note: it a . instead of : )
	LocalPlayer():ConCommand("say /rpname "..FirstName:GetValue().." "..LastName:GetValue())
	timer.Simple(.1,function()
	if LocalPlayer():Nick()!=LocalPlayer():SteamName() then
	
			Form:Close()            // Run the console command "say hi" when you click it ( command, args )
		end
	end)
end

local IDontKnow=vgui.Create("DButton")
IDontKnow:SetParent( Form )       
IDontKnow:SetPos( 110, 110 )
IDontKnow:SetSize( 170, 30 )   
IDontKnow:SetText( "I don't know what this means!" ) 
IDontKnow.DoClick=function()
--Add what ever URL you want here
gui.OpenURL("")
end
end)

local function Test(Pan)
Pan:SetText("")
end

--hook.Add("OnTextEntryGetFocus","gegdsfergbr",Test)