import SwiftUI
import AVKit
import AVFoundation

struct ContentView: View {
    
    @StateObject var design = DesignModel()
    @StateObject var data = DataModel()
    
    @State private var isPickingVideo: Bool = false
    @State private var isExportingGIF: Bool = false
    
    @State private var videoURL: URL? = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
    
    @State private var frames: Int32 = 1
    @State private var size: CGSize = CGSize(width: 1920, height: 1080)
    @State private var filename: String = "filename"
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: design.sizing.maximum) {
                    VideoView(videoURL: videoURL, frames: frames, size: size)
                    EditView()
                    InfoView(filename: $filename)
                    SizeView(size: $size)
                    QualityView()
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
