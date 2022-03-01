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
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 10

        print(self.backgroundView.bounds.maxY)
    
        
        
        viewNew.frame = CGRect(x: self.bounds.maxX / 1.6, y: self.backgroundView.bounds.maxY - 42, width: self.bounds.maxX / 3.5, height: self.bounds.maxY / 4.5)
        viewNew.layer.borderColor = UIColor.systemGray5.cgColor
        viewNew.layer.borderWidth = 1
        viewNew.backgroundColor = .systemGray6
        viewNew.layer.cornerRadius = 5
        self.addSubview(viewNew)
        
        
        
        
        labelNew.frame = CGRect(x: 0, y: 0, width: viewNew.bounds.maxX, height: viewNew.bounds.maxY)
        labelNew.textColor = .systemGray2
        labelNew.textAlignment = .center
        labelNew.font = UIFont(name: "Courier New", size: 23)
        labelNew.text = "new"
        viewNew.addSubview(labelNew)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        viewNew.addGestureRecognizer(tapGesture)
        
        backgroundView.frame = CGRect(x: 0, y: 0, width: self.bounds.maxX, height: self.bounds.maxY - 40)
        backgroundView.layer.cornerRadius = 10
        backgroundView.backgroundColor = .systemGray6
        backgroundView.layer.borderColor = UIColor.systemGray4.cgColor
        backgroundView.layer.borderWidth = 2
        self.layer.masksToBounds = true
        self.addSubview(backgroundView)
        
        drawCells()
        
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
        
        hintLabel.frame = CGRect(x: backgroundView.bounds.maxX / 9, y: 3, width: backgroundView.bounds.maxX / 9 * 7, height: backgroundView.bounds.maxY / 3)
        hintLabel.text = ".password"
        hintLabel.textColor = .systemGray2
        hintLabel.font = UIFont(name: "Courier New", size: 28)
        hintLabel.textAlignment = .right
        backgroundView.addSubview(hintLabel)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut]) {
            self.viewNew.frame.origin.y = self.viewNew.frame.origin.y + 40
        }
    }
    
    func drawViewNew() {
        
        
        
        
        
        
    }
    
    func drawLabelNew() {
        
        
        
    }
    
    func drawBackgroundView() {
        
        
        
    }
    
    func drawTextField() {
        
        
        
    }
    
    func drawHintLabel() {
    
    
    
    
    
    }
    
    
    
    
    
    
    
    
    func drawCells() {
        for i in 0...3 {
            let width = backgroundView.bounds.maxX / 9
            let emptyView = UIView(frame: CGRect(x: CGFloat(i) * 2 * width + width, y: backgroundView.bounds.maxY / 2.5, width: width, height: backgroundView.bounds.maxY / 2.3))
            emptyView.backgroundColor = .white
            emptyView.layer.cornerRadius = 5
            backgroundView.addSubview(emptyView)
        }
    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        let text = buttonState ? "cancel" : "new"
        buttonState = !buttonState
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut]) {
            self.viewNew.frame.origin.y = self.viewNew.frame.origin.y - 40
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut]) {
                self.labelNew.text = text
                self.viewNew.frame.origin.y = self.viewNew.frame.origin.y + 40
            }
        }
        //self.sendActions(for: UIControl.Event.touchUpInside)
    }
//
//    func getSelectedIndex() -> Int {
//        return selectedIndex
//    }
//
//    func setFont(size: CGFloat) {
//        sizeOfFont = size
//    }
//
//    func setSections(labels: [String]) {
//        arrayOfSections = labels
//    }
//
//    func changeLabel(index: Int, labelText: String) {
//        if index < arrayOfSections.count {
//            arrayOfSections[index] = labelText
//        }
//    }
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
