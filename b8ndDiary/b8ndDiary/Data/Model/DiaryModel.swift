//
//  OnboardingCard.swift
//  OnboardingAnimationOne
//
//  Created by Boris on 07.09.2022.
//

import SwiftUI

struct DiaryModel: Identifiable, Equatable, Hashable {

    var id: Int
    var text: String
    var color: Color
    var image: String
    var uuid: UUID
}
