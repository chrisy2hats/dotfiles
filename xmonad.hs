------------------------------------------------------------
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

--Currently unused libraries
--import XMonad.Layout.Grid

-----------------------------------------------------------
--Main function
-----------------------------------------------------------

main = do
    xmonad $ defaults
        {
	 layoutHook = lessBorders OnlyFloat $ avoidStruts $ myLayout
        }

-----------------------------------------------------------
--Additional Hotkeys
-----------------------------------------------------------

--Find keys string equals in /usr/include/X11/XF86keysym.h or in /usr/include/X11/keysymdef.h
--0x0060 = grave accent

	 `additionalKeys` 	  
	[ --System Hotkeys`
	  ((mod1Mask, xK_g),withFocused $windows.XMonad.StackSet.sink),      --Remapping tile floating window to Alt g 
	  ((mod1Mask, xK_y),sendMessage Shrink),                             --Remapping Alt h to Alt y
	  ((mod1Mask ,xK_u),windows XMonad.StackSet.swapDown),               --Remapping Alt j to Alt u
	  ((mod1Mask,xK_o),sendMessage Expand),                              --Remapping Alt l to Alt o
	  ((mod1Mask ,xK_i),windows XMonad.StackSet.focusUp),                --Remapping Alt k to Alt 
	  ((mod1Mask .|. shiftMask ,xK_u),windows XMonad.StackSet.swapDown), --Remapping Alt shift j to Alt shift u
	  ((mod1Mask .|. shiftMask ,xK_i),windows XMonad.StackSet.swapUp),   --Remapping Alt shift k to Alt shift i
	 
	  --Lock and Screenshot hotkeys
	  ((mod4Mask .|. mod1Mask .|. controlMask, xK_p), spawn "sleep 0.1 && scrot -s'%Y-%m-%d:%H:%M:%S.png' -e 'mv $f /home/cflaptop/media/screenshots/'"), --Takes and saves screenshot
	  ((mod4Mask .|. controlMask, xK_p), spawn "scrot '%Y-%m-%d:%H:%M:%S.png' -e 'mv $f /home/cflaptop/media/screenshots/'"), --Takes and saves screenshot
	  ((mod4Mask .|. controlMask .|. shiftMask, xK_p), spawn "scrot -u '%Y-%m-%d:%H:%M:%S.png' -e 'mv $f /home/cflaptop/Pictures/screenshots/'"), --Takes and saves screenshot.Only the currently focused window
	  --Hotkeys for mouse actions
 	  ((mod4Mask, xK_x),spawn "xdotool click 1"),	--Left click
 	  ((mod4Mask, xK_c),spawn "xdotool click 2"),	--Middle click
 	  ((mod4Mask, xK_v),spawn "xdotool click 3"),	--Right click
	  ((mod1Mask, 0x0060),kill),

	  --Volume Control Hotkeys
	  ((mod4Mask .|. controlMask, xK_minus),spawn "amixer sset Master 10%- && amixer -c 1 sset Speaker 10%-"),
	  ((mod4Mask .|. controlMask, xK_equal),spawn "amixer sset Master 10%+ && amixer -c 1 sset Speaker 10%+"),
	  
	  --Brightness Control Keys
	  ((controlMask .|. shiftMask, xK_minus),spawn "brightnessChanger -d"),
	  ((controlMask .|. shiftMask,xK_equal),spawn "brightnessChanger -i"),
	  ((mod1Mask .|. shiftMask, xK_l), spawn "toggleScreen"),--Toggle between 0% and 100% brightness.Useful to type a password in plaintext in a public place
	  --Quick type hotkeys
	  ((mod4Mask,xK_o),spawn "quickType javaSystemOut"),
	  ((mod4Mask,xK_t),spawn "quickType twitch"),
	  ((mod4Mask, xK_n),spawn "quickType githubName"), 
	  ((mod1Mask, xK_s),spawn "vimSave"),
	  ((mod1Mask .|. shiftMask, xK_s),spawn "vimSaveAndGoToInsertMode"),
	  --Program Launcher Hotkeys
	  ((controlMask .|. mod1Mask, xK_f), spawn "firefox"),
	  ((controlMask .|. mod1Mask, xK_w), spawn "~/downloadedPrograms/waterfox/waterfox"),
	  ((controlMask .|. mod1Mask, xK_c), spawn "chromium"),
	  ((controlMask .|. shiftMask, xK_n), spawn "chromium --incognito"),--Allows new incognito tab to be launched without being focused on chromium
	  ((controlMask .|. mod1Mask, xK_s), spawn "spot"), --Custom commands that launches spotify firejailed and pavucontrol
	  ((controlMask .|. mod1Mask, xK_n), spawn "netbeansLauncher"),
	  --Alternate terminal hotkeys
	  ((controlMask .|. mod1Mask, xK_t), spawn "terminator"),
	  ((shiftMask .|. mod1Mask, xK_t), spawn "terminator -l IDE"),
	  ((controlMask .|. mod1Mask, xK_Return), spawn "terminator -l quadTerm"),
	  --System Control Hotkeys
	  ((mod1Mask, xK_t), spawn "tp"), --tp is a script to disable or enable my trackpad

	  --Spotify Control keys
	  --Play/Pause hotkey.
	  ((mod1Mask, xK_apostrophe),spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"), 	
	  --Next Track
	  ((mod1Mask ,xK_bracketright),spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next"),
	  --Previous Track
	  ((mod1Mask, xK_bracketleft),spawn "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous"),
	  --CheatSheet viewer
	  ((controlMask .|. mod1Mask,xK_v),spawn "feh ~/media/cheatSheets/vim.gif"),
	  ((controlMask .|. mod1Mask,xK_x),spawn "feh ~/media/cheatSheets/XMonad.png"),
	  ((controlMask .|. mod1Mask,xK_h),spawn "evince ~/media/cheatSheets/haskellCheatsheet.pdf")
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

-----------------------------------------------------------
--Settings Screen Layouts
-----------------------------------------------------------

myLayout = Full ||| tiled --  ||| Grid  --Grid is a horizontally split screen layout
  where
	tiled = Tall nmaster delta ratio
	nmaster = 1
	ratio = 1/2
	delta = 5/100

------------------------------------------------------------
--Setting defaults
------------------------------------------------------------

defaults = defaultConfig { 
	 terminal = "terminator -m -l quadTerm", 
	 startupHook = myStartupHook,
	 borderWidth = 0,
	 focusFollowsMouse = False,
	 manageHook = myManageHook,	
         modMask = mod1Mask  --mod1Mask = Left Alt mod3Mask = Right Alt. mod4Mask = Super/Windows key
  }

------------------------------------------------------------
--Commands run at startup
------------------------------------------------------------

--Commands run on startup."digit" indicates the workspace to run in
--Programs are moved to proper workspaces by the myManageHook below

myStartupHook = do 	
	spawnOn "1" "xset r rate 300 50" --Setting how fast presses are repeated when a key is held down.

	spawnOn "1" "ck" --Disables Caps Lock and maps Caps Lock to Esacpe

	spawnOn "1" "fb" --Custom command to apply my desktop background

	spawnOn "1" "yeahconsole"

	spawnOn "1" "usbDeviceListener"

	spawnOn "1" "/usr/lib/notification-daemon/notification-daemon"

------------------------------------------------------------
--Making programs spawn in certain workspaces
------------------------------------------------------------

myManageHook = composeAll
	[--Find the name of the window using xwininfo and clicking on the window
	--Working shifts
	className =? "Chromium"                --> doF (XMonad.StackSet.shift "2"),
	className =? "Firefox"                 --> doF (XMonad.StackSet.shift "2"),
	className =? "Evince"                  --> doF (XMonad.StackSet.shift "3"),
	className =? "Xpdf"                    --> doF (XMonad.StackSet.shift "3"),
	className =? "libreoffice-writer"      --> doF (XMonad.StackSet.shift "3"),
	className =? "libreoffice-calc"        --> doF (XMonad.StackSet.shift "3"),
	className =? "libreoffice-startcenter" --> doF (XMonad.StackSet.shift "3"),
	className =? "libreoffice-impress"     --> doF (XMonad.StackSet.shift "3"),
	className =? "jetbrains-idea-ce"       --> doF (XMonad.StackSet.shift "4"),
	className =? "Eclipse"                 --> doF (XMonad.StackSet.shift "4"),
	className =? "Atom"                    --> doF (XMonad.StackSet.shift "4"),
	className =? "Icecat"                  --> doF (XMonad.StackSet.shift "6"),
	className =? "Waterfox"                --> doF (XMonad.StackSet.shift "6"),
	--Working floats
	className =? "Gimp"                    --> doFloat,
	className =? "netbeans"                --> doFloat, --One of these 4 lines appears to make netbeans display properly
	className =? "Netbeans"                --> doFloat,
	appName   =? "netbeans"                --> doFloat,
	appName   =? "Netbeans"                --> doFloat,
	--Work In Progress
	appName   =? "libreoffice"             --> doF (XMonad.StackSet.shift "3"),
	className =? "LibreOffice Impress"     --> doF (XMonad.StackSet.shift "3"),
	className =? "Volume Control"          --> doF (XMonad.StackSet.shift "7") --pavucontrol
	]

------------------------------------------------------------
--EOF
------------------------------------------------------------
