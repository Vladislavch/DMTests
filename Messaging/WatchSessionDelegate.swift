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
        print(#function)
        if let `error` = error {
            print(error)
        }
    }
    
    #if os(iOS)
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print(#function)
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print(#function)
    }
    
    
    // MARK: - WCSession State
    
    func sessionWatchStateDidChange(_ session: WCSession) {
        print(#function)
    }
    
    #endif
    
    func sessionReachabilityDidChange(_ session: WCSession) {
        print(#function)
    }
    
    
    // MARK: - WCSession Interaction
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let object = message[Keys.kMessageObjectKey] as? MessageType {
            messageReceived?(object)
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        print(#function)
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        print(#function)
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        print(#function)
    }
    
    
    // MARK: - WCSession Background Interaction
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print(#function)
    }
    
    func session(_ session: WCSession, didFinish userInfoTransfer: WCSessionUserInfoTransfer, error: Error?) {
        print(#function)
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print(#function)
    }
    
    func session(_ session: WCSession, didFinish fileTransfer: WCSessionFileTransfer, error: Error?) {
        print(#function)
    }
    
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        print(#function)
    }
}
