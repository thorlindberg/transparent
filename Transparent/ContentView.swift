import SwiftUI
import AVKit
import AVFoundation

struct ContentView: View {
    
    @State private var isPickingVideo: Bool = false
    
    @State var player = AVPlayer()
    @State var videoURL: URL?
    
    let frames: Int32 = 1
    var imageSequence: [UIImage?] {
        if let videoURL {
            let sequence = AVPlayer(url: videoURL)
                .imageSequence(frames: frames)
            return sequence
        } else {
            return []
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 21) {
                VideoView(videoURL: $videoURL)
                ScrollView(showsIndicators: false) {
                    CustomisationView()
                        .disabled(videoURL == nil)
                }
                .cornerRadius(7)
            }
            .padding()
            .navigationTitle("Transparent GIF")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        videoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4")
                        // isPickingVideo = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $isPickingVideo) {
                        VideoPickerView(videoURL: $videoURL)
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

/*
ScrollView {
    VStack(alignment: .leading) {
        Text("Transparent GIF")
            .font(.title)
            .padding(.bottom)
        Text("Input Video")
            .font(.footnote)
        VideoPlayer(player: AVPlayer(url: videoURL!))
            .aspectRatio(16 / 9, contentMode: .fill)
            .border(.gray)
            .onTapGesture {
                isPickingVideo = true
            }
            .sheet(isPresented: $isPickingVideo) {
                VideoPickerView(videoURL: $videoURL)
            }
            .padding(.bottom)
        Text("Image Sequences")
            .font(.footnote)
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                ForEach(imageSequence, id: \.self) { image in
                    if let image, let transparent = image.removeBackground(returnResult: .finalImage) {
                        VStack {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                            Image(uiImage: transparent)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
            }
        }
        .aspectRatio(16 / 9 / 2, contentMode: .fill)
        .border(.gray)
        .padding(.bottom)
        
    }
    .padding()
    .foregroundColor(.white)
}
.background(Color.black)
*/
