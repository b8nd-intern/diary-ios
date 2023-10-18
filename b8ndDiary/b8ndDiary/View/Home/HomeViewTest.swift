//
//  HomeViewTest.swift
//  b8ndDiary
//
//  Created by 이강현 on 10/12/23.
//

import SwiftUI

struct HomeViewTest: View {
    var body: some View {
        PrettyHScrollView(cards:  [
            DiaryModel(id: UUID(), text: "오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데 이번 아이디어가 매우 좋은 것 같아서 기쁘다. 항상 열심히 아이디어 내주는 모습이 멋지고 더 노력 하게 만들어주어 고맙다! ...", color: Color(0xB6E0FF), image: "image"),
            DiaryModel(id: UUID(), text: "오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데 이번 아이디어가 매우 좋은 것 같아서 기쁘다. 항상 열심히 아이디어 내주는 모습이 멋지고 더 노력 하게 만들어주어 고맙다! ...", color: Color(0xE3F2FD), image: "image"),
            DiaryModel(id: UUID(), text: "오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데 이번 아이디어가 매우 좋은 것 같아서 기쁘다. 항상 열심히 아이디어 내주는 모습이 멋지고 더 노력 하게 만들어주어 고맙다! ...", color: Color(0xB6E0FF), image: "image"),
            DiaryModel(id: UUID(), text: "오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데 이번 아이디어가 매우 좋은 것 같아서 기쁘다. 항상 열심히 아이디어 내주는 모습이 멋지고 더 노력 하게 만들어주어 고맙다! ...", color: Color(0xE3F2FD), image: "image"),
            DiaryModel(id: UUID(), text: "오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데 이번 아이디어가 매우 좋은 것 같아서 기쁘다. 항상 열심히 아이디어 내주는 모습이 멋지고 더 노력 하게 만들어주어 고맙다! ...", color: Color(0xFEEF9F), image: "image")
        ])
    }
}

#Preview {
    HomeViewTest()
}
