import SwiftUI

struct StrokeModifier: ViewModifier {
    
    @EnvironmentObject var design: DesignModel
    
    func body(content: Content) -> some View {
        content
            .cornerRadius(design.sizing.medium)
            .overlay(
                RoundedRectangle(cornerRadius: design.sizing.medium)
                    .stroke(design.palette.stroke, lineWidth: 1)
            )
    }
    
}

extension View {
    func stroked() -> some View {
        modifier(StrokeModifier())
    }
}
