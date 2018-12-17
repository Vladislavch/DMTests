//
//  ViewController.swift
//  DMTests
//
//  Created by Vladyslav Yemets on 12/5/18.
//  Copyright © 2018 Vladyslav Yemets. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var messageSender: MessageSender<String>?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var rootView: CustomView {
        return view as! CustomView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageSender = MessageSender<String>()
        messageSender?.activate()
        messageSender?.sessionDelegate.messageReceived = { [weak self] message in
            DispatchQueue.main.async {
                self?.updateLogWith(event: message)
            }
        }
    }

    func updateLogWith(event: String) {
        let newText = (rootView.textViewLog.text ?? "").appending("\n \(event)")
        rootView.textViewLog.text = newText
    }
    
    @IBAction func onSend(_ sender: Any) {
        if let message = rootView.textFieldMessage.text {
            updateLogWith(event: "Send: \(message)")
            messageSender?.sendMessage(message, onError: { [weak self] error in
                DispatchQueue.main.async {
                    self?.updateLogWith(event: error.localizedDescription)
                }
            })
        }
    }
    
}


final class CustomView: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var textViewLog: UITextView!
    @IBOutlet weak var textFieldMessage: UITextField!
    @IBOutlet weak var buttonSend: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textFieldMessage.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
