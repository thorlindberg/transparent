import SwiftUI
import AVKit
import AVFoundation
import Shiny

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
    
    @EnvironmentObject var design: DesignSystem
    
    let videoURL: URL?
    let frames: Int32
    let size: CGSize
    
    private var player: AVPlayer? {
        if let videoURL {
            return AVPlayer(url: videoURL)
        }
        return nil
    }
    
    @State private var hasBackground: Bool = true
    
    /*
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
    */
    
    var body: some View {
        ZStack {
            CheckerboardView()
            /*
            if let videoURL {
                VideoPlayer(player: AVPlayer(url: videoURL))
            }
            */
            GeometryReader { proxy in
                ZStack {
                    if hasBackground {
                        Image("sample")
                            .resizable()
                            .scaledToFill()
                            .frame(height: proxy.size.height)
                            .mask(
                                LinearGradient(
                                    colors: [
                                        Color(
                                            red: 0, green: 0, blue: 0,
                                            opacity: 0.4
                                        ),
                                        .black,
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            // .mask(Rectangle().shiny(Gradient(colors: [.black, .clear])))
                    }
                    if let transparent = UIImage(imageLiteralResourceName: "sample").removeBackground(returnResult: .finalImage) {
                        Image(uiImage: transparent)
                            .resizable()
                            .scaledToFill()
                            .frame(height: proxy.size.height)
                    }
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    hasBackground.toggle()
                                }
                            }) {
                                Image(systemName: hasBackground ? "eye.fill" : "eye")
                                    .padding(design.sizing.large)
                            }
                            .tint(hasBackground ? .accentColor : .white)
                            .background(.ultraThinMaterial)
                            .cornerRadius(design.sizing.medium)
                        }
                    }
                    .padding(design.sizing.large)
                }
            }
            .clipped()
            .aspectRatio(size.width / size.height, contentMode: .fit)
        }
        .aspectRatio(16 / 9, contentMode: .fit)
        .stroked()
    }
    
}
