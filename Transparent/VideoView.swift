import SwiftUI
import AVKit
import AVFoundation

//
//  1. video is loaded
//  2. video is converted to image sequence, one frame at a time
//  - ML inference is applied to remove background from frame
//  - non-transparent frame is presented
//  3. reverse presentation of transparent frames while removing background
//  - timed reversed presentation of frames
//  - linear horizontal removal of background
//

struct VideoView: View {
    
    let videoURL: URL?
    let frames: Int32
    
    private var player: AVPlayer? {
        if let videoURL {
            return AVPlayer(url: videoURL)
        }
        return nil
    }
    
    private var duration: Double? {
        if let player {
            if let item = player.currentItem {
                return item.duration.seconds
            }
            return nil
        }
        return nil
    }
    
    private var currentFrame: UIImage? {
        if let player, let duration {
            for second in stride(from: 0, to: duration, by: 1) {
                if let image = player.frame(
                    second: Int64(second),
                    scale: 1
                ) {
                    if let transparent = image.removeBackground(returnResult: .finalImage) {
                        return transparent
                    }
                }
            }
        }
        return nil
    }
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Checkerboard(
                    rows: Int(proxy.size.height) / 10,
                    columns: Int(proxy.size.width) / 10
                )
                .fill(Color(uiColor: .secondarySystemBackground))
                .background(Color(uiColor: .darkGray))
            }
            /*
            if let videoURL {
                VideoPlayer(player: AVPlayer(url: videoURL))
            }
            */
            if let currentFrame {
                Image(uiImage: currentFrame)
                    .resizable()
                    .scaledToFit()
            }
        }
        .aspectRatio(16 / 9, contentMode: .fit)
        .cornerRadius(7)
        .padding(-1)
    }
    
}
