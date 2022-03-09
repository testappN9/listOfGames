//
//  CustomSegmentedControl.swift
//  tg
//
//  Created by Anton Chirkov on 28.02.22.
//

import UIKit

class CustomPinField: UIControl {
    
    private let backgroundView = UIView()
    private let viewNew = UIView()
    private let labelNew = UILabel()
    private let textField = UITextField()
    private let hintLabel = UILabel()
    private var buttonState = true
    
    private enum Constants {
        static let cornerRadiusMainView: CGFloat = 10
        static let buttonHeight: CGFloat = 40
        static let textCancel = "cancel"
        static let textNew = "new"
    }
    
    private enum ShowHide {
        case show, hide, hideShow
    }
    
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = Constants.cornerRadiusMainView
        drawViewNew()
        drawLabelNew()
        drawBackgroundView()
        drawCells()
        drawTextField()
        drawHintLabel()
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut]) {
            self.viewNew.frame.origin.y = self.viewNew.frame.origin.y + 40
        }
    }
    
    private func drawViewNew() {
        viewNew.frame = CGRect(x: self.bounds.maxX / 1.6, y: self.backgroundView.bounds.maxY - 42, width: self.bounds.maxX / 3.5, height: self.bounds.maxY / 4.5)
        viewNew.layer.borderColor = UIColor.systemGray5.cgColor
        viewNew.layer.borderWidth = 1
        viewNew.backgroundColor = .systemGray6
        viewNew.layer.cornerRadius = 5
        self.addSubview(viewNew)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        viewNew.addGestureRecognizer(tapGesture)
    }
    
    private func drawLabelNew() {
        labelNew.frame = CGRect(x: 0, y: 0, width: viewNew.bounds.maxX, height: viewNew.bounds.maxY)
        labelNew.textColor = .systemGray2
        labelNew.textAlignment = .center
        labelNew.font = UIFont(name: "Courier New", size: 23)
        labelNew.text = "new"
        viewNew.addSubview(labelNew)
    }
    
    private func drawBackgroundView() {
        backgroundView.frame = CGRect(x: 0, y: 0, width: self.bounds.maxX, height: self.bounds.maxY - 40)
        backgroundView.layer.cornerRadius = 10
        backgroundView.backgroundColor = .systemGray6
        backgroundView.layer.borderColor = UIColor.systemGray4.cgColor
        backgroundView.layer.borderWidth = 2
        self.layer.masksToBounds = true
        self.addSubview(backgroundView)
    }
    
    private func drawTextField() {
        textField.frame = CGRect(x: backgroundView.bounds.maxX / 7, y: backgroundView.bounds.maxY / 2.7, width: backgroundView.bounds.width, height: backgroundView.bounds.maxY / 2)
        textField.delegate = self
        textField.font = UIFont(name: "Optima", size: 30)
        textField.textColor = .gray
        textField.textAlignment = .left
        textField.defaultTextAttributes.updateValue(55.0, forKey: NSAttributedString.Key.kern)
        textField.isSecureTextEntry = true
        textField.keyboardType = UIKeyboardType.numberPad
        textField.becomeFirstResponder()
        backgroundView.addSubview(textField)
    }
    
    private func drawHintLabel() {
        hintLabel.frame = CGRect(x: backgroundView.bounds.maxX / 9, y: 3, width: backgroundView.bounds.maxX / 9 * 7, height: backgroundView.bounds.maxY / 3)
        hintLabel.text = ".password"
        hintLabel.textColor = .systemGray2
        hintLabel.font = UIFont(name: "Courier New", size: 28)
        hintLabel.textAlignment = .right
        backgroundView.addSubview(hintLabel)
    }
    
    private func drawCells() {
        for i in 0...3 {
            let width = backgroundView.bounds.maxX / 9
            let emptyView = UIView(frame: CGRect(x: CGFloat(i) * 2 * width + width, y: backgroundView.bounds.maxY / 2.5, width: width, height: backgroundView.bounds.maxY / 2.3))
            emptyView.backgroundColor = .white
            emptyView.layer.cornerRadius = 5
            backgroundView.addSubview(emptyView)
        }
    }
    
    
    private func animateButton(action: ShowHide) {
       
        var motion = -Constants.buttonHeight
        if action == .show {
            motion = -motion
        }
        
        let text = buttonState ? Constants.textCancel : Constants.textNew
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut]) {
            self.viewNew.frame.origin.y = self.viewNew.frame.origin.y + motion
        } completion: { _ in
            if action == .hideShow {
                self.labelNew.text = text
                self.animateButton(action: .show)
            }
        }
    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        
        buttonState = !buttonState
        animateButton(action: .hideShow)
        //self.sendActions(for: UIControl.Event.touchUpInside)
    }
    
    func getPassword() {
    
        
    }
    
    
    
    
}

extension CustomPinField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        if updatedText.count == 4 {
            print("4char")
        }
        return updatedText.count <= 4
    }
}
