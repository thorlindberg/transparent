import SwiftUI
import AVKit
import AVFoundation

class DataModel: ObservableObject {
    
    @Published var video: Video = Video()
    
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
    
    var starting: CGFloat = 0
    var ending: CGFloat = 360
    var duration: CGFloat = 360
    
    /*
    var duration: Double? {
        if let player {
            if let item = player.currentItem {
                return item.duration.seconds
            }
        }
        return nil
    }
    */
    
    var frames: [UIImage?] {
        let increments: Int = 10
        if let player { // , let duration
            if !duration.isNaN {
                return stride(
                    from: 0, to: increments, by: 1
                ).map({
                    player.frame(
                        second: Int64(Int(duration) / increments * $0),
                        scale: 1
                    )
                })
            }
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
