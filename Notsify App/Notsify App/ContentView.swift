//
//  ContentView.swift
//  Notsify App
//
//  Created by Kyle Akers and Daniel Meyer on 5/07/24.

// Importing the Swift library
import SwiftUI
//Libary for manipulating the .txt files
import Cocoa
extension String{
    //get the filename from a string
    func fileName() -> String{
        //finds the file name by deleting the file extension attached
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }
    //get the file type from the string
    func fileType() -> String{
        //finds the file type by specifying for the file extension
        return URL(fileURLWithPath: self).pathExtension
    }
}

//function which reads the text file and is recycable for more efficency when codding.
func readingFile(inputFile: String) -> String{
    //breaking up the file into two components
    //the file name
    let nameFile =  inputFile.fileName()
    //the file type
    let typeFile = inputFile.fileType()
    //getting the location of the file
    let filelocationURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    let readFile = filelocationURL.appendingPathComponent(nameFile).appendingPathExtension(typeFile)
    
    //reading the data on the text file
    do {
        let savedInfo = try String(contentsOf: readFile)
        return savedInfo
        //if the folder doesn't exist
    } catch {
        //if the file doesn't exist then return the fact that it doesn't exiat
        return "Write text here:"
    }
}
//function which writes a text file and can create files. Taking 2 parameters, The file name and data on the text file.
func writeFile(Filename: String, Data: String){
    //breaking up the file into two components
    //the file name
    let nameFile =  Filename.fileName()
    //the file type
    let typeFile = Filename.fileType()
    //getting the location of the file
    let filelocationURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let Filename = filelocationURL.appendingPathComponent(nameFile).appendingPathExtension(typeFile)
    
    //saving the data
    guard let data = Data.data(using: .utf8) else{
        print("can't convert string to data")
        return
    }
    //printing to the console whether the data transmision was sucsesfull and if so how many bytes, else an error which specifies why it failed
    do{
        try data.write(to: Filename)
        print("data written: \(data)")
    } catch{
        print(error.localizedDescription)
    }
}

//function which allows people to delete files
func deleteFile(_ fileToDelete: String){
    //breaking up the filename and extension
    //the file name
    let nameFile =  fileToDelete.fileName()
    //the file type
    let typeFile = fileToDelete.fileType()
    //getting the location of the file
    let filelocationURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let Filename = filelocationURL.appendingPathComponent(nameFile).appendingPathExtension(typeFile)
    
    do {
        try FileManager.default.removeItem(at: Filename)
    }catch{
        print(error.localizedDescription)
    }
}

//Main Content View
struct ContentView: View {
    // Defining the current page variable
    @State var currentPage = 0
    // defining the variable for the general notes string
    @State var GeneralNoteText: String = readingFile(inputFile: "GeneralNotesText")
    // Defining sticky note number variable
    @State var noteNumber = 0
    // Defining variable for sticky notes string
    @State private var StickyText1: String = readingFile(inputFile: "StickyText1")
    @State private var StickyText2: String = readingFile(inputFile: "StickyText2")
    @State private var StickyText3: String = readingFile(inputFile: "StickyText3")
    @State private var StickyText4: String = readingFile(inputFile: "StickyText4")
    @State private var StickyText5: String = readingFile(inputFile: "StickyText5")
    
