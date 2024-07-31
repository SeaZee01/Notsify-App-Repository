//
//  ContentView.swift
//  Notsify App
//
//  Created by Kyle Akers and Daniel Meyer on 5/07/24.

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(showsIndicators: true) {
            GeometryReader { geometry in
                VStack() {
                    //side bar background
                    Rectangle()
                        .frame(width:250, height: 2000)
                        .foregroundColor(Color("NormOrange"))
                        .position(x: -1, y: 0)
                    Rectangle()
                        .frame(width: geometry.size.width * 2, height: 175)
                        .foregroundColor(Color("DarkOrange"))
                        .position(x: 0, y: 0)
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
    }
}
