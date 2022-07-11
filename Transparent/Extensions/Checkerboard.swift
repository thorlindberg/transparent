import SwiftUI

struct CheckerboardView: View {
    
    @EnvironmentObject var design: DesignModel
    
    var body: some View {
        GeometryReader { proxy in
            CheckerboardShape(
                rows: Int(proxy.size.height) / 10,
                columns: Int(proxy.size.width) / 10
            )
            .fill(design.palette.group)
            .background(design.palette.placeholder)
        }
    }
    
}

struct CheckerboardShape: Shape {
    let rows: Int
    let columns: Int

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // figure out how big each row/column needs to be
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)

        // loop over all rows and columns, making alternating squares colored
        for row in 0 ..< rows {
            for column in 0 ..< columns {
                if (row + column).isMultiple(of: 2) {
                    // this square should be colored; add a rectangle here
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)

                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }

        return path
    }
}
