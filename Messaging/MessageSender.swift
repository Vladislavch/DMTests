//
//  SessionWrapper.swift
//  DMTests
//
//  Created by Vladyslav Yemets on 12/13/18.
//  Copyright © 2018 Vladyslav Yemets. All rights reserved.
//

import Foundation
import WatchConnectivity

protocol MessageSenderProtocol {
    
    associatedtype MessageType
    
    var isSupported: Bool { get }
    var isActived: Bool { get }
    
    func activate()
    
    func sendMessage(_ message: MessageType, onError: @escaping (Error) -> (Void))
}


final class MessageSender<T>: NSObject, MessageSenderProtocol {
    
    typealias MessageType = T
    
    private let session = WCSession.default
    private let delegate = WatchSessionDelegate<MessageType>()
    
    var isSupported: Bool {
        return WCSession.isSupported()
    }
    
    var isActived: Bool {
        return session.activationState == .activated
    }
    
    override init() {
        super.init()
        session.delegate = self.delegate
    }
    
    
    // MARK: - SessionWrapperProtocol
    
    func activate() {
        if !isActived {
            session.activate()
        }
    }
    
    func sendMessage(_ message: MessageType, onError: @escaping (Error) -> (Void)) {
        session.sendMessage([Keys.kMessageObjectKey : message], replyHandler: nil) { (error) in
            onError(error)
        }
    }
    
    
    // MARK: - Public
    
    var isBackgroundMessagingEnabled: Bool {
        // && session.isWatchAppInstalled && session.isPaired
        return isActived
    }
    
}

