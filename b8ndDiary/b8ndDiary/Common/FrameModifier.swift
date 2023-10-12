//
//  FrameModifier.swift
//  OnboardingAnimationOne
//
//  Created by Mariya Pankova on 19.07.2023.
//

import SwiftUI

struct FrameModifier: ViewModifier {
    let contentLength: CGFloat
    let currentScrollOffset: CGFloat

    init (contentLength: CGFloat,
          visibleContentLength: CGFloat,
          currentScrollOffset: CGFloat) {
        self.contentLength = contentLength
        self.currentScrollOffset = currentScrollOffset
    }

    func body(content: Content) -> some View {
        return content
            .frame(width: contentLength)
            .offset(x: self.currentScrollOffset, y: 0)
    }
}
