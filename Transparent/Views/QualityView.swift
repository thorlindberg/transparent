import SwiftUI

struct QualityView: View {
    
    @Binding var frames: Int32
    
    var body: some View {
        GroupView {
            HStack {
                Text("Frames")
                Spacer()
                Menu("\(frames) FPS") {
                    ForEach(1...30, id: \.self) { count in
                        Button(action: {
                            frames = Int32(count)
                        }) {
                            Label(
                                "\(count)",
                                systemImage: frames == Int32(count) ? "checkmark" : ""
                            )
                        }
                    }
                }
            }
            Divider()
            HStack {
                Text("Quality")
                Spacer()
                Menu("100 %") {
                    Text("25 %")
                    Text("50 %")
                    Text("100 %")
                }
            }
            Divider()
            HStack {
                Text("Loops")
                Spacer()
                Menu("Infinite") {
                    Text("Infinite")
                    Text("5")
                    Text("10")
                }
            }
        }
    }
        
}
