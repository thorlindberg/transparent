import SwiftUI
import AVKit
import AVFoundation

struct ContentView: View {
    
    @State private var isPickingVideo: Bool = false
    @State private var videoURL: URL?
    @State private var frames: Int32 = 1
    
    var body: some View {
        NavigationView {
            VStack(spacing: 21) {
                VideoView(videoURL: videoURL, frames: frames)
                    .onTapGesture {
                        videoURL = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
                    }
                CustomisationView(videoURL: videoURL)
            }
            .padding()
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle("Transparent GIF")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // isPickingVideo = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $isPickingVideo) {
                        VideoPicker(videoURL: $videoURL)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // export
                    }) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .disabled(videoURL == nil)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
