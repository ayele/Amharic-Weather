//
//  AboutView.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 10/6/22.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Amet tellus cras adipiscing enim eu turpis egestas. Amet cursus sit amet dictum sit amet. Amet nisl purus in mollis. Non enim praesent elementum facilisis leo vel fringilla. Massa sed elementum tempus egestas sed sed. Felis eget nunc lobortis mattis aliquam faucibus.")
            
            Text("Amet tellus cras adipiscing enim eu turpis egestas. Amet cursus sit amet dictum sit amet. Amet nisl purus in mollis. Non enim praesent elementum facilisis leo vel fringilla. Massa sed elementum tempus egestas sed sed. Felis eget nunc lobortis mattis aliquam faucibus.")
            
            Spacer()
        }
        .navigationTitle("About")
        .padding()
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AboutView()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
