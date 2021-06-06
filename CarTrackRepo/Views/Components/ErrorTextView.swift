//
//  ErrorTextView.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 6/6/21.
//

import SwiftUI

struct ErrorTextView: View {
    var backgroundColor: Color
    var foregroundColor: Color
    private let title: Text

    init(title: Text,
         backgroundColor: Color = Color.black,
         foregroundColor: Color = Color.white
    ) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.title = title
    }

    var body: some View {
        VStack(alignment: .leading) {
            title
                .font(.body)
                .foregroundColor(Color.red)
            .frame(maxWidth: .infinity, alignment: .leading)

        }
    }
}

struct ErrorTextView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorTextView(title: Text("Error error"))
            .padding(.leading)

    }
}
