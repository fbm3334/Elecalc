//
//  GestureRecogniser.swift
//  Elecalc
//
//  Created by Finn Beckitt-Marshall on 18/10/2020.
//

import Foundation
import UIKit

// Based on https://stackoverflow.com/questions/56491386/how-to-hide-keyboard-when-using-swiftui - pawello2222's solution

extension UIApplication {
    func addTapGestureRecogniser() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
