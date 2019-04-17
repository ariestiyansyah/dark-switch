//
//  customScript.swift
//  Swift Toggle Mode
//
//  Created by Rizky Ariestiyansyah on 17/04/19.
//  Copyright © 2019 ONTO. All rights reserved.
//

import Cocoa

@objc(NSObject) protocol customScript {
    var desktopState: Bool { get }
    func darkModeOn()
    func darkModeOff()
}
