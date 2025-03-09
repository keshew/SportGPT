import SwiftUI

extension Text {
    func EpilogueRegular(size: CGFloat,
                       color: Color = .white) -> some View {
        self.font(.custom("Epilogue-Regular", size: size))
            .foregroundColor(color)
    }
    
    func EpilogueBold(size: CGFloat,
                color: Color = .white) -> some View {
        self.font(.custom("Epilogue-Regular", size: size).bold())
            .foregroundColor(color)
    }
}
