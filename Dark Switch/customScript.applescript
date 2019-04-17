script customScript

    to darkModeOn()
        tell application "System Events"
            tell appearance preferences
                set dark mode to true
            end tell
        end tell
    end darkModeOn

    to darkModeOff()
        tell application "System Events"
            tell appearance preferences
                set dark mode to false
            end tell
        end tell
    end darkModeOff

end script
