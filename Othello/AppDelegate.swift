//
//  AppDelegate.swift
//  Othello
//
//  Created by Jason Pierna on 20/03/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    // MARK: - Interface

    @IBOutlet weak var window: NSWindow!
    
    var gameViewController: GameViewController!

    // MARK: - NSApplicationDelegate
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        gameViewController = GameViewController(nibName: "GameViewController", bundle: nil)
        window.contentView?.addSubview(gameViewController.view)
        gameViewController.view.frame = window.contentView!.bounds
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    override func awakeFromNib() {
        NSApp.delegate = self
    }
}
