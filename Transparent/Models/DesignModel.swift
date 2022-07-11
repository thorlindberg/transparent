import SwiftUI

struct ViewSizing: Hashable {
    let small: CGFloat = 4
    let medium: CGFloat = 7
    let large: CGFloat = 10
    let huge: CGFloat = 14
    let maximum: CGFloat = 21
}

struct ViewPalette: Hashable {
    var edit: Color = Color(uiColor: .systemOrange)
    let group: Color = Color(uiColor: .secondarySystemBackground)
    let stroke: Color = Color(uiColor: .tertiarySystemBackground)
    let placeholder: Color = Color(uiColor: .placeholderText)
}

class DesignModel: ObservableObject {
    @Published var sizing: ViewSizing = ViewSizing()
    @Published var palette: ViewPalette = ViewPalette()
}
