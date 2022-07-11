import SwiftUI
import AVKit
import AVFoundation

class DataModel: ObservableObject {
    
    @Published var video: Video = Video()
    
}

struct Video: Hashable {
    
    var options: Options = Options()
    
    var url: URL? = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
    
    var player: AVPlayer? {
        if let url {
            return AVPlayer(url: url)
        }
        return nil
    }
    
    var duration: Int64? {
        if let player {
            if let item = player.currentItem {
                if item.status == .readyToPlay {
                    return Int64(item.duration.seconds)
                }
            }
        }
        return nil
    }
    
    var frames: [UIImage?] {
        if let player, let duration {
            return stride(
                from: 0, to: 12, by: 1
            ).map({
                player.frame(
                    second: duration / 12 * $0,
                    scale: 1
                )
            })
        }
        return [nil]
    }
    
    /*
    if let transparent = image.removeBackground(returnResult: .finalImage) {
        return transparent
    }
    */
    
}

struct Options: Hashable {
    var filename: String = "filename"
    var frames: Int32 = 1
    var width: Int = 1920
    var height: Int = 1080
}
