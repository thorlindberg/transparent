import SwiftUI

struct InfoView: View {
    
    @EnvironmentObject var design: DesignModel
    
    @Binding var filename: String
    
    var body: some View {
        GroupView {
            HStack {
                Text("Duration")
                Spacer()
                Text("00:12:08")
                    .foregroundColor(design.palette.placeholder)
            }
            Divider()
            HStack {
                Text("File size")
                Spacer()
                Text("34.5 MB")
                    .foregroundColor(design.palette.placeholder)
            }
            Divider()
            HStack {
                Text("File name")
                Spacer()
                HStack(spacing: 0) {
                    TextField("", text: $filename)
                        .keyboardType(.alphabet)
                        .multilineTextAlignment(.trailing)
                    Text(".gif")
                }
                .foregroundColor(.accentColor)
            }
        }
    }
    
}
