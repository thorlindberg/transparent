import SwiftUI

struct QualityView: View {
    var body: some View {
        GroupView {
            HStack {
                Text("Frames")
                Spacer()
                Menu("20 FPS") {
                    Text("10 FPS")
                    Text("20 FPS")
                    Text("30 FPS")
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
