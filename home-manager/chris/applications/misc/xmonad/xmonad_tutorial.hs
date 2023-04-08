import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier

main :: IO ()
myConfig = (def
    {
        modMask = mod4Mask,
        layoutHook = myLayout,
        terminal = "kitty"
    }
    `additionalKeysP`
    [
        ("M-f", spawn "firefox")
    ])

myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
    where
        threeCol = magnifiercz' 1.3 (ThreeColMid nmaster delta ratio)
        tiled = Tall nmaster delta ratio
        nmaster = 1
        ratio = 1/2
        delta = 3/100
