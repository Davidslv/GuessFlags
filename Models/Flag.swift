//
//  Flag.swift
//  GuessFlags
//
//  Created by David Silva on 01/04/2020.
//  Copyright © 2020 David Silva. All rights reserved.
//

import Foundation
import SwiftUI

struct Flag: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var code: String
}

extension Flag {
    var image: Image {
        ImageStore.shared.image(name: name)
    }
}
