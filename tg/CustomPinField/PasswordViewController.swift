//
//  PasswordViewController.swift
//  tg
//
//  Created by Anton Chirkov on 28.02.22.
//

import UIKit

class PasswordViewController: UIViewController {
    
    @IBOutlet weak var viewForPasswordField: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let passwordView = CustomPinField(frame: viewForPasswordField.bounds)
        viewForPasswordField.addSubview(passwordView)
    }
    
    
    
    
    
    
    
}
