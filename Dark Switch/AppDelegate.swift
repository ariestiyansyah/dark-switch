//
//  AppDelegate.swift
//  Swift Toggle Mode
//
//  Created by Rizky Ariestiyansyah on 17/04/19.
//  Copyright © 2019 ONTO. All rights reserved.
//

import Cocoa
import AppleScriptObjC

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var customScript:customScript
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    
    @IBOutlet weak var window: NSWindow!
    let  darkModeOnImage:NSImage? = NSImage(named:NSImage.Name("DarkModeOnIcon"))
    let  darkModeOffImage:NSImage? = NSImage(named:NSImage.Name("DarkModeOffIcon"))
    
    override init() {
        Bundle.main.loadAppleScriptObjectiveCScripts()
        let iTunesBridgeClass: AnyClass = NSClassFromString("customScript")!
        self.customScript = iTunesBridgeClass.alloc() as! customScript
        super.init()
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if let button = statusItem.button {
            initButton(button: button)
            button.action = #selector(setDarkMode(_:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func isDarkModeOn(appearance: NSAppearance?) -> Bool {
        if #available(macOS 10.14, *) {
            let basicAppearance: NSAppearance.Name? = appearance?.bestMatch(from: [.aqua, .darkAqua])
            return basicAppearance == .darkAqua
        } else {
            return false
        }
    }
    
    @objc func setDarkMode(_ button:NSStatusBarButton){
        let event = NSApp.currentEvent
        if event?.type == NSEvent.EventType.rightMouseUp {
            let menu = NSMenu()
            menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
            let position = NSPoint(x: button.frame.origin.x, y: (button.frame.origin.y + 5 ) - (button.frame.height / 2))
            menu.popUp(positioning: menu.item(at: 0), at: position, in: button.superview)
        }else{
            if button.isDarkModeState() {
                button.setLightMode()
                customScript.darkModeOff()
            }else{
                button.setDarkMode()
                customScript.darkModeOn()
            }
        }
    }
    
    func initButton(button:NSStatusBarButton!) {
        if isDarkModeOn(appearance: NSAppearance.current) {
            button.setDarkMode()
        }else{
            button.setLightMode()
        }
    }
    
}

extension NSStatusBarButton {
    func setDarkMode() {
        self.tag = 1
        self.image = NSImage(named:NSImage.Name("DarkModeOnIcon"))
    }
    
    func setLightMode() {
        self.tag = 0
        self.image = NSImage(named:NSImage.Name("DarkModeOffIcon"))
    }
    
    func isDarkModeState() -> Bool {
        return self.tag == 1
    }
}