    //variable for the position of all 5 sticky notes
    @State var StickyPos1: CGSize = CGSize(width: 200, height: 200)
    @State var StickyPos2: CGSize = CGSize(width: 200, height: 200)
    @State var StickyPos3: CGSize = CGSize(width: 200, height: 200)
    @State var StickyPos4: CGSize = CGSize(width: 200, height: 200)
    @State var StickyPos5: CGSize = CGSize(width: 200, height: 200)
    var body: some View {
        ScrollView(showsIndicators: true) {
            // Switching case statements to dictate the application page
            switch currentPage {
            case 1:
                GENERALNOTESPAGE(currentPage: $currentPage, GeneralNoteText: $GeneralNoteText)
                GeneralNotePageButtons
                textEditorView
            case 2:
                PageOutline
                STICKYNOTEPAGE(currentPage: $currentPage, noteNumber: $noteNumber, StickyText1: $StickyText1, StickyText2: $StickyText2, StickyText3: $StickyText3, StickyText4: $StickyText4, StickyText5: $StickyText5, StickyPos1: $StickyPos1, StickyPos2: $StickyPos2, StickyPos3: $StickyPos3, StickyPos4: $StickyPos4, StickyPos5: $StickyPos5)
                StickyNotePageButtons
            case 3:
                MINDMAP(currentPage: $currentPage)
                MindMapButtons
            default:
                HOMEPAGE(currentPage: $currentPage)
                HomePageButtons
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
//General notes page for the application
struct GENERALNOTESPAGE: View{
    //variable for changing pages
    @Binding var currentPage: Int
    //variable for getting the general note text
    @Binding var GeneralNoteText: String
    var body: some View{
        GeometryReader { geometry in
            VStack{
                // Creating the side bar for the Home Page
                // Defining the object
                Rectangle()
                // Defining the object size
                    .frame(width:155, height: 6000)
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
                
                // Defining button actions to save as a new file (Can't be placed in the generalNotesButtons because it need access to the GeneralNotesText Variable which is a binding var that can't be used in extension pages)
                Button(action: {
                    writeFile(Filename: "GeneralNotesText", Data: GeneralNoteText)
                    let myData = readingFile(inputFile: "GeneralNotesText")
                    print(myData)
                }) {
                    // Adding and resizing the icon that the button will present as
                    Text("Save")
                        // Resizing the icon image
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                        .background(Color("DarkOrange"))
                        .cornerRadius(10)
                    }
                    // Styling and repositioning the button
                    .buttonStyle(PlainButtonStyle())
                    .position(x:37, y:205)
            }
        }
    }
}

// Creating the Mind Map for the application
struct MINDMAP: View{
    @Binding var currentPage: Int
    var body: some View{
        GeometryReader { geometry in
            VStack() {
                // Creating the side bar for the Home Page
                // Defining the object
                Rectangle()
                // Defining the object size
                    .frame(width:155, height: 6000)
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

struct STICKYNOTEPAGE: View{
    //variable for controlling currentpage
    @Binding var currentPage: Int
    //variable for the number of sticky notes to display
    @Binding var noteNumber: Int
    //string variable for all 5 sticky notes
    @Binding var StickyText1: String
    @Binding var StickyText2: String
    @Binding var StickyText3: String
    @Binding var StickyText4: String
    @Binding var StickyText5: String
    //the variable for the position of the first stickynote
    @Binding var StickyPos1: CGSize
    @Binding var StickyPos2: CGSize
    @Binding var StickyPos3: CGSize
    @Binding var StickyPos4: CGSize
    @Binding var StickyPos5: CGSize
    //the displayed view
    var body: some View{
        GeometryReader { geometry in
            //the notes
            //the yellow note
            if noteNumber >= 0{
                ZStack{
                    //rectangle behind Texteditor 1
                    Rectangle()
                        // Defining the note's size and position
                        .frame(width: 250,height: 250)
                        .offset(StickyPos1)
                        //color for sticky note three
                        .foregroundColor(.yellow)
                        .gesture(
                            DragGesture()
                                .onChanged{value in withAnimation(.spring()) {
                                    StickyPos1 = value.translation
                                    //stopping the sticky note from leaving the white area
                                    if StickyPos1.width <= 77 {
                                        StickyPos1.width = 77
                                    }
                                    if StickyPos1.height <= 115 {
                                        StickyPos1.height = 115
                                    }
                                }
                            }
                        )
                    //text editor 1
                    TextEditor(text: $StickyText1)
                        // Defining the note's size and position
                        .frame(width: 225,height: 225)
                        .offset(StickyPos1)
                        //color for sticky note three
                        .colorMultiply(Color("StickyYellow"))
                    }
                }
            //the pink note
            if noteNumber >= 1{
                ZStack{
                    //rectangle behind Texteditor 2
                    Rectangle()
                        // Defining the note's size and position
                        .frame(width: 250,height: 250)
                        .offset(StickyPos2)
                        //color for sticky note three
                        .foregroundColor(.pink)
                        .gesture(
                            DragGesture()
                                .onChanged{value in withAnimation(.spring()) {
                                    StickyPos2 = value.translation
                                    //stopping the sticky note from leaving the white area
                                    if StickyPos2.width <= 77 {
                                        StickyPos2.width = 77
                                    }
                                    if StickyPos2.height <= 115 {
                                        StickyPos2.height = 115
                                    }
                                }
                            }
                        )
                    //text editor 2
                    TextEditor(text: $StickyText2)
                        // Defining the note's size and position
                        .frame(width: 225,height: 225)
                        .offset(StickyPos2)
                        //color for sticky note three
                        .colorMultiply(Color("StickyPink"))
                }
            }
            if noteNumber >= 2{
                ZStack {
                    //rectangle behind Texteditor 3
                    Rectangle()
                        // Defining the note's size and position
                        .frame(width: 250,height: 250)
                        .offset(StickyPos3)
                        //color for sticky note three background
                        .foregroundColor(.purple)
                        .gesture(
                            DragGesture()
                                .onChanged{value in withAnimation(.spring()) {
                                    StickyPos3 = value.translation
                                    //stopping the sticky note from leaving the white area
                                    if StickyPos3.width <= 77 {
                                        StickyPos3.width = 77
                                    }
                                    if StickyPos3.height <= 115 {
                                        StickyPos3.height = 115
                                    }
                                }
                            }
                        )
                    //text editor 3
                    TextEditor(text: $StickyText3)
                    // Defining the note's size and position
                        .frame(width: 225,height: 225)
                        .offset(StickyPos3)
                        //color for sticky note three
                        .colorMultiply(Color("StickyPurple"))
                }
            }
            if noteNumber >= 3{
                ZStack {
                    //rectangle behind Texteditor 4
                    Rectangle()
                        // Defining the note's size and position
                        .frame(width: 250,height: 250)
                        .offset(StickyPos4)
                        //color for sticky note three
                        .foregroundColor(.green)
                        .gesture(
                            DragGesture()
                                .onChanged{value in withAnimation(.spring()) {
                                    StickyPos4 = value.translation
                                    //stopping the sticky note from leaving the white area
                                    if StickyPos4.width <= 77 {
                                        StickyPos4.width = 77
                                    }
                                    if StickyPos4.height <= 115 {
                                        StickyPos4.height = 115
                                    }
                                }
                            }
                        )
                    //text editor 4
                    TextEditor(text: $StickyText4)
                    // Defining the note's size and position
                        .frame(width: 225,height: 225)
                        .offset(StickyPos4)
                    //color for sticky note three
                        .colorMultiply(Color("StickyGreen"))
                }
            }
        if noteNumber >= 4{
            ZStack{
                //rectangle behind Texteditor 5
                Rectangle()
                    // Defining the note's size and position
                    .frame(width: 250,height: 250)
                    .offset(StickyPos5)
                    //color for sticky note three
                    .foregroundColor(.blue)
                    .gesture(
                        DragGesture()
                            .onChanged{value in withAnimation(.spring()) {
                                StickyPos5 = value.translation
                                //stopping the sticky note from leaving the white area
                                if StickyPos5.width <= 77 {
                                    StickyPos5.width = 77
                                }
                                if StickyPos5.height <= 115 {
                                    StickyPos5.height = 115
                                }
                            }
                        }
                    )
                //text editor 5
                TextEditor(text: $StickyText5)
                    // Defining the note's size and position
                    .frame(width: 225, height: 225)
                    .offset(StickyPos5)
                    //color for sticky note five
                    .colorMultiply(Color("StickyBlue"))
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
//Home page buttons extension preview
private extension ContentView{
    var HomePageButtons: some View{
        GeometryReader { geometry in
            // Creating the first button for the Home page
            // Defining the object for button background
            Rectangle()
                .cornerRadius(15)
            // Defining the object size
                .frame(width: 90, height: 90)
            // Defining the object colour
                .foregroundColor(Color("DarkOrange"))
            // Defining the object position
                .position(x:58, y:168)
            
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
                .position(x:58, y:267)
            
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
            
            // Creating the third button for the Home page
            // Defining the object for button background
            Rectangle()
                .cornerRadius(15)
            // Defining the object size
                .frame(width: 90, height: 90)
            // Defining the object colour
                .foregroundColor(Color("DarkOrange"))
            // Defining the object position
                .position(x:58, y:366)
            
            // Defining button actions to change page
            Button(action: {
                currentPage = 2
            }) {
                // Adding and resizing the icon that the button will present as
                Image("StickiesIcon")
                    // Resizing the icon image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 77, height: 77)
                }
                // Styling and repositioning the button
                .buttonStyle(PlainButtonStyle())
                .position(x:58, y:366)
            
            // Creating the fourth button for the Home page
            // Defining the object for button background
            Rectangle()
                .cornerRadius(15)
            // Defining the object size
                .frame(width: 90, height: 90)
            // Defining the object colour
                .foregroundColor(Color("DarkOrange"))
            // Defining the object position
                .position(x:58, y:465)
            
            // Defining button actions to change page
            Button(action: {
                currentPage = 3
            }) {
                // Adding and resizing the icon that the button will present as
                Image("MapIcon")
                    // Resizing the icon image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 77, height: 77)
                }
                // Styling and repositioning the button
                .buttonStyle(PlainButtonStyle())
                .position(x:58, y:465)
            
        }
    }
}

// General note page buttons extension preview
private extension ContentView{
    var GeneralNotePageButtons: some View{
        GeometryReader { geometry in
            // Button to go to home page
            // Defining the object for button background
            Rectangle()
                .cornerRadius(10)
            // Defining the object size
                .frame(width: 60, height: 60)
            // Defining the object colour
                .foregroundColor(Color("DarkOrange"))
            // Defining the object position
                .position(x:37, y:160)
            
            // Defining button actions to change page
            Button(action: {
                currentPage = 0
            }) {
                // Adding and resizing the icon that the button will present as
                Image("HomeIcon")
                // Resizing the icon image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55, height: 55)
            }
                    // Styling and repositioning the button
                    .buttonStyle(PlainButtonStyle())
                    .position(x:38, y:160)
        }
    }
}

// Sticky Note buttons extension preview
    private extension ContentView{
        var StickyNotePageButtons: some View{
            GeometryReader { geometry in
                // Button to go to home page
                // Defining the object for button background
                Rectangle()
                    .cornerRadius(10)
                // Defining the object size
                    .frame(width: 60, height: 60)
                // Defining the object colour
                    .foregroundColor(Color("DarkOrange"))
                // Defining the object position
                    .position(x:37, y:160)
                
                // Defining button actions to change page
                Button(action: {
                    currentPage = 0
                }) {
                    // Adding and resizing the icon that the button will present as
                    Image("HomeIcon")
                    // Resizing the icon image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55, height: 55)
                }
                // Styling and repositioning the button
                .buttonStyle(PlainButtonStyle())
                .position(x:38, y:160)
                
                // Button to create a new sticky note
                // Defining the object for button background
                Rectangle()
                    .cornerRadius(10)
                // Defining the object size
                    .frame(width: 60, height: 60)
                // Defining the object colour
                    .foregroundColor(Color("DarkOrange"))
                // Defining the object position
                    .position(x:37, y:235)
                
                // Defining button actions to change note number
                Button(action: {
                    noteNumber += 1
                    if noteNumber >= 5 {
                        noteNumber = 0
                    }
                }) {
                // Adding and resizing the icon that the button will present as
                    Image("AddButton")
                    // Resizing the icon image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55, height: 55)
                    }
                        // Styling and repositioning the button
                        .buttonStyle(PlainButtonStyle())
                        .position(x:38, y:235)
                //the button which saves the file information of the sticky note text
                Button(action: {
                    //saving the files
                    writeFile(Filename: "StickyText1", Data: StickyText1)
                    writeFile(Filename: "StickyText2", Data: StickyText2)
                    writeFile(Filename: "StickyText3", Data: StickyText3)
                    writeFile(Filename: "StickyText4", Data: StickyText4)
                    writeFile(Filename: "StickyText5", Data: StickyText5)
                    //reading the amount of data
                    let stickyData1 = readingFile(inputFile: "StickyText1")
                    let stickyData2 = readingFile(inputFile: "StickyText2")
                    let stickyData3 = readingFile(inputFile: "StickyText3")
                    let stickyData4 = readingFile(inputFile: "StickyText4")
                    let stickyData5 = readingFile(inputFile: "StickyText5")
                    //print the amount of data added to the console
                    print(stickyData1)
                    print(stickyData2)
                    print(stickyData3)
                    print(stickyData4)
                    print(stickyData5)
                }) {
                    // Adding and resizing the icon that the button will present as
                    Text("Save")
                        // Resizing the icon image
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                        .background(Color("DarkOrange"))
                        .cornerRadius(10)
                    }
                    // Styling and repositioning the button
                    .buttonStyle(PlainButtonStyle())
                    .position(x:37, y:310)
            }
        }
    }
    
    private extension ContentView{
        var textEditorView: some View{
            GeometryReader { geometry in
                TextEditor(text: $GeneralNoteText)
                    .frame(width: geometry.size.width * 0.7,height: geometry.size.height * 30)
                    .position(x:geometry.size.width * 0.5, y:geometry.size.height * 35)
            }
        }
    }
//  MindMap page buttons extension preview
private extension ContentView{
    var MindMapButtons: some View{
        GeometryReader { geometry in
            // Button to go to home page
            // Defining the object for button background
            Rectangle()
                .cornerRadius(10)
            // Defining the object size
                .frame(width: 60, height: 60)
            // Defining the object colour
                .foregroundColor(Color("DarkOrange"))
            // Defining the object position
                .position(x:37, y:160)
            
            // Defining button actions to change page
            Button(action: {
                currentPage = 0
            }) {
                // Adding and resizing the icon that the button will present as
                Image("HomeIcon")
                // Resizing the icon image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55, height: 55)
                }
                    // Styling and repositioning the button
                    .buttonStyle(PlainButtonStyle())
                    .position(x:38, y:160)
        }
    }
}

private extension ContentView{
    var PageOutline: some View{
        GeometryReader { geometry in
            VStack{
                // Creating the side bar for the Home Page
                // Defining the object
                Rectangle()
                // Defining the object size
                    .frame(width:155, height: 6000)
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
