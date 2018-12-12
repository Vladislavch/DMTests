//
//  ViewController.swift
//  DMTests
//
//  Created by Vladyslav Yemets on 12/5/18.
//  Copyright © 2018 Vladyslav Yemets. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var rootView: CustomView {
        return view as! CustomView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}


final class CustomView: UIView {
    
    @IBOutlet weak var textViewLog: UITextView!
    
}
