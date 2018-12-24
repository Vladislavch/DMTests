//
//  CameraViewController.swift
//  DMTests
//
//  Created by Vladyslav Yemets on 12/17/18.
//  Copyright © 2018 Vladyslav Yemets. All rights reserved.
//

import Foundation
import UIKit


final class CameraViewController: UIViewController {
    
    var captureSettings: CapturingSettings?
    
    private var camera = PhotoCamera()
    private var timer: Timer?
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    private func setupCapture() {
        DispatchQueue.main.async {
            self.camera.setup(position: .back)
            self.camera.place(on: self.rootView.previewPlace)
            self.camera.start()
            self.camera.photoCaptured = { photo in
                DispatchQueue.main.async {
                    UIImageWriteToSavedPhotosAlbum(photo, nil, nil, nil)
                }
            }
        }
    }
    
    
    @IBAction func takePhoto(_ sender: Any) {
        rootView.buttonStart.blink(duration: 2)
        if let settings = captureSettings {
            timer = Timer.scheduledTimer(
                withTimeInterval: settings.interval,
                repeats: true,
                block: { [weak self] _ in
                    self?.camera.captureImage()
            })
        }
    }
    
}


class CameraView: UIView {
    
    @IBOutlet weak var previewPlace: UIView!
    @IBOutlet weak var buttonStart: UIButton!
    
}

extension UIView {
    func blink(duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = duration
        animation.fromValue = 1
        animation.toValue = 0
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.isRemovedOnCompletion = false
        layer.add(animation, forKey: "opacity")
    }
}
