import SwiftUI
import AVKit
import AVFoundation

extension AVPlayer {
    
    func frame(second: Int64, scale: Int32) -> UIImage? {
        
        guard let asset = self.currentItem?.asset else {
            return nil
        }
        
        let videoFrameCGImage = try! AVAssetImageGenerator(
            asset: asset
        )
        .copyCGImage(
            at: CMTimeMake(
                value: second, timescale: scale
            ),
            actualTime: nil
        )
        
        return UIImage(cgImage: videoFrameCGImage)
        
    }
    
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

