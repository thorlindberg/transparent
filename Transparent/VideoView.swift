import SwiftUI
import AVKit
import AVFoundation

struct VideoView: View {
    
    @Binding var videoURL: URL?
    
    var body: some View {
        ZStack {
            Checkerboard(rows: 18, columns: 32)
                .fill(Color(uiColor: .secondarySystemBackground))
                .background(Color(uiColor: .darkGray))
            if let videoURL {
                VideoPlayer(player: AVPlayer(url: videoURL))
            }
        }
        .aspectRatio(16 / 9, contentMode: .fit)
        .cornerRadius(7)
        .padding(-1)
    }
    
}

extension AVPlayer {
    
    func imageSequence(frames: Int32) -> [UIImage?] {
        
        guard let asset = self.currentItem?.asset else {
            return []
        }
        
        var images: [UIImage?] = []
        
        for second in stride(from: 0, to: Int32(asset.duration.seconds) * frames, by: 1) {
            
            let videoFrameCGImage = try! AVAssetImageGenerator(
                asset: asset
            )
            .copyCGImage(
                at: CMTimeMake(
                    value: Int64(second),
                    timescale: frames
                ),
                actualTime: nil
            )
            
            images.append(
                UIImage(cgImage: videoFrameCGImage)
            )
            
        }

        return images
        
    }
    
}
