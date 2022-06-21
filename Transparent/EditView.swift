import SwiftUI

struct EditView: View {
    var body: some View {
        HStack(spacing: 14) {
            Text("||")
            GeometryReader { proxy in
                Checkerboard(
                    rows: Int(proxy.size.height) / 10,
                    columns: Int(proxy.size.width) / 10
                )
                .fill(Color(uiColor: .secondarySystemBackground))
                .background(Color(uiColor: .darkGray))
            }
            Text("||")
        }
        .foregroundColor(Color(uiColor: .secondarySystemBackground))
        .frame(height: 40)
        .padding(.vertical, 7)
        .padding(.horizontal, 14)
        .padding(-1)
        .background(Color(uiColor: .systemOrange))
        .cornerRadius(7)
    }
}
