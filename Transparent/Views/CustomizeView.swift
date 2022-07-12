import SwiftUI

struct CustomizeView: View {
    
    @Binding var video: Video
    
    var body: some View {
        InfoView(
            storage: video.storage,
            duration: video.duration,
            starting: video.starting,
            ending: video.ending,
            filename: $video.options.filename
        )
        SizeView(
            width: $video.options.width,
            height: $video.options.height
        )
        QualityView(
            frames: $video.options.frames
        )
    }
    
}

struct GroupView<Content: View>: View {
    
    @EnvironmentObject var design: DesignModel
    
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

struct InfoView: View {
    
    @EnvironmentObject var design: DesignModel
    
    let storage: Int?
    let duration: CGFloat
    let starting: CGFloat
    let ending: CGFloat
    
    @Binding var filename: String
    
    var body: some View {
        GroupView {
            HStack {
                Text("Starting point")
                Spacer()
                Text("\(Int(starting))s")
                    .foregroundColor(design.palette.placeholder)
            }
            Divider()
            HStack {
                Text("Ending point")
                Spacer()
                Text("\(Int(ending))s")
                    .foregroundColor(design.palette.placeholder)
            }
            Divider()
            HStack {
                Text("Duration")
                Spacer()
                Text("\(Int(ending - starting))s")
                    .foregroundColor(design.palette.placeholder)
            }
            Divider()
            HStack {
                Text("File size")
                Spacer()
                if let storage {
                    Text("\(storage)")
                        .foregroundColor(design.palette.placeholder)
                } else {
                    ProgressView()
                }
            }
            Divider()
            HStack {
                Text("File name")
                Spacer()
                HStack(spacing: 0) {
                    TextField("", text: $filename)
                        .keyboardType(.alphabet)
                        .multilineTextAlignment(.trailing)
                    Text(".gif")
                }
                .foregroundColor(.accentColor)
            }
        }
    }
    
}

struct SizeView: View {
    
    @EnvironmentObject var design: DesignModel
    
    @Binding var width: Int
    @Binding var height: Int
    
    @State private var isLinked: Bool = false
    
    var body: some View {
        GroupView {
            HStack(spacing: design.sizing.huge) {
                VStack(spacing: design.sizing.huge) {
                    HStack {
                        Text("Width")
                        Spacer()
                        TextField("", text: Binding(
                            get: { "\(width)" },
                            set: { width = Int($0)! }
                        ))
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.accentColor)
                        Text("px")
                            .foregroundColor(.accentColor)
                    }
                    Divider()
                    HStack {
                        Text("Height")
                        Spacer()
                        TextField("", text: Binding(
                            get: { "\(height)" },
                            set: { height = Int($0)! }
                        ))
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.accentColor)
                        Text("px")
                            .foregroundColor(.accentColor)
                    }
                }
                VStack(spacing: design.sizing.huge) {
                    HStack {
                        Divider()
                    }
                    Button(action: {
                        isLinked.toggle()
                    }) {
                        Image(systemName: "link")
                    }
                    .opacity(isLinked ? 1 : 0.3)
                    HStack {
                        Divider()
                    }
                }
            }
            Divider()
            HStack(spacing: design.sizing.huge) {
                Image(systemName: "tortoise.fill")
                Slider(value: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(10)/*@END_MENU_TOKEN@*/)
                Image(systemName: "hare.fill")
            }
        }
    }
    
}

struct QualityView: View {
    
    @Binding var frames: Int32
    
    var body: some View {
        GroupView {
            HStack {
                Text("Frames")
                Spacer()
                Menu("\(frames) FPS") {
                    ForEach(1...30, id: \.self) { count in
                        Button(action: {
                            frames = Int32(count)
                        }) {
                            Label(
                                "\(count)",
                                systemImage: frames == Int32(count) ? "checkmark" : ""
                            )
                        }
                    }
                }
            }
            Divider()
            HStack {
                Text("Quality")
                Spacer()
                Menu("100 %") {
                    Text("25 %")
                    Text("50 %")
                    Text("100 %")
                }
            }
            Divider()
            HStack {
                Text("Loops")
                Spacer()
                Menu("Infinite") {
                    Text("Infinite")
                    Text("5")
                    Text("10")
                }
            }
        }
    }
    
}
