--import XMonad.Hooks.EwmhDesktops
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
	  ((mod4Mask .|. controlMask, xK_p), spawn "scrot '%Y-%m-%d:%H:%M:%S.png' -e 'mv $f /home/cflaptop/Pictures/Screenshots/'"), --Takes and saves screenshot
	  ((mod4Mask .|. controlMask .|. shiftMask, xK_p), spawn "scrot -u '%Y-%m-%d:%H:%M:%S.png' -e 'mv $f /home/cflaptop/Pictures/Screenshots/'"), --Takes and saves screenshot.Only the currently focused window
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
	  ((controlMask .|. shiftMask, xK_minus),spawn "xbacklight -time 0 -dec 10%"),
	  ((controlMask .|. shiftMask,xK_equal),spawn "xbacklight -time 0 -inc 10%"),
	  ((mod1Mask .|. shiftMask, xK_l), spawn "toggleScreen"),--Toggle between 0% and 100% brightness.Useful to type a password in plaintext in a public place
	  --Quick type hotkeys
	  ((mod4Mask,xK_w),spawn "quickType while"),
	  ((mod4Mask,xK_o),spawn "quickType javaSystemOut"),--broken
	  ((mod4Mask, xK_n),spawn "quickType githubName"), 
	  ((mod4Mask, xK_p),spawn "quickType print"), 
	  ((mod1Mask, xK_s),spawn "vimSave"),
	  ((mod1Mask .|. shiftMask, xK_s),spawn "vimSaveAndGoToInsertMode"),
	  --Program Launcher Hotkeys
	  ((controlMask .|. mod1Mask, xK_f), spawn "~/Music/firefox/firefox"),
	  ((controlMask .|. mod1Mask, xK_c), spawn "chromium"),
	  ((controlMask .|. mod1Mask, xK_s), spawn "spotify"),
	  ((controlMask .|. mod1Mask, xK_a), spawn "atom"),
	  ((controlMask .|. mod1Mask, xK_z), spawn "filezilla"),
	  ((controlMask .|. mod1Mask, xK_w), spawn "libreoffice --writer"),
	  ((controlMask .|. mod1Mask, xK_i), spawn "libreoffice --impress"),
	  ((controlMask .|. mod1Mask, xK_e), spawn "eclipse"),
	  ((controlMask .|. mod1Mask, xK_b), spawn "bluej"),
	  ((controlMask .|. mod1Mask, xK_p), spawn "pyzo"),
	  ((controlMask .|. mod1Mask .|. shiftMask, xK_p), spawn "pycharm"),
	  ((controlMask .|. mod1Mask, xK_m), spawn "icecat"),
	  --Alternate terminal hotkeys
	  ((controlMask .|. mod1Mask, xK_t), spawn "terminator"),
	  ((shiftMask .|. mod1Mask, xK_t), spawn "terminator -l ct"),
	  ((controlMask .|. mod1Mask, xK_Return), spawn "terminator -l ct"),
	  --System Control Hotkeys
	  ((mod1Mask, xK_t), spawn "tp"), --tp is a custom command which disable or enables my trackpad

	  --CheatSheet viewer
	  ((controlMask .|. mod1Mask,xK_v),spawn "feh ~/Pictures/CheatSheets/vim.gif"),
	  ((controlMask .|. mod1Mask,xK_x),spawn "feh ~/Pictures/CheatSheets/XMonad.png")
	  ]

	  `removeKeys`
	  [--Conflicting with vim style navigation for terminator
	  (mod1Mask, xK_h),
	  (mod1Mask, xK_j),
	  (mod1Mask, xK_k),
	  (mod1Mask, xK_l)
	  --(mod1Mask .|. shiftMask, xK_c) --Unmapping default close window hotkey
	  ]

------------------------------------------------------------
--Removing some default hotkeys
------------------------------------------------------------
------------------------------------------------------------
--Setting personal defaults
------------------------------------------------------------

defaults = defaultConfig{ 
	 terminal = "terminator -l ct", --Options = uxterm,xterm,tmux,terminator(terminator -l ct)
	 startupHook = myStartupHook,
  	 normalBorderColor = "#000000", --Default colour = #FF0000 red
	 borderWidth = 0,
	 focusFollowsMouse = False,
	 manageHook = myManageHook,	
	 --workspaces = myWorkspaces,
         modMask = mod1Mask  --mod1Mask = left alt.mod3Mask = right alt. mod4Mask = super	

  }




------------------------------------------------------------
--Commands run at startup
------------------------------------------------------------

myStartupHook = do --Commands run on startup."[:digit:] indicates the workspace to run in"
	--Programs are moved to proper workspaces by the myManageHook... code
	--System setup commands
	spawnOn "1" "setxkbmap -option 'ctrl:nocaps'"
	spawnOn "1" "setWMName 'LG3D'"
	spawnOn "1" "xmodmap -e 'keycode 66=Escape'" -- Mapping Caps Lock to ESC
	spawnOn "1" "fb"

------------------------------------------------------------
--Naming my workspaces
------------------------------------------------------------


--myWorkspaces = ["1:terminal","2:browsers","3:misc0","4:misc1","5:misc2","6:messaging","7:spotify","8:htop","9:misc5"]
--myExtraWorkspaces = [(xK_0),"0"]
------------------------------------------------------------
--Making programs spawn in certain workspaces
------------------------------------------------------------

myManageHook = composeAll
	[--Find the name of the window using xprop -name "expectedName"
	--Currently working
	className =? "Chromium" --> doF (W.shift "2"),
	className =? "Firefox" --> doF (W.shift "2"),
	--WIP
	className =? "/bin/bash" --> doF (W.shift "5"),
	appName =? "spotify" --> doF (W.shift "2"),
	appName =? "Spotify" --> doF (W.shift "2"),
	className =? "spotify" --> doF (W.shift "2"),
	className =? "Spotify" --> doF (W.shift "2"),
	className =? "virt-manager" --> doF (W.shift "5:misc0"),
	className =? "qemu" --> doF (W.shift "5:misc0"),
	className =? "icecat" --> doF (W.shift "6:messaging")
	--Doesn't work
	--className =? "terminator" --> doF (W.shift "1:terminal"),--This works however a if terminator utilises the -l flag it looks borked.
	]

------------------------------------------------------------
--EOF
------------------------------------------------------------
