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

--Find keys string equals in /usr/include/X11/XF86keysym.h

	 `additionalKeys` 	  
	[ --System Hotkeys`
	  ((mod1Mask, xK_g),withFocused $windows.W.sink),--Remapping tile floating window to alt g 
	  ((mod4Mask, xK_p), spawn "scrot '%Y-%m-%d:%H:%M:%S.png' -e 'mv $f ~/Pictures/Screenshots/'"), --Takes and saves screenshot
	  ((mod1Mask .|. controlMask, xK_l), spawn "myLockScript"), --Lock screen
	  ((mod1Mask .|. mod4Mask .|. controlMask, xK_l),spawn "pkill -kill -u `whoami`"),
 	  ((mod4Mask, xK_x),spawn "xdotool click 1"),	--left click
 	  ((mod4Mask, xK_c),spawn "xdotool click 2"),	--middle click
 	  ((mod4Mask, xK_v),spawn "xdotool click 3"),	--right click
	 
	  --Volume Control Hotkeys
	  ((mod1Mask, xK_m),spawn "amixer -q set Master toggle && amixer -c 0 sset Speaker toggle"),
	  ((mod4Mask .|. mod1Mask .|. controlMask, xK_minus),spawn "amixer sset Master 10%- && amixer -c 1 sset Speaker 5%-"),
	  ((mod4Mask .|. mod1Mask .|. controlMask, xK_equal),spawn "amixer sset Master 10%- && amixer -c 1 sset Speaker 5%+"),
	  ((mod4Mask .|. controlMask, xK_minus),spawn "amixer sset Master 10%+ && amixer -c 1 sset Speaker 10%-"),
	  ((mod4Mask .|. controlMask, xK_equal),spawn "amixer sset Master 10%+ && amixer -c 1 sset Speaker 10%+"),
	  
	  --Brightness Control Keys
	  ((controlMask .|. shiftMask, xK_minus),spawn "xbacklight -time 0 -dec 10%"),
	  ((controlMask .|. shiftMask,xK_equal),spawn "xbacklight -time 0 -inc 10%"),
	  ((mod1Mask , xK_s), spawn "toggleScreen"),--Toggle between 0% and 100% brightness.Useful to type a password in plaintext in a public place
	  --Quick type hotkeys
	  ((mod1Mask, xK_f),spawn "sleep 0.1 && xdotool key up alt && xdotool key up ctrl && xdotool type --delay 0 https://github.com/chrisfoster4/"), 
	  --Program Launcher Hotkeys
	  ((controlMask .|. mod1Mask, xK_f), spawn "firefox"),
	  ((controlMask .|. mod1Mask, xK_c), spawn "chromium"),
	  ((controlMask .|. mod1Mask, xK_s), spawn "spotify"),
	  ((controlMask .|. mod1Mask, xK_a), spawn "atom"),
	  ((controlMask .|. mod1Mask, xK_z), spawn "filezilla"),
	  ((controlMask .|. mod1Mask, xK_w), spawn "libreoffice --writer"),
	  ((controlMask .|. mod1Mask, xK_i), spawn "libreoffice --impress"),
	  ((controlMask .|. mod1Mask, xK_b), spawn "bluej"),
	  ((controlMask .|. mod1Mask, xK_p), spawn "pyzo"),
	  ((controlMask .|. mod1Mask, xK_m), spawn "icecat"),
	  --Alternate terminal hotkeys
	  ((controlMask .|. mod1Mask, xK_t), spawn "terminator"),
	  ((shiftMask .|. mod1Mask, xK_t), spawn "terminator -l ct"),
	  ((controlMask .|. mod1Mask, xK_Return), spawn "terminator -l ct"),
	  --System Control Hotkeys
	  ((mod1Mask, xK_t), spawn "tp"), --tp is a custom command which disable or enables my trackpad

	  --CheatSheet viewer
	  ((controlMask .|. mod1Mask,xK_v),spawn "eog ~/Pictures/CheatSheets/vim.gif"),
	  ((controlMask .|. mod1Mask,xK_x),spawn "eog ~/Pictures/CheatSheets/XMonad.png")
	  ]
--	  --Switch to workspace 10
--	((myModMask, key), (windows $ W.greedyView ws)) | (key,ws) <- myExtraWorkspaces,
--      ((myModMask .|. shiftMask, key), (windows $ W.shift ws)) | (key,ws) <- myExtraWorkspaces
--      ]
------------------------------------------------------------
--Setting personal defaults
------------------------------------------------------------

defaults = defaultConfig{ 
	 terminal = "terminator -l ct", --Other options = uxterm,xterm,tmux
	 startupHook = myStartupHook,
  	 normalBorderColor = "#000000", --Default colour = #FF0000 red
	 borderWidth = 0,
	 focusFollowsMouse = False,
	 manageHook = myManageHook,	
	 workspaces = myWorkspaces,
         modMask = mod1Mask  --mod1Mask = left alt.mod3Mask = right alt. mod4Mask = super	

  }

------------------------------------------------------------
--Naming my workspaces
------------------------------------------------------------


myWorkspaces = ["1:terminal","2:browsers","3:misc0","4:misc1","5:misc2","6:messaging","7:spotify","8:htop","9:misc5"]
--myExtraWorkspaces = [(xK_0),"0"]



------------------------------------------------------------
--Commands run at startup
------------------------------------------------------------

myStartupHook = do --Commands run on startup."[:digit:] indicates the workspace to run in"
	--Programs are moved to proper workspaces by the myManageHook... code
	--System setup commands
	spawnOn "1" "setxkbmap -option 'ctrl:nocaps'"
	spawnOn "1" "xmodmap -e 'keycode 66=Escape'" -- Mapping Caps Lock to ESC
	spawnOn "1" "xloadimage -onroot -fullscreen ~/Pictures/moraine_lake_canada_4k-1366x768.jpg"
	--Programs run on startup
	spawnOn "1" "firefox"
	spawnOn "1" "chromium"
	spawnOn "1" "terminator -l ct"

------------------------------------------------------------
--Making programs spawn in certain workspaces
------------------------------------------------------------

myManageHook = composeAll
	[--Find the name of the window using xprop -name "expectedName"
	--Currently working
	className =? "Chromium" --> doF (W.shift "2:browsers"),
	className =? "Firefox" --> doF (W.shift "2:browsers"),
	--WIP
	className =? "/bin/bash" --> doF (W.shift "5:mis2"),
	className =? "spotify" --> doF (W.shift "7:spotify"),
	className =? "Spotify" --> doF (W.shift "7:spotify"),
	className =? "virt-manager" --> doF (W.shift "5:misc0"),
	className =? "qemu" --> doF (W.shift "5:misc0"),
	className =? "icecat" --> doF (W.shift "6:messaging")
	--Doesn't work
	--className =? "terminator" --> doF (W.shift "1:terminal"),--This works however a if terminator utilises the -l flag it looks borked.
	]

------------------------------------------------------------
--EOF
------------------------------------------------------------
