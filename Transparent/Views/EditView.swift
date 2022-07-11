import SwiftUI

struct EditView: View {
    
    @EnvironmentObject var design: DesignModel
    
    let frames: [UIImage?]
    
    var body: some View {
        ZStack {
            CheckerboardView()
                .stroked()
            TimelineView(frames: frames)
            TrimView()
        }
    }
    
}

struct TimelineView: View {
    
    @EnvironmentObject var design: DesignModel
    
    let frames: [UIImage?]
    
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                ForEach(frames, id: \.self) { frame in
                    if let frame {
                        Image(uiImage: frame)
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: proxy.size.width / CGFloat(frames.count),
                                height: proxy.size.height
                            )
                    }
                }
            }
        }
        .cornerRadius(design.sizing.medium)
    }
    
}

struct TrimView: View {
    
    @EnvironmentObject var design: DesignModel
    
    @State private var leadingOffset: CGFloat = 0
    @State private var trailingOffset: CGFloat = 30
    
    var body: some View {
        HStack(spacing: 0) {
            HandleView(icon: "chevron.compact.left")
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .cornerRadius(design.sizing.medium - design.sizing.small)
                    .padding(.vertical, design.sizing.small)
                    .blendMode(.destinationOut)
            }
            HandleView(icon: "chevron.compact.right")
        }
        .background(design.palette.edit)
        .cornerRadius(design.sizing.medium)
        .compositingGroup()
        .padding(.leading, leadingOffset)
        .padding(.trailing, trailingOffset)
    }
    
}

struct HandleView: View {
    
    @EnvironmentObject var design: DesignModel
    
    let icon: String
    
    var body: some View {
        Image(systemName: icon)
            .font(Font.title.weight(.medium))
            .foregroundColor(.black)
            .padding(.horizontal, design.sizing.large)
            .padding(.vertical, design.sizing.huge)
            .background(design.palette.edit)
    }
    
}
