//
//  AdaptivePagingScrollView.swift
//  OnboardingAnimationOne
//
//  Created by Boris on 06.09.2022.
//
import SwiftUI

struct PagingScrollView: View {
    
    private let items: [AnyView]
    private let itemPadding: CGFloat
    private let itemSpacing: CGFloat
    private let itemScrollableSide: CGFloat
    private let itemsAmount: Int
    private let visibleContentLength: CGFloat
    
    private let initialOffset: CGFloat
    private let scrollDampingFactor: CGFloat = 2
    
    @Binding var currentPageIndex: Int
    
    @Binding private var currentScrollOffset: CGFloat
    @Binding private var gestureDragOffset: CGFloat
    
    @Binding var isScrolling: Bool
    
    private let scrollEndCallback: () -> Void
    
    private func countOffset(for pageIndex: Int) -> CGFloat {
        
        let activePageOffset = CGFloat(pageIndex) * (itemScrollableSide + itemPadding)
        return initialOffset - activePageOffset
    }
    
    private func countPageIndex(for offset: CGFloat) -> Int {
        
        guard itemsAmount > 0 else { return 0 }
        
        let offset = countLogicalOffset(offset)
        let floatIndex = (offset)/(itemScrollableSide + itemPadding)
        
        var index = Int(round(floatIndex))
        if max(index, 0) > itemsAmount {
            index = itemsAmount
        }
        
        return min(max(index, 0), itemsAmount - 1)
    }
    
    private func countCurrentScrollOffset() -> CGFloat {
        return countOffset(for: currentPageIndex) + gestureDragOffset
    }
    
    private func countLogicalOffset(_ trueOffset: CGFloat) -> CGFloat {
        return (trueOffset-initialOffset) * -1.0
    }
    
    private func changeFocus() {
        withAnimation {
            currentScrollOffset = countOffset(for: currentPageIndex)
        }
    }
    
    init<A: View>(currentPageIndex: Binding<Int>,
                  itemsAmount: Int,
                  itemScrollableSide: CGFloat,
                  itemPadding: CGFloat,
                  visibleContentLength: CGFloat,
                  currentScrollOffset: Binding<CGFloat>,
                  gestureDragOffset: Binding<CGFloat>,
                  isScrolling: Binding<Bool>,
                  scrollEndCallback: @escaping () -> Void,
                  @ViewBuilder content: () -> A) {
        let views = content()
        self.items = [AnyView(views)]
        
        self._currentPageIndex = currentPageIndex
        self._currentScrollOffset = currentScrollOffset
        self._gestureDragOffset = gestureDragOffset
        
        self.itemsAmount = itemsAmount
        self.itemSpacing = itemPadding
        self.itemScrollableSide = itemScrollableSide
        self.itemPadding = itemPadding
        self.visibleContentLength = visibleContentLength
        
        let itemRemain = (visibleContentLength-itemScrollableSide-2*itemPadding)/2
        self.initialOffset = itemRemain + itemPadding
        self._isScrolling = isScrolling
        self.scrollEndCallback = scrollEndCallback
    }
    
    var body: some View {
        GeometryReader { _ in
            HStack(alignment: .center, spacing: itemSpacing) {
                ForEach(items.indices, id: \.self) { itemIndex in
                    items[itemIndex].frame(width: itemScrollableSide)
                }
            }
        }
        .onAppear {
            currentScrollOffset = countOffset(for: currentPageIndex)
        }
        .frameModifier(visibleContentLength, currentScrollOffset)
        .simultaneousGesture(
            DragGesture(minimumDistance: 1, coordinateSpace: .local)
                .onChanged { value in
                    gestureDragOffset = value.translation.width
                    currentScrollOffset = countCurrentScrollOffset()
                    isScrolling = true
                }
                .onEnded { value in
                    scrollEndCallback()
                    let cleanOffset = (value.predictedEndTranslation.width - gestureDragOffset)
                    let velocityDiff = cleanOffset * scrollDampingFactor
                    
                    var newPageIndex = countPageIndex(for: currentScrollOffset + velocityDiff)
                    
                    let currentItemOffset = CGFloat(currentPageIndex) * (itemScrollableSide + itemPadding)
                    
                    if currentScrollOffset < -(currentItemOffset),
                       newPageIndex == currentPageIndex {
                        newPageIndex += 1
                    }
                    
                    isScrolling = false
                    
                    gestureDragOffset = 0
                    
                    withAnimation(.interpolatingSpring(mass: 0.1,
                                                       stiffness: 20,
                                                           damping: 10,
                                                           initialVelocity: 0)) {
                        self.currentPageIndex = newPageIndex
                        self.currentScrollOffset = self.countCurrentScrollOffset()
                    }
                }
        )
        .contentShape(Rectangle())
    }
}
