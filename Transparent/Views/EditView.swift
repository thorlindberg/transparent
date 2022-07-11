import SwiftUI

struct EditView: View {
    
    @EnvironmentObject var design: DesignModel
    
    let frames: [UIImage?]
    
    @State private var timelineLength: CGFloat?
    @State private var leadingOffset: CGFloat = 0
    @State private var trailingOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            design.palette.group
            TimelineView(
                timelineLength: timelineLength,
                frames: frames
            )
            TrimView(
                timelineLength: $timelineLength,
                leadingOffset: $leadingOffset,
                trailingOffset: $trailingOffset
            )
        }
        .stroked()
    }
    
}

struct TimelineView: View {
    
    @EnvironmentObject var design: DesignModel
    
    let timelineLength: CGFloat?
    let frames: [UIImage?]
    
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                ForEach(1...10, id: \.self) { _ in
                    Image("sample")
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: (timelineLength ?? 0) / 10
                        )
                        .clipped()
                }
                /*
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
                */
            }
            .padding(.vertical, design.sizing.small)
            .padding(.horizontal, (proxy.size.width - (timelineLength ?? 0)) / 2)
        }
    }
    
}

struct TrimView: View {
    
    @EnvironmentObject var design: DesignModel
    
    @Binding var timelineLength: CGFloat?
    @Binding var leadingOffset: CGFloat
    @Binding var trailingOffset: CGFloat
    
    var distance: CGFloat? {
        if let timelineLength {
            return timelineLength - leadingOffset - trailingOffset
        }
        return nil
    }
    
    var isEditing: Bool {
        leadingOffset > 0 || trailingOffset > 0
    }
    
    var body: some View {
        HStack(spacing: 0) {
            HandleView(icon: "chevron.compact.left", editing: isEditing)
                .gesture(
                    DragGesture(
                        minimumDistance: 0,
                        coordinateSpace: .local
                    )
                    .onChanged({ value in
                        if let distance {
                            if distance - value.translation.width > 10 {
                                if leadingOffset + value.translation.width > 0 {
                                    leadingOffset += value.translation.width
                                }
                            }
                        }
                    })
                    .onEnded( { value in
                        if leadingOffset < 20 {
                            withAnimation {
                                leadingOffset = 0
                            }
                        }
                    })
                )
            GeometryReader { proxy in
                Rectangle()
                    .foregroundColor(.black)
                    .cornerRadius(design.sizing.medium - design.sizing.small)
                    .padding(.vertical, design.sizing.small)
                    .blendMode(.destinationOut)
                    .onAppear {
                        timelineLength = proxy.size.width
                    }
            }
            HandleView(icon: "chevron.compact.right", editing: isEditing)
                .gesture(
                    DragGesture(
                        minimumDistance: 0,
                        coordinateSpace: .local
                    )
                    .onChanged({ value in
                        if let distance {
                            if distance + value.translation.width > 10 {
                                if trailingOffset - value.translation.width > 0 {
                                    trailingOffset -= value.translation.width
                                }
                            }
                        }
                    })
                    .onEnded( { value in
                        if trailingOffset < 20 {
                            withAnimation {
                                trailingOffset = 0
                            }
                        }
                    })
                )
        }
        .background(isEditing ? design.palette.edit : design.palette.group)
        .cornerRadius(design.sizing.medium)
        .compositingGroup()
        .padding(.leading, leadingOffset)
        .padding(.trailing, trailingOffset)
    }
    
}

struct HandleView: View {
    
    @EnvironmentObject var design: DesignModel
    
    let icon: String
    let editing: Bool
    
    var body: some View {
        Image(systemName: icon)
            .font(Font.title.weight(.medium))
            .foregroundColor(editing ? .black : .white)
            .padding(.horizontal, design.sizing.large)
            .padding(.vertical, design.sizing.huge)
    }
    
}
