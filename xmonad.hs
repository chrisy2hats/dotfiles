-----------------------------------------------------------
--Location: ~/.xmonad/xmonad.hs
------------------------------------------------------------

--Currently used libraries
import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig(additionalKeys,removeKeys) 
import XMonad.Actions.SpawnOn
import qualified XMonad.StackSet 
import XMonad.Hooks.SetWMName

-----------------------------------------------------------
--Main function
-----------------------------------------------------------

--Xorg keycodes according to /usr/include/X11/XF86keysym.h
brightnessDown   = 0x1008FF03 
brightnessUp     = 0x1008FF02
audioLowerVolume = 0x1008ff11
audioRaiseVolume = 0x1008ff13
audioMute	     = 0x1008ff12
  
main = do
    xmonad $ defaults
        {
	 layoutHook = lessBorders OnlyFloat $ avoidStruts $ myLayout
        }


-----------------------------------------------------------
--Additional Hotkeys
-----------------------------------------------------------
--Find keys string equals in /usr/include/X11/XF86keysym.h or in /usr/include/X11/keysymdef.h
--0x0060 = grave accent(Key left of "1")

	 `additionalKeys` 	  
	[ --System Hotkeys`
	  ((mod1Mask, xK_g),withFocused $ windows.XMonad.StackSet.sink),      --Remapping tile floating window to Alt g 
	  ((mod1Mask, xK_y),sendMessage Shrink),                             --Remapping Alt h to Alt y
	  ((mod1Mask ,xK_u),windows XMonad.StackSet.swapDown),               --Remapping Alt j to Alt u
	  ((mod1Mask,xK_o),sendMessage Expand),                              --Remapping Alt l to Alt o
	  ((mod1Mask ,xK_i),windows XMonad.StackSet.focusUp),                --Remapping Alt k to Alt 
	  ((mod1Mask .|. shiftMask ,xK_u),windows XMonad.StackSet.swapDown), --Remapping Alt shift j to Alt shift u
	  ((mod1Mask .|. shiftMask ,xK_i),windows XMonad.StackSet.swapUp),   --Remapping Alt shift k to Alt shift i
	  ((controlMask .|. mod1Mask ,xK_l),spawn "xtrlock"),  
	 
	  --Lock and Screenshot hotkeys
	  ((mod1Mask,xK_Print), spawn "sleep 0.1 && scrot -s '/tmp/screenshot.png' && xclip -selection clipboard -t image/png -i /tmp/screenshot.png && notify-send -t 1000 'Screenshot' 'Screenshot taken'"), --Alt+printscreen to take an area
	  ((0,xK_Print), spawn "sleep 0.1 && scrot '/tmp/screenshot.png' && xclip -selection clipboard -t image/png -i /tmp/screenshot.png && notify-send -t 1000 'Screenshot' 'Screenshot taken'"), --Printscreen to take screenshot of all monitors
 	  ((mod4Mask, xK_c),spawn "xdotool click 2"),	--Middle click
	  ((mod1Mask, 0x0060),kill),
      ((mod1Mask,xK_F1),spawn "notify-send -t 2000 'Current time' `date '+%R'`"),
      ((mod1Mask,xK_F2),spawn "bs -n"), --Outputs battery percentage in a notifcation


	  ((mod4Mask .|. controlMask, xK_minus),spawn "amixer sset Master 10%- && amixer -c 1 sset Speaker 10%-"),
	  ((mod4Mask .|. controlMask, xK_equal),spawn "amixer sset Master 10%+ && amixer -c 1 sset Speaker 10%+"),
	  ((controlMask .|. shiftMask, xK_minus),spawn "brightnessChanger -d"),
	  ((controlMask .|. shiftMask,xK_equal),spawn "brightnessChanger -i"),
	  
      --Binding my function keys to shell commands
	  ((0, brightnessUp),spawn "brightnessChanger -i"), --0x1
	  ((0, brightnessDown),spawn "brightnessChanger -d"),
	  ((0, audioLowerVolume),spawn "amixer sset Master 10%- && amixer -c 1 sset Speaker 10%-"),
	  ((0, audioRaiseVolume),spawn "amixer sset Master 10%+ && amixer -c 1 sset Speaker 10%+"),
	  ((0, audioMute),spawn "amixer sset Master 0% && amixer -c 1 sset Speaker 0%"),
    
	  ((mod1Mask .|. shiftMask, xK_l), spawn "toggleScreen"),--Toggle between 0% and 100% brightness
	  --Quick type hotkeys
	  ((mod4Mask,xK_t),spawn "quickType twitch"),
	  ((mod4Mask, xK_n),spawn "quickType githubName"), 


	  ((mod1Mask, xK_s),spawn "vimSave"),
	  ((mod1Mask .|. shiftMask, xK_s),spawn "vimSaveAndGoToInsertMode"),
	  --Program Launcher Hotkeys
	  ((controlMask .|. mod1Mask, xK_f), spawn "firefox"),
	  ((controlMask .|. mod1Mask, xK_w), spawn "waterfox"),
	  ((controlMask .|. mod1Mask, xK_c), spawn "chromium"),
	  ((controlMask .|. shiftMask, xK_n), spawn "chromium --incognito"),--Allows new incognito tab to be launched without being focused on chromium
	  ((controlMask .|. mod1Mask, xK_s), spawn "spot"), --Custom commands that launches spotify firejailed and pavucontrol
	  --System Control Hotkeys
	  ((mod1Mask, xK_t), spawn "tp"), --tp is a script to disable or enable my trackpad

	  --Spotify Control keys
	  --Play/Pause hotkey.
	  ((mod1Mask, xK_apostrophe),spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"), 	
	  --Next Track
	  ((mod1Mask ,xK_bracketright),spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next"),
	  --Previous Track
	  ((mod1Mask, xK_bracketleft),spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous")
	  ]

------------------------------------------------------------
--Removing some default hotkeys
------------------------------------------------------------

	  `removeKeys`
	  [--Conflicting with vim style navigation for terminator
	  (mod1Mask, xK_h),
	  (mod1Mask, xK_j),
	  (mod1Mask, xK_k),
	  (mod1Mask, xK_l),
	  (mod1Mask .|. shiftMask, xK_slash), --Disabling hotkey help screen
	  (mod1Mask .|. shiftMask, xK_c) --Unmapping default close window hotkey
	  ]

----------------------------------------------------------------
--Setting defaults
------------------------------------------------------------

defaults = defaultConfig { 
	 terminal = "terminator",
	 startupHook = myStartupHook,
	 borderWidth = 0,
	 focusFollowsMouse = False,
	 manageHook = myManageHook,	
     modMask = mod1Mask  --mod1Mask = Left Alt mod3Mask = Right Alt. mod4Mask = Super/Windows key
  }

-----------------------------------------------------------
--Settings Screen Layouts
-----------------------------------------------------------

myLayout = Full ||| tiled --  ||| Grid  --Grid is a horizontally split screen layout

tiled = Tall nmaster delta ratio
  where
    nmaster = 1
    ratio   = 1/2
    delta   = 5/100

------------------------------------------------------------
--Commands run at startup
------------------------------------------------------------

--Commands run on startup."digit" indicates the workspace to run in
--Programs are moved to proper workspaces by the myManageHook below

myStartupHook = do 	
-- xset r rate 300 50
	spawnOn "1" "xset r rate 200 50" --Setting how fast presses are repeated when a key is held down.

	spawnOn "1" "xset mouse 100 15" --Setting acceleration and threshold for pointing devices

	spawnOn "1" "ck" --Disables Caps Lock and maps Caps Lock to Esacpe

	spawnOn "1" "fb" --Custom command to apply my desktop background

	spawnOn "1" "yeahconsole"

	spawnOn "1" "bluetooth off" --Command given by tlp.deb

--	spawnOn "1" "comptonStart"

	spawnOn "1" "disableScreenSleep" 

	spawnOn "1" "redshift && echo running > ~/bin/controlFiles/redshiftControlFile" 

	spawnOn "1" "monitorAutoConnector" 

	spawnOn "1" "usbDeviceListener"

	--spawnOn "1" "/usr/lib/notification-daemon/notification-daemon"



------------------------------------------------------------
--Making programs spawn in certain workspaces
------------------------------------------------------------

myManageHook = composeAll
	[--Find the name of the window using xwininfo and clicking on the window
    --Find window title using `xwininfo` then click on the window
    --Find class name using `xprop | grep WM_CLASS` then click on the window
	--Working shifts
	className =? "Chromium"                --> doF (XMonad.StackSet.shift "2"),
	className =? "Firefox"                 --> doF (XMonad.StackSet.shift "2"),
	className =? "Evince"                  --> doF (XMonad.StackSet.shift "3"),
	className =? "libreoffice-writer"      --> doF (XMonad.StackSet.shift "3"),
	className =? "libreoffice-calc"        --> doF (XMonad.StackSet.shift "3"),
	className =? "libreoffice-startcenter" --> doF (XMonad.StackSet.shift "3"),
	className =? "libreoffice-impress"     --> doF (XMonad.StackSet.shift "3"),
	className =? "jetbrains-idea-ce"       --> doF (XMonad.StackSet.shift "4"),
	className =? "Eclipse "                --> doF (XMonad.StackSet.shift "4"),
	className =? "Atom"                    --> doF (XMonad.StackSet.shift "4"),
	className =? "Waterfox"                --> doF (XMonad.StackSet.shift "6"),
	appName   =? "virt-manager"            --> doF (XMonad.StackSet.shift "5"),
	--Working floats
	className =? "Gimp"                    --> doFloat,
	className =? "netbeans"                --> doFloat, --One of these 4 lines appears to make netbeans display properly
	--className =? "Netbeans IDE 8.2"        --> doFloat,
	className =? "Netbeans IDE 8.2"        --> doF (XMonad.StackSet.shift "4"),
	appName   =? "Netbeans IDE 8.2"        --> doF (XMonad.StackSet.shift "4"),
	--Work In Progress
	className =? "jetbrains-studio"        --> doF (XMonad.StackSet.shift "4"),
	appName =? "jetbrains-studio"        --> doF (XMonad.StackSet.shift "4"),
    appName   =? "Session - Shutter"       --> doF (XMonad.StackSet.shift "8"),
	appName   =? "libreoffice"             --> doF (XMonad.StackSet.shift "3"),
	className =? "LibreOffice Impress"     --> doF (XMonad.StackSet.shift "3"),
	className =? "jetbrains-clion"       --> doF (XMonad.StackSet.shift "4"),
	className =? "Volume Control"          --> doF (XMonad.StackSet.shift "7") --pavucontrol    
	]

------------------------------------------------------------
--EOF
------------------------------------------------------------
