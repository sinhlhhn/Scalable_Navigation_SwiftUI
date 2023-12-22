//
//  ErrorView.swift
//  ReplaceNotificationCenterWithAdapter
//
//  Created by SinhLH.FHN on 12/12/2023.
//

import SwiftUI

struct PresentedView: View {
    
    var selection: (() -> Void)?
    
    var body: some View {
        NavigationStack {
            Button {
                selection?()
            } label: {
                Text("Dismiss")
            }
            .navigationTitle("Presented View")
        }
    }
}
