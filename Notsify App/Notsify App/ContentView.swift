//
//  ContentView.swift
//  Notsify App
//
//  Created by Kyle Akers and Daniel Meyer on 5/07/24.

import SwiftUI

struct ContentView: View {
    //current page variabe
    @State var currentOption = 0
    var body: some View {
        ScrollView(showsIndicators: true) {
            //switch case statement which changes depending on open page
            switch currentOption {
            case 1:
                GENERALNOTESPAGE(currentOption: $currentOption)
            case 2:
                Text("Sticky notes")
            case 3:
                Text("Mind map")
            default:
                HOMEPAGE(currentOption: $currentOption)
            }
        }
    }
}
//The home page
struct HOMEPAGE: View{
    @Binding var currentOption: Int
    var body: some View{
        GeometryReader { geometry in
            VStack() {
                //CODE 3
                // Creating the side bar for the Home Page
                // Defining object
                Rectangle()
                // Defining object size
                    .frame(width:235, height: 6000)
                // Defining object colour
                    .foregroundColor(Color("NormOrange"))
                // Defining object position
                    .position(x: -1, y: 0)
                
                // Creating the top bar for the Home Page
                // Defining object
                Rectangle()
                // Defining object size
                    .frame(width: geometry.size.width * 2, height: 600)
                // Defining object colour
                    .foregroundColor(Color("DarkOrange"))
                // Defining object position
                    .position(x: 0, y: -175)
                
                // Inserting the image that serves as our application title.
                Image("TitleSet")
                    .resizable()
                    .scaledToFit()
                    .frame(width:425, height: 425)
                    .position(x: geometry.size.width/2, y: 50)
                
                Circle()
                // Creating object border
                    .strokeBorder(Color.black, lineWidth: 1)
                // Defining object colour
                    .background(Circle().fill(Color.white))
                // Defining object size
                    .frame(width: 100, height: 100)
                // Defining object position
                    .position(x: 70, y: 40)
                
                // Inserting our logo image.
                Image("LogoSet")
                    .resizable()
                    .scaledToFit()
                    .frame(width:130, height: 130)
                    .position(x: 67.5, y: 47)
                
                
                
                VStack{
                    //The buttons
                    Button(action: {
                        currentOption = 0
                    }) {
                        Image("HelpButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                        
                        }
                        .buttonStyle(PlainButtonStyle())
                        .position(x:67.5, y:310)
                    
                    //seccond button
                    Button(action: {
                        currentOption = 1
                    }) {
                        Image("HelpButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .position(x:67.5, y:350)
                    
                    //the location of the buttons
                    }
                
                // Creating the help button
                // BUTTON CURRENTLY DOES NOT APPEAR NEEDS FIXING
                Link(destination: URL(string: "https://www.canva.com/design/DAGNBe5W3jc/KvojK8gN0hCMNO4tXyXDNw/view?utm_content=DAGNBe5W3jc&utm_campaign=designshare&utm_medium=link&utm_source=editor#1")!) {
                    Image("HelpButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .position(x: 200, y: 200)
                    
                    
                    
                }
            }
        }
    }
}
struct GENERALNOTESPAGE: View{
    @Binding var currentOption: Int
    var body: some View{
        GeometryReader { geometry in
            VStack{
                //The buttons
                Button(action: {
                    currentOption = 0
                }) {
                    Image("HelpButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                    
                    }
                    .buttonStyle(PlainButtonStyle())
                    .position(x:67.5, y:310)
                
                //seccond button
                Button(action: {
                    currentOption = 1
                }) {
                    Image("HelpButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
                .buttonStyle(PlainButtonStyle())
                .position(x:67.5, y:350)
                
                //the location of the buttons
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
