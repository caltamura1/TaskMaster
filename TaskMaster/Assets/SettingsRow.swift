//
//  SettingsRow.swift
//  TaskMaster
//
//  Created by Christian Altamura on 6/10/24.
//

import SwiftUI

struct SettingsRow: View {
    
    let imageName: String
    let title: String
    let tintColor: Color
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundStyle(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(colorScheme == .dark ? .white : .primary)
        }
    }
}

#Preview {
    SettingsRow(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
}
