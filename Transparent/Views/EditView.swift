import SwiftUI

struct EditView: View {
    
    @EnvironmentObject var design: DesignModel
    
    @State private var leadingOffset: CGFloat = 50
    @State private var trailingOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                HStack(spacing: 0) {
                    ForEach(1...4, id: \.self) { _ in
                        Image("sample")
                            .resizable()
                            .scaledToFit()
                            .frame(height: proxy.size.height)
                    }
                }
            }
            .cornerRadius(design.sizing.medium)
            .stroked()
            HStack(spacing: 0) {
                HandleView(text: "chevron.compact.left")
                VStack {
                    Rectangle()
                        .frame(height: design.sizing.small)
                        .foregroundColor(design.palette.edit)
                    Spacer()
                    Rectangle()
                        .frame(height: design.sizing.small)
                        .foregroundColor(design.palette.edit)
                }
                HandleView(text: "chevron.compact.right")
            }
            .cornerRadius(design.sizing.medium)
            .padding(.leading, leadingOffset)
            .padding(.trailing, trailingOffset)
        }
    }
    
}

struct HandleView: View {
    
    @EnvironmentObject var design: DesignModel
    
    let text: String
    
    var body: some View {
        Image(systemName: text)
            .font(Font.title.weight(.medium))
            .foregroundColor(.black)
            .padding(.horizontal, design.sizing.large)
            .padding(.vertical, design.sizing.huge)
            .background(design.palette.edit)
    }
    
}
