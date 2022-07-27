import SwiftUI

struct EditView: View {
    
    @EnvironmentObject var design: DesignModel
    
    let frames: [UIImage?]
    
    @State private var timelineLength: CGFloat?
    
    @Binding var starting: CGFloat
    @Binding var ending: CGFloat
    let duration: CGFloat
    
    var body: some View {
        ZStack {
            design.palette.group
            TimelineView(
                timelineLength: timelineLength,
                frames: frames
            )
            TrimView(
                timelineLength: $timelineLength,
                starting: $starting,
                ending: $ending,
                duration: duration
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
            ZStack {
                CheckerboardView()
                if let timelineLength {
                    HStack(spacing: 0) {
                        ForEach(frames, id: \.self) { frame in
                            if let frame {
                                Image(uiImage: frame)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(
                                        width: timelineLength / CGFloat(frames.count)
                                    )
                                    .clipped()
                            }
                        }
                    }
                }
            }
            .padding(.vertical, design.sizing.small)
            .padding(.horizontal, (proxy.size.width - (timelineLength ?? 0)) / 2)
        }
    }
    
}

struct TrimView: View {
    
    @EnvironmentObject var design: DesignModel
    
    @Binding var timelineLength: CGFloat?
    @Binding var starting: CGFloat
    @Binding var ending: CGFloat
    let duration: CGFloat
    
    private var leadingOffset: CGFloat {
        if let timelineLength {
            return timelineLength / duration * starting
        } else {
            return 0
        }
    }
    private var trailingOffset: CGFloat {
        if let timelineLength {
            return timelineLength / duration * (duration - ending)
        } else {
            return 0
        }
    }
    
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
        ZStack {
            HStack(spacing: 0) {
                HandleView(icon: "chevron.compact.left", editing: isEditing)
                    .gesture(
                        DragGesture(
                            minimumDistance: 0,
                            coordinateSpace: .local
                        )
                        .onChanged({ value in
                            if let timelineLength {
                                if let distance {
                                    if distance - value.translation.width > 10 {
                                        if timelineLength / duration * starting + value.translation.width > 0 {
                                            starting += value.translation.width
                                        }
                                    }
                                }
                            }
                        })
                        .onEnded( { value in
                            if let timelineLength {
                                if timelineLength / duration * starting < 20 {
                                    withAnimation {
                                        starting = 0
                                    }
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
                            if let timelineLength {
                                if let distance {
                                    if distance + value.translation.width > 10 {
                                        if timelineLength / duration * (duration - ending) - value.translation.width > 0 {
                                            ending += value.translation.width
                                        }
                                    }
                                }
                            }
                        })
                        .onEnded( { value in
                            if let timelineLength {
                                if timelineLength / duration * (duration - ending) < 20 {
                                    withAnimation {
                                        ending = duration
                                    }
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
    
}

struct HandleView: View {
    
    @EnvironmentObject var design: DesignModel
    
    let icon: String
    let editing: Bool
    
    var body: some View {
        Image(systemName: icon)
            .font(Font.title.weight(.medium))
            .foregroundColor(editing ? .black : Color(uiColor: .secondaryLabel))
            .padding(.horizontal, design.sizing.large)
            .padding(.vertical, design.sizing.huge)
    }
    
}
