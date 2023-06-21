//
//  View+isHidden.swift
//  VB-Product
//
//  Created by My Mac on 20/06/23.
//

import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

