//
//  ExtensionDelegate.swift
//  WakeSource Extension
//
//  Created by Vladyslav Yemets on 12/12/18.
//  Copyright © 2018 Vladyslav Yemets. All rights reserved.
//

import WatchKit
import WatchConnectivity

class ExtensionDelegate: NSObject, WKExtensionDelegate {

//    private let delegate = WatchSessionDelegate<String>()
    
    override init() {
        super.init()
//        WCSession.default.delegate = self.delegate
//        WCSession.default.activate()
    }
    
    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        
        func handleOnlyWatchOS5Task(_ task: WKRefreshBackgroundTask) {
            if #available(watchOSApplicationExtension 5.0, *) {
                switch task {
                case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
                    // Be sure to complete the relevant-shortcut task once you're done.
                    relevantShortcutTask.setTaskCompletedWithSnapshot(false)
                case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
                    // Be sure to complete the intent-did-run task once you're done.
                    intentDidRunTask.setTaskCompletedWithSnapshot(false)
                default:
                    // make sure to complete unhandled task types
                    task.setTaskCompletedWithSnapshot(false)
                }
            } else {
                // make sure to complete unhandled task types
                task.setTaskCompletedWithSnapshot(false)
            }
        }
        
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompletedWithSnapshot(false)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            default:
                if #available(watchOSApplicationExtension 5.0, *) {
                    handleOnlyWatchOS5Task(task)
                } else {
                    // make sure to complete unhandled task types
                    task.setTaskCompletedWithSnapshot(false)
                }
            }
        }
    }
    
}
