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
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func isDarkModeOn() -> Bool {
        return customScript.desktopState
    }
    
    @objc func setDarkMode(_ button:NSStatusBarButton){
        if button.isDarkModeState() {
            button.setLightMode()
            customScript.darkModeOff()
        }else{
            button.setDarkMode()
            customScript.darkModeOn()
        }
    }
    
    func initButton(button:NSStatusBarButton!) {
        if isDarkModeOn() {
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
