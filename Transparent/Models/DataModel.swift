import SwiftUI
import AVKit
import AVFoundation

class DataModel: ObservableObject {
    
    @Published var video: Video = Video()
    @Published var options: Options = Options()
    @Published var frames: [Frame] = []
    
}

struct Video: Hashable {
    
    var options: Options = Options()
    
    var url: URL?
    
    var player: AVPlayer? {
        if let url {
            return AVPlayer(url: url)
        }
        return nil
    }
    
    var duration: CGFloat?
    
    var starting: CGFloat = 0
    
    var ending: CGFloat = 616
    
    var frames: [UIImage?] {
        let increments: Int = 10
        if let player, let duration {
            return stride(
                from: 0, to: increments, by: 1
            ).map({
                player.frame(
                    second: Int64(Int(duration) / increments * $0),
                    scale: 1
                )
            })
        }
        return [nil]
    }
    
    var storage: Int? {
        return nil
    }
    
}

struct Options: Hashable {
    var filename: String = "filename"
    var frames: Int32 = 1
    var width: Int = 1920
    var height: Int = 1080
}

struct Frame: Hashable {
    var base: UIImage?
    var transparent: UIImage? {
        if let base {
            if let transparent = base.removeBackground(returnResult: .finalImage) {
                return transparent
            }
        }
        return nil
    }
}
