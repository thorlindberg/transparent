import SwiftUI

struct InfoView: View {
    
    @EnvironmentObject var design: DesignModel
    
    let storage: Int?
    let duration: Int64?
    
    @Binding var filename: String
    
    var body: some View {
        GroupView {
            HStack {
                Text("Duration")
                Spacer()
                if let duration {
                    Text("\(duration)")
                        .foregroundColor(design.palette.placeholder)
                } else {
                    ProgressView()
                }
            }
            Divider()
            HStack {
                Text("File size")
                Spacer()
                if let storage {
                    Text("\(storage)")
                        .foregroundColor(design.palette.placeholder)
                } else {
                    ProgressView()
                }
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
