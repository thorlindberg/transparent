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
    
    @EnvironmentObject var design: DesignModel
    
    @State private var hasBackground: Bool = true
    
    let video: Video
    
    var body: some View {
        ZStack {
            CheckerboardView()
            if let player = video.player {
                VideoPlayer(player: player)
                    .onAppear {
                        player.play()
                    }
                    .onDisappear {
                        player.pause()
                    }
            }
            VStack {
                HStack {
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
                    .cornerRadius(design.sizing.large - design.sizing.medium)
                    Spacer()
                }
                Spacer()
            }
            .padding(design.sizing.large)
        }
        .aspectRatio(16 / 9, contentMode: .fit)
        .stroked()
        /*
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
                        .mask(Rectangle().shiny(Gradient(colors: [.black, .clear])))
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
        .background(CheckerboardView())
        .aspectRatio(16 / 9, contentMode: .fit)
        .stroked()
        */
    }
    
}
