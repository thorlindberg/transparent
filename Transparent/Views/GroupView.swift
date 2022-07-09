import SwiftUI

struct GroupView<Content: View>: View {
    
    @EnvironmentObject var design: DesignSystem
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: design.sizing.huge) {
            content
        }
        .padding(design.sizing.huge)
        .background(design.palette.group)
        .stroked()
    }
    
}
