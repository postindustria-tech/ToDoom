//
//  CountsView.swift
//  ToDoom
//
//  Created by Paul Dmitryev on 29.08.2021.
//

import SwiftUI

struct CountsView: View {
    let first: Int
    let second: Int
    var body: some View {
        HStack(spacing: 0) {
            Text("\(first)")
                .padding(.init(top: 8, leading: 12, bottom: 8, trailing: 6))
            Text("\(second)")
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Capsule().fill(Color.red))
        }
        .font(.headline)
        .foregroundColor(.white)
        .background(Capsule().fill(Color.blue))
    }
}

struct CountsView_Previews: PreviewProvider {
    static var previews: some View {
        CountsView(first: 15, second: 101)
            .previewLayout(.sizeThatFits)
    }
}
