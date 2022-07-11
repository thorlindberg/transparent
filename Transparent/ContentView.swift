import SwiftUI
import AVKit
import AVFoundation

struct ContentView: View {
    
    @StateObject var design = DesignModel()
    @StateObject var data = DataModel()
    
    @State private var isPickingVideo: Bool = false
    @State private var isExportingGIF: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: design.sizing.maximum) {
                    VideoView(video: data.video)
                    EditView(frames: data.video.frames)
                    InfoView(
                        duration: data.video.duration,
                        filename: $data.video.options.filename
                    )
                    SizeView(
                        width: $data.video.options.width,
                        height: $data.video.options.height
                    )
                    QualityView()
                }
                .padding()
            }
            .navigationTitle("Transparent GIF")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        print(data.video.duration)
                        isPickingVideo = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $isPickingVideo) {
                        VideoPicker(videoURL: $data.video.url)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isExportingGIF = true
                    }) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .disabled(data.video.url == nil)
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
