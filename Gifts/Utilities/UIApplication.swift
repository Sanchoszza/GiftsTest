//
//  UIApplication.swift
//  Gifts
//
//  Created by Александра Згонникова on 08.09.2025.
//

import Foundation
import SwiftUI

extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
