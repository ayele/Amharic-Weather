//
//  LinearGradient+Sky.swift
//  Amharic Weather
//
//  Created by Amanuel Ayele on 10/14/22.
//

import Foundation
import SwiftUI

extension LinearGradient {
    static var sky: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color("SkyTop"), Color("SkyBottom")]),
                              startPoint: .top,
                              endPoint: .bottom)
    }
}
