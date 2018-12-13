//
//  ViewController.swift
//  DMTests
//
//  Created by Vladyslav Yemets on 12/5/18.
//  Copyright © 2018 Vladyslav Yemets. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var sender: MessageSender<String>?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var rootView: CustomView {
        return view as! CustomView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sender = MessageSender<String>()
    }

    func updateLog(_ text: String) {
        let newText = (rootView.textViewLog.text ?? "").appending("\n /(text)")
        rootView.textViewLog.text = newText
    }
    
    @IBAction func onSend(_ sender: Any) {
        if let message = rootView.textFieldMessage.text {
            self.sender?.sendMessage(message, onError: { [weak self] error in
                self?.updateLog(error.localizedDescription)
            })
        }
    }
    
}


final class CustomView: UIView {
    
    @IBOutlet weak var textViewLog: UITextView!
    @IBOutlet weak var textFieldMessage: UITextField!
    @IBOutlet weak var buttonSend: UIButton!
    
}
