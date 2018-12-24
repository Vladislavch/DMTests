//
//  CameraSettings.swift
//  DMTests
//
//  Created by Vladyslav Yemets on 12/17/18.
//  Copyright © 2018 Vladyslav Yemets. All rights reserved.
//

import Foundation
import AVFoundation

struct CapturingSettings {
    
    static let internalStep = 5.0
    
    let interval: TimeInterval
    let preset: AVCaptureSession.Preset
}
