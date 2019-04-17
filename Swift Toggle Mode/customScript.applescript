script customScript
    
    
    property parent : class "NSObject"
        to desktopState()
            set state to do shell script "defaults read com.apple.finder CreateDesktop"
        return state
    end desktopState

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
