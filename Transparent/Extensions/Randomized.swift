import SwiftUI

extension String {
    func randomized(_ loaded: Bool) -> String {
        if loaded {
            return self
        } else {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            return "\(Int.random(in: 0...9))\(letters[letters.index(letters.startIndex, offsetBy: Int.random(in: 0..<letters.count))])\(Int.random(in: 0...9))\(letters[letters.index(letters.startIndex, offsetBy: Int.random(in: 0..<letters.count))])\(Int.random(in: 0...9))\(letters[letters.index(letters.startIndex, offsetBy: Int.random(in: 0..<letters.count))])\(Int.random(in: 0...9))\(letters[letters.index(letters.startIndex, offsetBy: Int.random(in: 0..<letters.count))])"
        }
    }
}
