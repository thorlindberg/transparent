import SwiftUI

struct CustomisationView: View {
    
    @State private var width: String = "1920"
    @State private var height: String = "1080"
    
    var body: some View {
        VStack(spacing: 21) {
            GroupView {
                HStack {
                    Text("Duration")
                    Spacer()
                    Text("00:12:08")
                        .foregroundColor(Color(uiColor: .placeholderText))
                }
                Divider()
                HStack {
                    Text("File size")
                    Spacer()
                    Text("34.5 MB")
                        .foregroundColor(Color(uiColor: .placeholderText))
                }
                Divider()
                HStack {
                    Text("File name")
                    Spacer()
                    HStack(spacing: 0) {
                        TextField("", text: $height)
                            .keyboardType(.alphabet)
                            .multilineTextAlignment(.trailing)
                        Text(".gif")
                    }
                    .foregroundColor(.accentColor)
                }
                Divider()
                HStack {
                    Text("Optimisation")
                    Spacer()
                    Menu("100 %") {
                        Text("50 %")
                        Text("100 %")
                        Text("150 %")
                    }
                }
            }
            GroupView {
                HStack {
                    Text("Width")
                    Spacer()
                    TextField("", text: $width)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.accentColor)
                    Text("px")
                        .foregroundColor(.accentColor)
                }
                Divider()
                HStack {
                    Text("Height")
                    Spacer()
                    TextField("", text: $height)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.accentColor)
                    Text("px")
                        .foregroundColor(.accentColor)
                }
                Divider()
                HStack {
                    Text("Speed")
                    Spacer()
                    Menu("100 %") {
                        Text("50 %")
                        Text("100 %")
                        Text("150 %")
                    }
                }
            }
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
    
}
