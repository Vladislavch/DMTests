//
//  MessagesReceiver.swift
//  DMTests
//
//  Created by Vladyslav Yemets on 12/13/18.
//  Copyright © 2018 Vladyslav Yemets. All rights reserved.
//

import Foundation
import WatchConnectivity

protocol WatchSessionDelegateProtocol {
    associatedtype MessageType
    var messageReceived: ((MessageType) -> (Void))? { get set }
}

final class WatchSessionDelegate<T>: NSObject, WatchSessionDelegateProtocol, WCSessionDelegate {
    
    typealias MessageType = T
    
    var messageReceived: ((T) -> (Void))?
    
    
    // MARK: - WCSession Activation
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
    // MARK: - WCSession State
    
    func sessionWatchStateDidChange(_ session: WCSession) {
        
    }
    
    func sessionReachabilityDidChange(_ session: WCSession) {
        
    }
    
    
    // MARK: - WCSession Interaction
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let object = message[Keys.kMessageObjectKey] as? MessageType {
            messageReceived?(object)
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        
    }
    
    
    // MARK: - WCSession Background Interaction
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        
    }
    
    func session(_ session: WCSession, didFinish userInfoTransfer: WCSessionUserInfoTransfer, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        
    }
    
    func session(_ session: WCSession, didFinish fileTransfer: WCSessionFileTransfer, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        
    }
}
