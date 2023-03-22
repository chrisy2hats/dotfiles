
import XMonad
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.Fullscreen


main = xmonad $ fullscreenSupport $ ewmh defaultConfig
	{
	
	borderWidth = 0,
	terminal = "terminator"

	}
