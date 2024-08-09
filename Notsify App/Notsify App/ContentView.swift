//
//  ContentView.swift
//  Notsify App
//
//  Created by Kyle Akers and Daniel Meyer on 5/07/24.

// Importing the Swift library
import SwiftUI

struct ContentView: View {
    // Defining the current page variable
    @State var currentPage = 0
    var body: some View {
        ScrollView(showsIndicators: true) {
            // Switching case statements to dictate the application page
            switch currentPage {
            case 1:
                GENERALNOTESPAGE(currentPage: $currentPage)
            case 2:
                Text("Sticky notes") // When trying to create this page, a request error occures with Rectangle()
            case 3:
                Text("Mind map")
            default:
                HOMEPAGE(currentPage: $currentPage)
            }
        }
    }
}
// Creating the Home page for the application
struct HOMEPAGE: View{
    @Binding var currentPage: Int
    var body: some View{
        GeometryReader { geometry in
            VStack() {

                // Creating the side bar for the Home Page
                // Defining the object
                Rectangle()
                // Defining the object size
                    .frame(width:235, height: 6000)
                // Defining the object colour
                    .foregroundColor(Color("NormOrange"))
                // Defining the object position
                    .position(x: -1, y: 0)
                
                // Creating the top bar for the Home Page
                // Defining the object
                Rectangle()
                // Defining the object size
                    .frame(width: geometry.size.width * 2, height: 600)
                // Defining the object colour
                    .foregroundColor(Color("DarkOrange"))
                // Defining the object position
                    .position(x: 0, y: -175)
                
                // Inserting the image that serves as our application title.
                Image("TitleSet")
                    // Resizing the image
                    .resizable()
                    .scaledToFit()
                    .frame(width:425, height: 425)
                    // Changing the image position
                    .position(x: geometry.size.width/2, y: 50)
                
                Circle()
                // Creating the object border
                    .strokeBorder(Color.black, lineWidth: 1)
                // Defining the object colour
                    .background(Circle().fill(Color.white))
                // Defining the object size
                    .frame(width: 100, height: 100)
                // Defining the object position
                    .position(x: 70, y: 40)
                
                // Inserting our logo image
                Image("LogoSet")
                    // Resizing the image
                    .resizable()
                    .scaledToFit()
                    .frame(width:130, height: 130)
                    // Changing the image position
                    .position(x: 67.5, y: 47)
                
                // Creating the first button for the Home page
                // Defining the object for button background
                Rectangle()
                    .cornerRadius(15)
                // Defining the object size
                    .frame(width: 90, height: 90)
                // Defining the object colour
                    .foregroundColor(Color("DarkOrange"))
                // Defining the object position
                    .position(x:58, y:175)
                
                // Defining button actions to change page
                Button(action: {
                    currentPage = 0
                }) {
                    // Adding and resizing the icon that the button will present as
                    Image("HomeIcon")
                        // Resizing the icon image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 77, height: 77)
                    }
                    // Styling and repositioning the button
                    .buttonStyle(PlainButtonStyle())
                    .position(x:58, y:168)
                    
                // Creating the second button for the Home page
                // Defining the object for button background
                Rectangle()
                    .cornerRadius(15)
                // Defining the object size
                    .frame(width: 90, height: 90)
                // Defining the object colour
                    .foregroundColor(Color("DarkOrange"))
                // Defining the object position
                    .position(x:58, y:275)
                
                // Defining button actions to change page
                Button(action: {
                    currentPage = 1
                }) {
                    // Adding and resizing the icon that the button will present as
                    Image("GeneralIcon")
                        // Resizing the icon image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 77, height: 77)
                }
                // Styling and repositioning the button
                .buttonStyle(PlainButtonStyle())
                .position(x:58, y:267)
                
                // Creating the help button
                // Labelling the button with the link to our website
                Link("Help", destination: URL(string: "https://www.canva.com/design/DAGNBe5W3jc/KvojK8gN0hCMNO4tXyXDNw/view?utm_content=DAGNBe5W3jc&utm_campaign=designshare&utm_medium=link&utm_source=editor#1")!)
                    // Changing the colour and shape of the button
                    .padding()
                    .background(Color("NormOrange"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    // Changing the position of the button
                    .position(x: geometry.size.width*0.97, y: geometry.size.height*64)
                    
                }
            }
        }
    }

struct GENERALNOTESPAGE: View{
    @Binding var currentPage: Int
    var body: some View{
        GeometryReader { geometry in
            VStack{
                // Will comment when we build on this more - as this code might change.
                Button(action: {
                    currentPage = 0
                }) {
                    Image("HomeIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                        .layoutPriority(1)
                    
                    }
                    .buttonStyle(PlainButtonStyle())
                    .position(x:67.5, y:310)
                
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
