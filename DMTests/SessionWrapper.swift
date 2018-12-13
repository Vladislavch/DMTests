//
//  SessionWrapper.swift
//  DMTests
//
//  Created by Vladyslav Yemets on 12/13/18.
//  Copyright © 2018 Vladyslav Yemets. All rights reserved.
//

import Foundation
import WatchConnectivity

protocol SessionWrapperProtocol {
    
    associatedtype MessageType
    
    var isSupported: Bool { get }
    var isActived: Bool { get }
    
    var answerReceived: (MessageType?, Error?) -> (Void) { get set }
    
    func activate()
}


fileprivate struct Keys {
    static let kMessageObjectKey = "kMessageObjectKey"
}


final class SessionWrapper<T>: NSObject, SessionWrapperProtocol, WCSessionDelegate {
    
    typealias MessageType = T
    
    private let session = WCSession.default
    
    var answerReceived: (MessageType?, Error?) -> (Void) = {_,_ in }
    
    var isSupported: Bool {
        return WCSession.isSupported()
    }
    
    var isActived: Bool {
        return session.activationState == .activated
    }
    
    override init() {
        super.init()
        session.delegate = self
    }
    
    // MARK: - SessionWrapperProtocol
    
    func activate() {
        if !isActived {
            session.activate()
        }
    }
    
    func sendMessage(_ message: MessageType) {
        session.sendMessage([Keys.kMessageObjectKey : message], replyHandler: { [weak self] answer in
            if let str = answer[Keys.kMessageObjectKey] as? MessageType {
                self?.answerReceived(str, nil)
            } else {
                self?.answerReceived(nil, NSError())
            }
        }) { [weak self] (error) in
            self?.answerReceived(nil, error)
        }
    }
    
    
    // MARK: - Public
    
    var isBackgroundMessagingEnabled: Bool {
        return isActived && session.isWatchAppInstalled && session.isPaired
    }
    
    
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

