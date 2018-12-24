//
//  CaptureSettingsViewController.swift
//  DMTests
//
//  Created by Vladyslav Yemets on 12/17/18.
//  Copyright © 2018 Vladyslav Yemets. All rights reserved.
//

import UIKit
import AVFoundation

class CaptureSettingsViewController: UIViewController {

    var rootView: SettingsView {
        return view as! SettingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CameraViewController {
            let settings = CapturingSettings(
                interval: CapturingSettings.internalStep * rootView.stepper.value,
                preset: AVCaptureSession.Preset.photo)
            vc.captureSettings = settings
        }
    }

}

class SettingsView: UIView {
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var labelInterval: UILabel!
    
    private var stepperValue: Double = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelInterval.text = "\(CapturingSettings.internalStep * stepper.value)"
    }
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        let time = CapturingSettings.internalStep * stepper.value
        labelInterval.text = "\(time)"
    }
    
}
