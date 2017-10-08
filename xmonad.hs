------------------------------------------------------------
--Location: ~/.xmonad/xmonad.hs
--Written by github.com/chrisfoster4
------------------------------------------------------------

--Currently used libraries.
import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers --Used for isFullscreen doFullFloat
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Util.EZConfig--(additionalKeys) -- Needed for hotkeys.
import XMonad.Actions.SpawnOn
import qualified XMonad.StackSet as W
import XMonad.Hooks.SetWMName
-----------------------------------------------------------
--Settings Screen Layouts
-----------------------------------------------------------

myLayout = Full ||| tiled  ||| Grid 
  where
	tiled = Tall nmaster delta ratio
	nmaster = 1
	ratio = 1/2
	delta = 5/100
	
-----------------------------------------------------------
--Main function
-----------------------------------------------------------

main = do
    xmonad $ defaults
        {
	 layoutHook = lessBorders OnlyFloat $ avoidStruts $ myLayout
        }

-----------------------------------------------------------
--Personal Hotkeys
-----------------------------------------------------------

--Find keys string equals in /usr/include/X11/XF86keysym.h or in /usr/include/X11/keysymdef.h
--0x0060 = grave accent

	 `additionalKeys` 	  
	[ --System Hotkeys`
	  ((mod1Mask, xK_g),withFocused $windows.W.sink),--Remapping tile floating window to alt g 
	  ((mod1Mask, xK_y),sendMessage Shrink),--remapping alt h to alt y
	  ((mod1Mask ,xK_u),windows W.swapDown),--remapping alt j to alt u
	  ((mod1Mask,xK_o),sendMessage Expand),--remapping alt l to alt o
	  ((mod1Mask ,xK_i),windows W.focusUp),--remapping alt k to alt 
	  ((mod1Mask .|. shiftMask ,xK_u),windows W.swapDown), --remapping alt shift j to alt shift u
	  ((mod1Mask .|. shiftMask ,xK_i),windows W.swapUp), --remapping alt shift k to alt shift i
	  ((mod1Mask ,0x0060),withFocused hide), --Show desktop 
	 
	  --Lock and Screenshot
	  ((mod4Mask .|. controlMask, xK_p), spawn "scrot '%Y-%m-%d:%H:%M:%S.png' -e 'mv $f /home/cflaptop/media/screenshots/'"), --Takes and saves screenshot
	  ((mod4Mask .|. controlMask .|. shiftMask, xK_p), spawn "scrot -u '%Y-%m-%d:%H:%M:%S.png' -e 'mv $f /home/cflaptop/Pictures/screenshots/'"), --Takes and saves screenshot.Only the currently focused window
	  ((mod1Mask .|. controlMask, xK_l), spawn "myLockScript"), --Lock screen
	  ((mod1Mask .|. mod4Mask .|. controlMask, xK_l),spawn "pkill -kill -u `whoami`"),
	  --Hotkeys for mouse actions
 	  ((mod4Mask, xK_x),spawn "xdotool click 1"),	--left click
 	  ((mod4Mask, xK_c),spawn "xdotool click 2"),	--middle click
 	  ((mod4Mask, xK_v),spawn "xdotool click 3"),	--right click
	  --Remapping close from alt shift c to alt backspace and alt c
	  ((mod1Mask, xK_BackSpace),kill),
	  --((mod1Mask, xK_c),kill),

	  --Volume Control Hotkeys
	  ((mod1Mask, xK_m),spawn "amixer -q set Master toggle && amixer -c 0 sset Speaker toggle && amixer -c 1 sset Speaker toggle"),
	  ((mod4Mask .|. mod1Mask .|. controlMask, xK_minus),spawn "amixer sset Master 5%- && amixer -c 1 sset Speaker 5%-"),
	  ((mod4Mask .|. mod1Mask .|. controlMask, xK_equal),spawn "amixer sset Master 5%+ && amixer -c 1 sset Speaker 5%+"),
	  ((mod4Mask .|. controlMask, xK_minus),spawn "amixer sset Master 10%- && amixer -c 1 sset Speaker 10%-"),
	  ((mod4Mask .|. controlMask, xK_equal),spawn "amixer sset Master 10%+ && amixer -c 1 sset Speaker 10%+"),
	  
	  --Brightness Control Keys
	  ((controlMask .|. shiftMask, xK_minus),spawn "brightnessChanger -d"),
	  ((controlMask .|. shiftMask,xK_equal),spawn "brightnessChanger -i"),
	  ((mod1Mask .|. shiftMask, xK_l), spawn "toggleScreen"),--Toggle between 0% and 100% brightness.Useful to type a password in plaintext in a public place
	  --Quick type hotkeys
	  ((mod4Mask,xK_w),spawn "quickType while"),
	  ((mod4Mask .|. shiftMask,xK_p),spawn "quickType printStringHaskell"),
	  ((mod4Mask,xK_o),spawn "quickType javaSystemOut"),--broken
	  ((mod4Mask, xK_n),spawn "quickType githubName"), 
	  ((mod4Mask, xK_p),spawn "quickType print"), 
	  ((mod1Mask, xK_s),spawn "vimSave"),
	  ((mod1Mask .|. shiftMask, xK_s),spawn "vimSaveAndGoToInsertMode"),
	  --Program Launcher Hotkeys
	  ((controlMask .|. mod1Mask, xK_f), spawn "~/downloadedPrograms/firefox/firefox"),
	  ((controlMask .|. mod1Mask, xK_c), spawn "chromium"),
	  ((controlMask .|. mod1Mask .|. shiftMask, xK_c), spawn "chromium --incognito"),
	  ((controlMask .|. mod1Mask, xK_s), spawn "spot"), --Custom commands that launches spotify firejailed and pavucontrol
	  ((controlMask .|. mod1Mask, xK_z), spawn "filezilla"),
	  ((controlMask .|. mod1Mask, xK_w), spawn "libreoffice --writer"),
	  ((controlMask .|. mod1Mask, xK_i), spawn "libreoffice --impress"),
	  ((controlMask .|. mod1Mask, xK_e), spawn "eclipse"),
	  ((controlMask .|. mod1Mask .|. shiftMask, xK_p), spawn "pycharm"),
	  ((controlMask .|. mod1Mask, xK_m), spawn "icecat"),
	  --Alternate terminal hotkeys
	  ((controlMask .|. mod1Mask, xK_t), spawn "terminator"),
	  ((shiftMask .|. mod1Mask, xK_t), spawn "terminator -l IDE"),
	  ((controlMask .|. mod1Mask, xK_Return), spawn "terminator -l ct"),
	  --System Control Hotkeys
	  ((mod1Mask, xK_t), spawn "tp"), --tp is a custom command which disable or enables my trackpad

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
	  (mod1Mask, xK_l)
	  --(mod1Mask .|. shiftMask, xK_c) --Unmapping default close window hotkey
	  ]

------------------------------------------------------------
--Setting personal defaults
------------------------------------------------------------

defaults = defaultConfig{ 
	 terminal = "terminator -m -l ct", --Options = uxterm,xterm,tmux,terminator(terminator -l ct)
	 startupHook = myStartupHook,
  	 normalBorderColor = "#000000", --Default colour = #FF0000 red
	 borderWidth = 0,
	 focusFollowsMouse = False,
	 manageHook = myManageHook,	
         modMask = mod1Mask  --mod1Mask = left alt.mod3Mask = right alt. mod4Mask = super	

  }




------------------------------------------------------------
--Commands run at startup
------------------------------------------------------------

--Commands run on startup."[:digit:] indicates the workspace to run in"
--Programs are moved to proper workspaces by the myManageHook below

myStartupHook = do 	--System setup commands
	spawnOn "1" "setxkbmap -option 'ctrl:nocaps'" --Disabling caps lock
	spawnOn "1" "xmodmap -e 'keycode 66=Escape'" -- Mapping Caps Lock to ESC
	spawnOn "1" "fb" --Custom command to apply my desktop background

------------------------------------------------------------
--Making programs spawn in certain workspaces
------------------------------------------------------------

myManageHook = composeAll
	[--Find the name of the window using xprop -name "expectedName"
	--Currently working
	className =? "Gimp" --> doFloat,
	className =? "Chromium" --> doF (W.shift "2"),
	className =? "Firefox" --> doF (W.shift "2"),
	className =? "Icecat" --> doF (W.shift "6"),
	className =? "Evince" --> doF (W.shift "3"),
	className =? "Xpdf" --> doF (W.shift "3"),
	className =? "libreoffice-writer" --> doF (W.shift "3"),
	className =? "libreoffice-calc" --> doF (W.shift "3"),
	className =? "libreoffice-startcenter" --> doF (W.shift "3"),
	className =? "libreoffice-impress" --> doF (W.shift "3"),
	className =? "jetbrains-idea-ce" --> doF (W.shift "3"),
	className =? "pavucontrol" --> doF (W.shift "8"),
	--WIP
	--className =? "netbeans" --> doF (W.shift "4"),
	--className =? "Netbeans" --> doF (W.shift "4"),
	className =? "eclipse" --> doF (W.shift "4"),
	className =? "Eclipse" --> doF (W.shift "4"),
	className =? "/bin/bash" --> doF (W.shift "5"),
	className =? "spotify" --> doF (W.shift "7"),
	className =? "Spotify" --> doF (W.shift "7"),
	className =? "spotify" --> doF (W.shift "7"),
	className =? "Spotify" --> doF (W.shift "7"),
	appName =? "spotify" --> doF (W.shift "7"),
	appName =? "Spotify" --> doF (W.shift "7"),
	appName =? "spotify" --> doF (W.shift "7"),
	appName =? "Spotify" --> doF (W.shift "7"),
	className =? "virt-manager" --> doF (W.shift "5"),
	className =? "qemu" --> doF (W.shift "5"),
	className =? "IDE" --> doF (W.shift "4")
	--Doesn't work
	--className =? "terminator" --> doF (W.shift "1:terminal"),--This works however a if terminator utilises the -l flag it looks borked.
	--className =? "terminator" --> doF (W.shift "1:terminal"),--This works however a if terminator utilises the -l flag it looks borked.
	--className =? "tor" --> doF (W.shift "2"),
	--appName =? "tor" --> doF (W.shift "2"),
	--className =? "tor-browser" --> doF (W.shift "2"),
	--appName =? "tor-browser" --> doF (W.shift "2"),


	]

------------------------------------------------------------
--EOF
------------------------------------------------------------
