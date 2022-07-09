import SwiftUI
import AVKit
import AVFoundation

struct ContentView: View {
    
    @StateObject var design = DesignSystem()
    
    @State private var isPickingVideo: Bool = false
    @State private var isExportingGIF: Bool = false
    
    @State private var videoURL: URL? = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
    
    @State private var frames: Int32 = 1
    @State private var size: CGSize = CGSize(width: 1920, height: 1080)
    @State private var filename: String = "filename"
    @State private var isLinked: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: design.sizing.maximum) {
                    VideoView(videoURL: videoURL, frames: frames, size: size)
                    EditView()
                    GroupView {
                        HStack {
                            Text("Duration")
                            Spacer()
                            Text("00:12:08")
                                .foregroundColor(design.palette.placeholder)
                        }
                        Divider()
                        HStack {
                            Text("File size")
                            Spacer()
                            Text("34.5 MB")
                                .foregroundColor(design.palette.placeholder)
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
                    GroupView {
                        HStack(spacing: design.sizing.huge) {
                            VStack(spacing: design.sizing.huge) {
                                HStack {
                                    Text("Width")
                                    Spacer()
                                    TextField("", text: Binding(
                                        get: { "\(size.width)" },
                                        set: { size.width = CGFloat(Double($0)!) }
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
                                        get: { "\(size.height)" },
                                        set: { size.height = CGFloat(Double($0)!) }
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
                    GroupView {
                        HStack {
                            Text("Frames")
                            Spacer()
                            Menu("20 FPS") {
                                Text("10 FPS")
                                Text("20 FPS")
                                Text("30 FPS")
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
                .padding()
            }
            .navigationTitle("Transparent GIF")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isPickingVideo = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $isPickingVideo) {
                        VideoPicker(videoURL: $videoURL)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isExportingGIF = true
                    }) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .disabled(videoURL == nil)
                }
            }
        }
        .preferredColorScheme(.dark)
        .environmentObject(design)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
