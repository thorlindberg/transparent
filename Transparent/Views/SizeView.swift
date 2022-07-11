import SwiftUI

struct SizeView: View {
    
    @EnvironmentObject var design: DesignModel
    
    @Binding var width: Int
    @Binding var height: Int
    
    @State private var isLinked: Bool = false
    
    var body: some View {
        GroupView {
            HStack(spacing: design.sizing.huge) {
                VStack(spacing: design.sizing.huge) {
                    HStack {
                        Text("Width")
                        Spacer()
                        TextField("", text: Binding(
                            get: { "\(width)" },
                            set: { width = Int($0)! }
                        ))
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
                        TextField("", text: Binding(
                            get: { "\(height)" },
                            set: { height = Int($0)! }
                        ))
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.accentColor)
                        Text("px")
                            .foregroundColor(.accentColor)
                    }
                }
                VStack(spacing: design.sizing.huge) {
                    HStack {
                        Divider()
                    }
                    Button(action: {
                        isLinked.toggle()
                    }) {
                        Image(systemName: "link")
                    }
                    .opacity(isLinked ? 1 : 0.3)
                    HStack {
                        Divider()
                    }
                }
            }
            Divider()
            HStack(spacing: design.sizing.huge) {
                Image(systemName: "tortoise.fill")
                Slider(value: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant(10)/*@END_MENU_TOKEN@*/)
                Image(systemName: "hare.fill")
            }
        }
    }
    
}
