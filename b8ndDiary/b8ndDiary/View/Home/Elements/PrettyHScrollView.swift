//
//  OnboardingView.swift
//  OnboardingAnimationOne
//
//  Created by Boris on 07.09.2022.
//

import SwiftUI

struct PrettyHScrollView: View {
    
    @State private var currentScrollOffset: CGFloat = 0
    @State private var gestureDragOffset: CGFloat = 0
    @State private var imojiOpacity: CGFloat = 1
    @State private var boardTextOpacity: CGFloat = 1
    @State private var isScrolling: Bool = false
    @State private var timer: Timer?
    
    @State var _activePageIndex: Int = 2
    var activePageIndex: Binding<Int> {
        Binding(
            get: {
                self._activePageIndex
            },
            set: { newValue in
                if newValue <= 1 {
                    var last = self.cards.last!
                    last.id = UUID()
                    self.cards.insert(last, at: 0)
                    self.cards.remove(at: self.cards.count - 1)
                } else if newValue >= self.cards.count - 2 {
                    var first = self.cards.first!
                    first.id = UUID()
                    self.cards.append(first)
                    self.cards.remove(at: 0)
                } else {
                    self._activePageIndex = newValue
                }
            }
        )
    }
    
    @State var cards: [DiaryModel]
    
    let geo: GeometryProxy
    
    let itemPadding: CGFloat = 8
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { timer in
            withAnimation(.easeInOut(duration: 1)) {
                if !isScrolling {
                    self.activePageIndex.wrappedValue += 1
                }
                print(isScrolling)
            }
        }
    }
    
    func restartTimer() {
        stopTimer()
        startTimer()
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    var body: some View {
        VStack {
            //            GeometryReader { geo in
            ZStack {
                HStack(spacing: 0) {
                    Image("side")
                        .resizable()
                        .frame(width: 34, height: geo.size.height / 3.05)
                    Spacer()
                }
                .zIndex(1)
                PagingScrollView(currentPageIndex: self.activePageIndex,
                                 itemsAmount: self.cards.count - 1,
                                 itemScrollableSide: geo.size.width / 1.7,
                                 itemPadding: self.itemPadding,
                                 visibleContentLength: geo.size.width,
                                 currentScrollOffset: $currentScrollOffset,
                                 gestureDragOffset: $gestureDragOffset, isScrolling: $isScrolling, scrollEndCallback: {
                    restartTimer()
                }, content: {
                    ForEach(Array(self.cards.enumerated()), id: \.element) { idx, card in
                        DiaryView(card: card, width: geo.size.width / 1.7, height: geo.size.height / 3.6, imojiOpacity: idx == self.activePageIndex.wrappedValue ?  imojiOpacity : 0.0, boardTextOpacity:  idx == self.activePageIndex.wrappedValue ? boardTextOpacity : 0.0)
                    }
                })
                .frame(height: geo.size.height / 3.6)
                HStack {
                    Spacer()
                    Image("side")
                        .resizable()
                        .rotationEffect(.degrees(180))
                        .scaleEffect(x: 1, y: -1, anchor: .center)
                        .frame(width: 35, height: geo.size.height / 3.05)
                }
                .zIndex(1)
            }
        }
        .padding(0.1)
        .onChange(of: gestureDragOffset) { newValue in
            let imojiFadeOutStartDistance: CGFloat = 35
            let imojiFadeOutDistance: CGFloat = 27
            
            let boardTextFadeOutStartDistance: CGFloat = 30
            let boardTextFadeOutDistance: CGFloat = 90
            
            let gestureDrag = abs(gestureDragOffset)
            withAnimation {
                if gestureDrag > imojiFadeOutStartDistance {
                    imojiOpacity = max(0, (imojiFadeOutStartDistance - gestureDrag) / imojiFadeOutDistance + 1)
                } else {
                    imojiOpacity = 1
                }
                
                if gestureDrag > boardTextFadeOutStartDistance {
                    boardTextOpacity = max(0, (boardTextFadeOutStartDistance - gestureDrag) / boardTextFadeOutDistance + 1)
                } else {
                    boardTextOpacity = 1
                }
            }
        }
        .onAppear {
            stopTimer()
            startTimer()
        }
        //    }
    }
    
    //#Preview {
    //    PrettyHScrollView(cards: [
    //        DiaryModel(id: UUID(), text: "오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데 이번 아이디어가 매우 좋은 것 같아서 기쁘다. 항상 열심히 아이디어 내주는 모습이 멋지고 더 노력 하게 만들어주어 고맙다! ...", color: Colors.Blue1.color, image: "image"),
    //        DiaryModel(id: UUID(), text: "오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데 이번 아이디어가 매우 좋은 것 같아서 기쁘다. 항상 열심히 아이디어 내주는 모습이 멋지고 더 노력 하게 만들어주어 고맙다! ...", color: Colors.Blue1.color, image: "image"),
    //        DiaryModel(id: UUID(), text: "오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데 이번 아이디어가 매우 좋은 것 같아서 기쁘다. 항상 열심히 아이디어 내주는 모습이 멋지고 더 노력 하게 만들어주어 고맙다! ...", color: Colors.Blue1.color, image: "image"),
    //        DiaryModel(id: UUID(), text: "오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데 이번 아이디어가 매우 좋은 것 같아서 기쁘다. 항상 열심히 아이디어 내주는 모습이 멋지고 더 노력 하게 만들어주어 고맙다! ...", color: Colors.Blue1.color, image: "image"),
    //        DiaryModel(id: UUID(), text: "오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데 이번 아이디어가 매우 좋은 것 같아서 기쁘다. 항상 열심히 아이디어 내주는 모습이 멋지고 더 노력 하게 만들어주어 고맙다! ...", color: Colors.Blue1.color, image: "image")
    //    ])
    //}
}
