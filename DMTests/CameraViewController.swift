//
//  CameraViewController.swift
//  DMTests
//
//  Created by Vladyslav Yemets on 12/17/18.
//  Copyright © 2018 Vladyslav Yemets. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


final class CameraViewController: UIViewController {
    
    private var camera = PhotoCamera()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var rootView: CameraView {
        return view as! CameraView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if camera.permissionGranted {
            setupCapture()
        } else {
            camera.requestAccessIfNeeded { [weak self] result in
                self?.setupCapture()
            }
        }
    }
    
    private func setupCapture() {
        DispatchQueue.main.async {
            self.camera.setup(position: .back)
            self.camera.place(on: self.rootView.previewPlace)
            self.camera.start()
        }
    }
    
}


class CameraView: UIView {
    
    @IBOutlet weak var previewPlace: UIView!
    
}


protocol CameraProtocol {
    
    var captureDirection: AVCaptureDevice.Position? { get }
    var permissionGranted: Bool { get }
    
    func requestAccessIfNeeded(onGranted: @escaping (Bool)->())
    func setup(position: AVCaptureDevice.Position)
    func place(on view: UIView)
    func start()
    func stop()
    func captureImage()
}


final class PhotoCamera: NSObject, CameraProtocol, AVCaptureVideoDataOutputSampleBufferDelegate {

    private(set) var captureDirection: AVCaptureDevice.Position?
    
    var permissionGranted: Bool {
        return AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }

    
    private var captureDevice: AVCaptureDevice!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var photoOutput: AVCapturePhotoOutput!
    private var videoOutput: AVCaptureVideoDataOutput!
    private var input: AVCaptureDeviceInput!
    private let sessionQueue = DispatchQueue(label: "camera.queue")
    
    private let session: AVCaptureSession
    private let mediaType: AVMediaType
    
    override init() {
        mediaType = AVMediaType.video
        session = AVCaptureSession()
    }
    
    func requestAccessIfNeeded(onGranted: @escaping (Bool)->()) {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authorizationStatus {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: onGranted)
        case .denied, .restricted, .authorized:
            break
        }
    }
    
    func setup(position: AVCaptureDevice.Position) {
        let discoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: .video,
            position: position)
        for device in discoverySession.devices {
            captureDirection = position
            captureDevice = device
        }
        photoOutput = AVCapturePhotoOutput()
        if session.canAddOutput(photoOutput!) {
            session.addOutput(photoOutput!)
        }
        
        videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: self.sessionQueue)
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
        }
        
        input = try! AVCaptureDeviceInput(device: captureDevice)
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
//        session.sessionPreset = AVCaptureSession.Preset.low
    }
    
    func place(on view: UIView) {
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.bounds
        previewLayer.backgroundColor = UIColor.red.cgColor
        view.layer.addSublayer(previewLayer)
    }
    
    func start() {
//        do{
//            if captureDevice?.hasTorch == true
//            {
//                try captureDevice?.lockForConfiguration()
//                captureDevice?.torchMode = .on
//                captureDevice?.flashMode = .on
//                captureDevice?.unlockForConfiguration()
//            }
//        } catch {
//            //DISABEL FLASH BUTTON HERE IF ERROR
//            print("Device tourch Flash Error ");
//        }
        
        sessionQueue.async {
            self.session.startRunning()
        }
    }
    
    func stop() {
        
    }

    func captureImage() {
//        let connection = self.photoOutput?.connection(with: .video)
        
        // update the video orientation to the device one
//        connection?.videoOrientation = AVCaptureVideoOrientation(rawValue: UIDevice.current.orientation.rawValue)!
//
//        self.photoOutput?.capturePhoto(with: <#T##AVCapturePhotoSettings#>, delegate: <#T##AVCapturePhotoCaptureDelegate#>)
        
    }
    
    func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print(#function)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print(#function)
    }
    
}

