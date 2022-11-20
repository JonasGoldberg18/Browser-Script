#command to get coordinates: "[System.Windows.Forms.Cursor]::Position"
#command to start porgram: "Powershell.exe -ExecutionPolicy Unrestricted -File <File Path of script\Windows_Brave_V1.ps1>"

#Coordinates of Brave Browser Icon on taskbar
$BraveIcon_X = 515
$BraveIcon_Y = 1060

#Coordinates of New Tab Button 
$BraveNTab_X = 272
$BraveNTab_Y = 21

#Coordinates of Close Tab Button
$BraveCTab_X = 229
$BraveCTab_Y = 12

#Coordinates of Bing Bookmark
$BingBookmark_X = 44
$BingBookmark_Y = 83

#Coordinates of up arrow to bring up articles
$arrow_x = 261
$arrow_y = 1004

#Coordinates of First Bing Article
$BingArticle1_X = 432
$BingArticle1_Y = 828

#Coordinates of Second Bing Article
$BingArticle2_X = 407
$BingArticle2_Y = 365

#Coordinates of Bing Search Bar
$BingSBar_X = 511
$BingSBar_Y = 115

#Coordinates of Any White space in Bing Window (Right side) 
#FYI: during the script it will sit at this location for ~2 mins as its only 5 ads per hour
$WhiteSpace_X = 88
$WhiteSpace_Y = 520

#Coordinates to X' out of the browser
$XOut_X = 1900
$XOut_Y = 11

#coordinates for clear browsing data 
$ClearBrowsingData_X= 54
$ClearBrowsingData_Y= 254

#coordinates for clear data
$ClearData_X= 1030
$ClearData_Y= 743

#coordinates for brave rewards notification thingy
$Notification_X= 1736
$Notification_Y= 947

#coordinates to close second tab if opened 
$Tab2_X = 472
$Tab2_Y = 16



################################################################################################################################
[Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | out-null
function Click-MouseButton
{
param(
[string]$Button, 
[switch]$help)

    $signature=@' 
      [DllImport("user32.dll",CharSet=CharSet.Auto, CallingConvention=CallingConvention.StdCall)]
      public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
'@ 

    $SendMouseClick = Add-Type -memberDefinition $signature -name "Win32MouseEventNew" -namespace Win32Functions -passThru 
    if($Button -eq "left")
    {
        $SendMouseClick::mouse_event(0x00000002, 0, 0, 0, 0);
        $SendMouseClick::mouse_event(0x00000004, 0, 0, 0, 0);
    }
    if($Button -eq "right")
    {
        $SendMouseClick::mouse_event(0x00000008, 0, 0, 0, 0);
        $SendMouseClick::mouse_event(0x00000010, 0, 0, 0, 0);
    }
    if($Button -eq "middle")
    {
        $SendMouseClick::mouse_event(0x00000020, 0, 0, 0, 0);
        $SendMouseClick::mouse_event(0x00000040, 0, 0, 0, 0);
    }
}

$i=0
$x=8
$o = 0
$c = 0

While ($i -le 200) {
	#Sleep Before Starting
	sleep 5

	#increase i
	$i++

	#Move to Brave Icon Coordinates and left click to launch
	[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($BraveIcon_X,$BraveIcon_Y)
	Click-MouseButton -Button left
sleep 3



###########I might not to write the condition here that i%x does not equal 0. This would be written as an if statement. 
	#Sleep 15 seconds to refresh rewards balance
	sleep 15

	#Click New Tab
	[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($BraveNTab_X,$BraveNTab_Y)
	sleep 1
	Click-MouseButton -Button left

	sleep 8

	#Close Tab
	[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($BraveCTab_X,$BraveCTab_Y)
	sleep 1
	Click-MouseButton -Button left


	sleep 8

	#Click Bing Bookmark
	[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($BingBookmark_X,$BingBookmark_Y)
	Click-MouseButton -Button left


	sleep 8

	#Click Bing Article 1
	[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($BingArticle1_X,$BingArticle1_Y)
	Click-MouseButton -Button left

	sleep 8

	#click up arrow
	[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($arrow_x,$arrow_y)
	Click-MouseButton -Button left

	sleep 8

	#Click Bing Article 2
	[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($BingArticle2_X,$BingArticle2_Y)
	Click-MouseButton -Button left

	sleep 8

	#Click Bing Search Bar
	[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($BingSBar_X,$BingSBar_Y)
	Click-MouseButton -Button left

	sleep 5

	#Type in search bar
	$wshell = New-Object -ComObject wscript.shell;
	$wshell.AppActivate('Brave')
	Sleep 3
	$wshell.SendKeys($i)
	sleep 3
	$wshell.SendKeys('~')

	Sleep 5

	#notification click and then close the tab
	[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($Notification_X,$Notification_Y)
	sleep 1
	Click-MouseButton -Button left
	sleep 2
	[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($Tab2_X,$Tab2_Y)
	sleep 1
	Click-MouseButton -Button left

	#Set Random Timer (30-150 seconds)
	$Timer = Get-Random -Maximum 150 -Minimum 30

	#Go to White-space
	[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($WhiteSpace_X,$WhiteSpace_Y)

	#Sleep Counter (Random)
	Sleep $Timer

	#Open New Tab / Show balance before closing broswer window
	[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($BraveNTab_X,$BraveNTab_Y)
	sleep 1
	Click-MouseButton -Button left

	sleep 8



if( $i % $x -eq 0) 
{
	$wshell = New-Object -ComObject wscript.shell;
	$wshell.AppActivate('Brave')
	Sleep 3
	$wshell.SendKeys("^h")
	sleep 3
	
#coordinates for clicking clear browsing data
[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($ClearBrowsingData_X,$ClearBrowsingData_Y)
sleep 3
Click-MouseButton -Button left

sleep 5

#click clear browsing data
[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($ClearData_X,$ClearData_Y)
sleep 2
Click-MouseButton -Button left
sleep 5
#Close Tab
	[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($BraveCTab_X,$BraveCTab_Y)
	sleep 1
	Click-MouseButton -Button left


	sleep 8

#Close Tab
	[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($BraveCTab_X,$BraveCTab_Y)
	sleep 1
	Click-MouseButton -Button left


	sleep 8



}

#click all the notifications 
for ($o = 0 ; $o -le 4 ; $o++)
{

#notification click 
	[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($Notification_X,$Notification_Y)
	sleep 1
	Click-MouseButton -Button left
	sleep 2
}


	#Close Browser
	for ($c = 0 ; $c -le 5 ; $c++)
{

#Close Tab
	[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($BraveCTab_X,$BraveCTab_Y)
	sleep 1
	Click-MouseButton -Button left
sleep 2
}

	#State Cycle Completed - Instructions how to terminate script
	echo "Cycle Complete : $i - Script continues forever, press [Ctrl + C] in this window to stop it"
}
 