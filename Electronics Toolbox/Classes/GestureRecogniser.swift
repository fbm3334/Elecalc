//
//  GestureRecogniser.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 18/10/2020.
//

import Foundation
import UIKit

// Based on https://stackoverflow.com/questions/56491386/how-to-hide-keyboard-when-using-swiftui - Mikhail's solution

class GestureRecogniser: UIGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if let touchedView = touches.first?.view, touchedView is UIControl {
            state = .cancelled
        } else if let touchedView = touches.first?.view as? UITextView, touchedView.isEditable {
            state = .cancelled
        } else {
            state = .began
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .ended
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .cancelled
    }
}
