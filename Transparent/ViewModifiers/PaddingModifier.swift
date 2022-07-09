/*
 
import SwiftUI

enum ViewPadding {
    case minimum
    case normal
    case maximum
}

extension View {
    func padding(with size: ViewPadding) -> some View {
        modifier(PaddingModifier(size: size))
    }
}

struct PaddingModifier: ViewModifier {
    
    let size: ViewPadding
    
    var value: CGFloat {
        switch size {
        case .minimum:
            return 4
        case .normal:
            return 7
        case .maximum:
            return 10
        }
    }
    
    func body(content: Content) -> some View {
        content
            .padding(value)
    }
    
}
 
*/
