//
//  ContentView.swift
//  Notsify App
//
//  Created by Kyle Akers and Daniel Meyer on 5/07/24.

// Importing the Swift library
import SwiftUI
// Importing the libary for manipulating .txt files
import Cocoa
// This extension contains two key functions for getting the file name.
extension String{
    // Getting the filename from a string
    func fileName() -> String{
        // Finding the file name by deleting the file extension attached
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }
    // Getting the file type from the string
    func fileType() -> String{
        // Finding the file type by specifying for the file extension
        return URL(fileURLWithPath: self).pathExtension
    }
}

// Creating a function which reads the text file
func readingFile(inputFile: String) -> String{
    // Breaking up the file into two components
    // The file name
    let nameFile =  inputFile.fileName()
    // The file type
    let typeFile = inputFile.fileType()
    // Getting the location of the file
    let filelocationURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    let readFile = filelocationURL.appendingPathComponent(nameFile).appendingPathExtension(typeFile)
    
    // Reading the data on the .txt file
    do {
        let savedInfo = try String(contentsOf: readFile)
        return savedInfo
        // Defining the process if the folder doesn't exist
    } catch {
        // If the file doesn't exist then return the fact that it doesn't exist
        return "Write text here:"
    }
}

// Creating a function which reads the text file for the home page specifically
func HomePagereadingFile(inputFile: String) -> String{
    // Breaking up the file into two components
    // The file name
    let nameFile =  inputFile.fileName()
    // The file type
    let typeFile = inputFile.fileType()
    // Getting the location of the file
    let filelocationURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    let readFile = filelocationURL.appendingPathComponent(nameFile).appendingPathExtension(typeFile)
    
    // Reading the data on the .txt file
    do {
        let savedInfo = try String(contentsOf: readFile)
        return savedInfo
        // Defining the process if the folder doesn't exist
    } catch {
        // If the file doesn't exist then return the fact that it doesn't exist
        return "1)NotePage1"
    }
}

// Creating a function which writes a text file and can create files. Taking 2 parameters - the file name and data on the .txt file
func writeFile(Filename: String, Data: String){
    // Breaking up the file into two components
    // The file name
    let nameFile =  Filename.fileName()
    // The file type
    let typeFile = Filename.fileType()
    // Retreiving the location of the file
    let filelocationURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let Filename = filelocationURL.appendingPathComponent(nameFile).appendingPathExtension(typeFile)
    
    // Saving the data
    guard let data = Data.data(using: .utf8) else{
        print("can't convert string to data")
        return
    }
    // Printing to the console whether the data transmision was successful and if so how many bytes, else an error which specifies why it failed
    do{
        try data.write(to: Filename)
        print("data written: \(data)")
    } catch{
        print(error.localizedDescription)
    }
}

// Creating a function which allows users to delete files
// This function isn't used although in future prospects for the app could be very handy.
func deleteFile(_ fileToDelete: String){
    // Breaking up the filename and extension
    // The file name
    let nameFile =  fileToDelete.fileName()
    // The file type
    let typeFile = fileToDelete.fileType()
    // Getting the location of the file
    let filelocationURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let Filename = filelocationURL.appendingPathComponent(nameFile).appendingPathExtension(typeFile)
    
    do {
        try FileManager.default.removeItem(at: Filename)
    }catch{
        print(error.localizedDescription)
    }
}

// The function to create a line because XCode doesn't have there own in-built function
struct Line: Shape{
    // The two parameters (start and end point of the line)
    var StartPoint: CGPoint
    var EndPoint: CGPoint
    // The function used to create the line
    func path(in rect: CGRect) -> Path {
        // The path between start and end point being created
        var path = Path()
        path.move(to: StartPoint)
        path.addLine(to: EndPoint)
        // Returning the path
        return path
    }
}
// Main Content View
struct ContentView: View {
    // --- DEFINING ALL THE VARIABLES USED IN THE CODE THAT ARE USED BETWEEN EXTENSIONS / STRUCTERS
    // Defining the current page variable
    @State var currentPage = 0
    // Defining sticky note number variable
    @State var noteNumber = 0
    // The general notes page variables
    @State var NotePages = ["1)NotePage1", "2)NotePage2", "3)NotePage3", "4)NotePage4", "5)NotePage5"]
    // The selected note page when laucnhing the application
    @State private var selectedNotePage = "1)NotePage1"
    
    // Defining the variable order for pages openened
    @State var RecentlyOpened1: String = HomePagereadingFile(inputFile: "RecentlyOpened1")
    @State var RecentlyOpened2: String = HomePagereadingFile(inputFile: "RecentlyOpened2")
    @State var RecentlyOpened3: String = HomePagereadingFile(inputFile: "RecentlyOpened3")
    
    // Defining the variable for the general notes string
    @State var GeneralNoteText1: String = readingFile(inputFile: "1)NotePage1")
    @State var GeneralNoteText2: String = readingFile(inputFile: "2)NotePage2")
    @State var GeneralNoteText3: String = readingFile(inputFile: "3)NotePage3")
    @State var GeneralNoteText4: String = readingFile(inputFile: "4)NotePage4")
    @State var GeneralNoteText5: String = readingFile(inputFile: "5)NotePage5")
    
    // Defining the variable for the sticky notes string
    @State private var StickyText1: String = readingFile(inputFile: "StickyText1")
    @State private var StickyText2: String = readingFile(inputFile: "StickyText2")
    @State private var StickyText3: String = readingFile(inputFile: "StickyText3")
    @State private var StickyText4: String = readingFile(inputFile: "StickyText4")
    @State private var StickyText5: String = readingFile(inputFile: "StickyText5")
    
    // Defining the variable for the position of all 5 sticky notes
    @State var StickyPos1: CGSize = CGSize(width: 100, height: 150)
    @State var StickyPos2: CGSize = CGSize(width: 100, height: 150)
    @State var StickyPos3: CGSize = CGSize(width: 100, height: 150)
    @State var StickyPos4: CGSize = CGSize(width: 100, height: 150)
    @State var StickyPos5: CGSize = CGSize(width: 100, height: 150)
    
    // Defining the variable position and string for mindmap title square
    @State private var MindMapTitleStr: String = readingFile(inputFile: "MindMapTitle")
    @State var MindMapTitlePos: CGSize = CGSize(width: 500, height: 500)
    
    // Defining the variable for amount of current mind map tiles in use.
    @State var TileAmount = 0
    
    // The variable for mind map strings
    @State private var MindMapStr1: String = readingFile(inputFile: "MindMapStr1")
    @State private var MindMapStr2: String = readingFile(inputFile: "MindMapStr2")
    @State private var MindMapStr3: String = readingFile(inputFile: "MindMapStr3")
    @State private var MindMapStr4: String = readingFile(inputFile: "MindMapStr4")
    @State private var MindMapStr5: String = readingFile(inputFile: "MindMapStr5")
    @State private var MindMapStr6: String = readingFile(inputFile: "MindMapStr6")
    @State private var MindMapStr7: String = readingFile(inputFile: "MindMapStr7")
    // The positions of MindMapTiles
    @State var MindMapPos1: CGSize = CGSize(width: 300, height: 300)
    @State var MindMapPos2: CGSize = CGSize(width: 500, height: 300)
    @State var MindMapPos3: CGSize = CGSize(width: 700, height: 300)
    @State var MindMapPos4: CGSize = CGSize(width: 900, height: 300)
    @State var MindMapPos5: CGSize = CGSize(width: 300, height: 600)
    @State var MindMapPos6: CGSize = CGSize(width: 500, height: 600)
    @State var MindMapPos7: CGSize = CGSize(width: 700, height: 600)
    // The main body which contains all the view switching (switching between pages and what structers/extension are on each page.)
    var body: some View {
        ScrollView(showsIndicators: true) {
            // Switching case statements to dictate the application page is active
            switch currentPage {
                // Case 1 is the General notes page
            case 1:
                // The basic outline of the page for every page that isn't the home page
                PageOutline
                // The general notes page related elements such as the buttons which can't be in the buttons page and other items.
                GENERALNOTESPAGE(currentPage: $currentPage, GeneralNoteText1: $GeneralNoteText1,GeneralNoteText2: $GeneralNoteText2,GeneralNoteText3: $GeneralNoteText3,GeneralNoteText4: $GeneralNoteText4,GeneralNoteText5: $GeneralNoteText5, selectedNotePage: $selectedNotePage, NotePages: $NotePages, RecentlyOpened1: $RecentlyOpened1, RecentlyOpened2: $RecentlyOpened2, RecentlyOpened3: $RecentlyOpened3)
                GeneralNotePageButtons
                // The text editor in the general notes page
                textEditorView
                // Case 2 is the stickynote page
            case 2:
                // The basic outline of the page for every page that isn't the home page
                PageOutline
                // The stickynote page which controls all 5 sticky notes and there position.
                STICKYNOTEPAGE(currentPage: $currentPage, noteNumber: $noteNumber, StickyText1: $StickyText1, StickyText2: $StickyText2, StickyText3: $StickyText3, StickyText4: $StickyText4, StickyText5: $StickyText5, StickyPos1: $StickyPos1, StickyPos2: $StickyPos2, StickyPos3: $StickyPos3, StickyPos4: $StickyPos4, StickyPos5: $StickyPos5)
                //the buttons for the stickynote page
                StickyNotePageButtons
                // Case three is the mind map page
            case 3:
                // The basic outline of the page for every page that isn't the home page
                ZStack{
                    // The basic page outline for every page but the homepage
                    PageOutline
                    // Mind map page buttons extension
                    MindMapButtons
                    // The mind map title always exists, which is why it is at the top.
                    MindMapTitle
                    // If Statements which display a certain amount of the lines and tiles depending on tileAmount variable
                    if TileAmount > 0{
                        // The line connects between the Title tile and first tile.
                        Line(StartPoint: CGPoint(x:MindMapTitlePos.width + 50, y:MindMapTitlePos.height + 60), EndPoint: CGPoint(x:MindMapPos1.width + 100, y: MindMapPos1.height + 60))
                            // Giving the line a color and width
                            .stroke(Color.black, lineWidth: 3)
                            // This makes sure the Line spawns behind every tile by making it the bottom of the priotity order.
                            .zIndex(-1)
                        // Displaying the first tile
                        MindMapTile1
                    }
                    if TileAmount > 1 {
                        // The line connects between the Title tile and seccond tile.
                        Line(StartPoint: CGPoint(x:MindMapTitlePos.width + 50, y:MindMapTitlePos.height + 60), EndPoint: CGPoint(x:MindMapPos2.width + 100, y: MindMapPos2.height + 60))
                            // Giving the line a color and width
                            .stroke(Color.black, lineWidth: 3)
                            // This makes sure the Line spawns behind every tile by making it the bottom of the priotity order.
                            .zIndex(-1)
                        // Displaying the seccond tile
                        MindMapTile2
                    }
                    if TileAmount > 2{
                        // The line connects between the Title tile and third tile.
                        Line(StartPoint: CGPoint(x:MindMapTitlePos.width + 50, y:MindMapTitlePos.height + 60), EndPoint: CGPoint(x:MindMapPos3.width + 100, y: MindMapPos3.height + 60))
                            // Giving the line a color and width
                            .stroke(Color.black, lineWidth: 3)
                            // This makes sure the Line spawns behind every tile by making it the bottom of the priotity order.
                            .zIndex(-1)
                        // Displaying the third tile
                        MindMapTile3
                    }
                    if TileAmount > 3 {
                        // The line connects between the Title tile and fourth tile.
                        Line(StartPoint: CGPoint(x:MindMapTitlePos.width + 50, y:MindMapTitlePos.height + 60), EndPoint: CGPoint(x:MindMapPos4.width + 100, y: MindMapPos4.height + 60))
                            // Giving the line a color and width
                            .stroke(Color.black, lineWidth: 3)
                            // This makes sure the Line spawns behind every tile by making it the bottom of the priotity order.
                            .zIndex(-1)
                        // Displaying the fourth tile
                        MindMapTile4
                    }
                    if TileAmount > 4{
                        // The line connects between the Title tile and fifth tile.
                        Line(StartPoint: CGPoint(x:MindMapTitlePos.width + 50, y:MindMapTitlePos.height + 60), EndPoint: CGPoint(x:MindMapPos5.width + 100, y: MindMapPos5.height + 60))
                            // Giving the line a color and width
                            .stroke(Color.black, lineWidth: 3)
                            // This makes sure the Line spawns behind every tile by making it the bottom of the priotity order.
                            .zIndex(-1)
                        // Displaying the fifth tile
                        MindMapTile5
                    }
                    if TileAmount > 5 {
                        // The line connects between the Title tile and sixth tile.
                        Line(StartPoint: CGPoint(x:MindMapTitlePos.width + 50, y:MindMapTitlePos.height + 60), EndPoint: CGPoint(x:MindMapPos6.width + 100, y: MindMapPos6.height + 60))
                            // Giving the line a color and width
                            .stroke(Color.black, lineWidth: 3)
                            // This makes sure the Line spawns behind every tile by making it the bottom of the priotity order.
                            .zIndex(-1)
                        // Displaying the sixth tile
                        MindMapTile6
                    }
                    if TileAmount > 6{
                        // The line connects between the Title tile and seventh tile.
                        Line(StartPoint: CGPoint(x:MindMapTitlePos.width + 50, y:MindMapTitlePos.height + 60), EndPoint: CGPoint(x:MindMapPos7.width + 100, y: MindMapPos7.height + 60))
                            // Giving the line a color and width
                            .stroke(Color.black, lineWidth: 3)
                            // This makes sure the Line spawns behind every tile by making it the bottom of the priotity order.
                            .zIndex(-1)
                        // Displaying the seventh tile
                        MindMapTile7
                    }
                }
            // The default case (not 1 2 or 3) is the homepage
            default:
                // The homepage outline (very simila to page outline but a few different features)
                HOMEPAGE(currentPage: $currentPage)
                // Homepage buttons
                HomePageButtons
                homepageRecentPage1
            }
        }
        // The minimum width and height the screen can be moved to (This insures you can't make the screen small or big.)
        .frame(minWidth: 700, minHeight:500)
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
                
                // Inserting the image that serves as our application title
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
                    .position(x: geometry.size.width*0.955, y: 22)
                
                // Creating the light orange center
                Rectangle()
                    // The size of the square
                    .frame(width: geometry.size.width * 0.7, height: 570)
                    // Positioning it in the lower center
                    .position(x: geometry.size.width * 0.54, y: 450)
                    // Making the square light orange
                    .foregroundColor(Color("LightOrange"))
                
                
                }
            }
        }
    }
// Creating the General notes page for the application
struct GENERALNOTESPAGE: View{
    // Defining the variable for changing pages
    @Binding var currentPage: Int
    // Defining the variables for getting the General note text for all 5 possible pages
    @Binding var GeneralNoteText1: String
    @Binding var GeneralNoteText2: String
    @Binding var GeneralNoteText3: String
    @Binding var GeneralNoteText4: String
    @Binding var GeneralNoteText5: String
    //defining the list with note text
    @Binding var selectedNotePage: String
    @Binding var NotePages: [String]
    // The variables for changing the quick launch
    @Binding var RecentlyOpened1: String
    @Binding var RecentlyOpened2: String
    @Binding var RecentlyOpened3: String
    var body: some View{
        GeometryReader { geometry in
                // This can't be placed in the generalNotesButtons because it needs access to the GeneralNotesText variable which is a binding var and can't be used in extension pages
                // This button checks what page the user is on and displays the general note text depending on what general note page they have selected.
                Button(action: {
                    if selectedNotePage == "1)NotePage1"{
                        writeFile(Filename: selectedNotePage, Data: GeneralNoteText1)
                    }
                    else if selectedNotePage == "2)NotePage2"{
                        writeFile(Filename: selectedNotePage, Data: GeneralNoteText2)
                    }
                    else if selectedNotePage == "3)NotePage3"{
                        writeFile(Filename: selectedNotePage, Data: GeneralNoteText3)
                    }
                    else if selectedNotePage == "4)NotePage4"{
                        writeFile(Filename: selectedNotePage, Data: GeneralNoteText4)
                    }
                    else if selectedNotePage == "5)NotePage5"{
                        writeFile(Filename: selectedNotePage, Data: GeneralNoteText5)
                    }
                    // The homepage quick launch being updated if the note page saved wasn't saved before.
                    if RecentlyOpened1 != selectedNotePage {
                        // The pages being equal to the previous page.
                        RecentlyOpened3 = RecentlyOpened2
                        RecentlyOpened2 = RecentlyOpened1
                        // The updated page update.
                        RecentlyOpened1 = selectedNotePage
                        
                        writeFile(Filename: "RecentlyOpened3", Data: RecentlyOpened3)
                        writeFile(Filename: "RecentlyOpened2", Data: RecentlyOpened2)
                        writeFile(Filename: "RecentlyOpened1", Data: RecentlyOpened1)
                    }
                    
                    
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
                    .position(x:37, y:255)
            // Defining button which allows for user to pick which general notes page they want to be on. (This also can't be a part of the buttons because it require manipulating the string text)
            VStack {
                Picker("", selection: $selectedNotePage) {
                    ForEach(NotePages, id: \.self) {
                        Text($0)
                    }
                }
                .frame(width: 60, height: 60) // Adjust the size of the Picker
                .position(x: 37, y: 330)
            }
            }
        }
    }

// Creating the Sticky notes page for the application
struct STICKYNOTEPAGE: View{
    // Defining the variable for controlling currentPage
    @Binding var currentPage: Int
    // Defining the variable for the number of sticky notes to display
    @Binding var noteNumber: Int
    // Defining the string variables for all 5 sticky notes
    @Binding var StickyText1: String
    @Binding var StickyText2: String
    @Binding var StickyText3: String
    @Binding var StickyText4: String
    @Binding var StickyText5: String
    //Defining the variable for the position of all 5 sticky notes
    @Binding var StickyPos1: CGSize
    @Binding var StickyPos2: CGSize
    @Binding var StickyPos3: CGSize
    @Binding var StickyPos4: CGSize
    @Binding var StickyPos5: CGSize
    // The displayed view
    var body: some View{
        GeometryReader { geometry in
        // The sticky notes
            // The yellow note
            if noteNumber >= 0{
                ZStack{
                    // Creating a rectangle to serve as the note's outline
                    Rectangle()
                        // Defining the note's size and position
                        .frame(width: 250,height: 250)
                        .offset(StickyPos1)
                        // // Changing the outline color for note #1 (the yellow note)
                        .foregroundColor(Color("StickyYellowOutline"))
                        // Making the note draggable
                        .gesture(
                            DragGesture()
                                .onChanged{value in withAnimation(.spring()) {
                                    StickyPos1 = value.translation
                                    // Preventing the sticky note from leaving its intended area
                                    if StickyPos1.width <= 77 {
                                        StickyPos1.width = 77
                                    }
                                    if StickyPos1.height <= 115 {
                                        StickyPos1.height = 115
                                    }
                                }
                            }
                        )
                    // Creating the editable text box for sticky note #1 (the yellow note)
                    TextEditor(text: $StickyText1)
                        // Defining the note's size and position
                        .frame(width: 225,height: 225)
                        .offset(StickyPos1)
                        // Changing the color for note #1 (the yellow note)
                        .colorMultiply(Color("StickyYellow"))
                    }
                }
            // The pink note
            if noteNumber >= 1{
                ZStack{
                    // Creating a rectangle to serve as the note's outline
                    Rectangle()
                        // Defining the note's size and position
                        .frame(width: 250,height: 250)
                        .offset(StickyPos2)
                        // Changing the outline color for note #2 (the pink note)
                        .foregroundColor(Color("StickyPinkOutline"))
                        // Making the note draggable
                        .gesture(
                            DragGesture()
                                .onChanged{value in withAnimation(.spring()) {
                                    StickyPos2 = value.translation
                                    // Preventing the sticky note from leaving its intended area
                                    if StickyPos2.width <= 77 {
                                        StickyPos2.width = 77
                                    }
                                    if StickyPos2.height <= 115 {
                                        StickyPos2.height = 115
                                    }
                                }
                            }
                        )
                    // Creating the editable text box for sticky note #2 (the pink note)
                    TextEditor(text: $StickyText2)
                        // Defining the note's size and position
                        .frame(width: 225,height: 225)
                        .offset(StickyPos2)
                        // Changing the color for note #2 (the pink note)
                        .colorMultiply(Color("StickyPink"))
                }
            }
            // The purple note
            if noteNumber >= 2{
                ZStack {
                    // Creating a rectangle to serve as the note's outline
                    Rectangle()
                        // Defining the note's size and position
                        .frame(width: 250,height: 250)
                        .offset(StickyPos3)
                        // Changing the outline color for note #3 (the purple note)
                        .foregroundColor(Color("StickyPurpleOutline"))
                        // Making the note draggable
                        .gesture(
                            DragGesture()
                                .onChanged{value in withAnimation(.spring()) {
                                    StickyPos3 = value.translation
                                    // Preventing the sticky note from leaving its intended area
                                    if StickyPos3.width <= 77 {
                                        StickyPos3.width = 77
                                    }
                                    if StickyPos3.height <= 115 {
                                        StickyPos3.height = 115
                                    }
                                }
                            }
                        )
                    // Creating the editable text box for sticky note #3 (the purple note)
                    TextEditor(text: $StickyText3)
                    // Defining the note's size and position
                        .frame(width: 225,height: 225)
                        .offset(StickyPos3)
                        // Changing the color for note #2 (the pink note)
                        .colorMultiply(Color("StickyPurple"))
                }
            }
            // The green note
            if noteNumber >= 3{
                ZStack {
                    // Creating a rectangle to serve as the note's outline
                    Rectangle()
                        // Defining the note's size and position
                        .frame(width: 250,height: 250)
                        .offset(StickyPos4)
                        // Changing the outline color for note #4 (the green note)
                        .foregroundColor(Color("StickyGreenOutline"))
                        // Making the note draggable
                        .gesture(
                            DragGesture()
                                .onChanged{value in withAnimation(.spring()) {
                                    StickyPos4 = value.translation
                                    // Preventing the sticky note from leaving its intended area
                                    if StickyPos4.width <= 77 {
                                        StickyPos4.width = 77
                                    }
                                    if StickyPos4.height <= 115 {
                                        StickyPos4.height = 115
                                    }
                                }
                            }
                        )
                    // Creating the editable text box for sticky note #4 (the green note)
                    TextEditor(text: $StickyText4)
                        // Defining the note's size and position
                        .frame(width: 225,height: 225)
                        .offset(StickyPos4)
                        // Changing the color for note #4 (the green note)
                        .colorMultiply(Color("StickyGreen"))
                }
            }
        // The blue note
        if noteNumber >= 4{
            ZStack{
                // Creating a rectangle to serve as the note's outline
                Rectangle()
                    // Defining the note's size and position
                    .frame(width: 250,height: 250)
                    .offset(StickyPos5)
                    // Changing the outline color for note #5 (the blue note)
                    .foregroundColor(Color("StickyBlueOutline"))
                    // Making the note draggable
                    .gesture(
                        DragGesture()
                            .onChanged{value in withAnimation(.spring()) {
                                StickyPos5 = value.translation
                                // Preventing the sticky note from leaving its intended area
                                if StickyPos5.width <= 77 {
                                    StickyPos5.width = 77
                                }
                                if StickyPos5.height <= 115 {
                                    StickyPos5.height = 115
                                }
                            }
                        }
                    )
                // Creating the editable text box for sticky note #5 (the blue note)
                TextEditor(text: $StickyText5)
                    // Defining the note's size and position
                    .frame(width: 225, height: 225)
                    .offset(StickyPos5)
                    // Changing the color for note #5 (the blue note)
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
// Home page buttons extension preview
private extension ContentView{
    var HomePageButtons: some View{
        GeometryReader { geometry in
            // Creating the first button for the Home page
            // Creating a object that serves as the button border
            
            Rectangle()
                .cornerRadius(15)
                // Defining the object size
                .frame(width: 93, height: 93)
                // Defining the object colour
                .foregroundColor(.white)
                // Defining the object position
                .position(x:58, y:168)
            
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
                
                
                // Creating the button which resets how many stickies are created (The maximum amount is 5)
                Button(action: {
                    // Reseting the tile amount to zero so you only see the title tile
                    noteNumber = 0
                    // Setting the positions of the sticky notes to the position they start at before moving them.
                    // Defining the variable for the position of all 5 sticky notes
                    StickyPos1 = CGSize(width: 100, height: 150)
                    StickyPos2 = CGSize(width: 100, height: 150)
                    StickyPos3 = CGSize(width: 100, height: 150)
                    StickyPos4 = CGSize(width: 100, height: 150)
                    StickyPos5 = CGSize(width: 100, height: 150)
                    
                }) {
                    // Adding and resizing the icon that the button will present as
                    Text("Reset")
                        // Resizing the icon image
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                        .background(Color("DarkOrange"))
                        .cornerRadius(10)
                    }
                    // Styling and repositioning the button
                    .buttonStyle(PlainButtonStyle())
                    .position(x:37, y:310)
                
                // Creating the button which saves the file information of the Sticky note text
                Button(action: {
                    // Saving the files
                    writeFile(Filename: "StickyText1", Data: StickyText1)
                    writeFile(Filename: "StickyText2", Data: StickyText2)
                    writeFile(Filename: "StickyText3", Data: StickyText3)
                    writeFile(Filename: "StickyText4", Data: StickyText4)
                    writeFile(Filename: "StickyText5", Data: StickyText5)
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
                    .position(x:37, y:385)
            }
        }
    }
    // Changing the size and position of the General notes TextEditor
private extension ContentView {
    var textEditorView: some View {
        GeometryReader { geometry in
            // The Black rectangle which acts as a background to the main Text editor
            Rectangle()
                .frame(width: geometry.size.width * 0.855, height: 570)
                .position(x: geometry.size.width * 0.54, y: 390)
                .foregroundColor(.black)
            // If the first Note page has been selected then display the first note page
            if selectedNotePage == "1)NotePage1"{
                TextEditor(text: $GeneralNoteText1)
                    .frame(width: geometry.size.width * 0.85, height: 565)
                    .position(x: geometry.size.width * 0.54, y: 390)
            }
            // If the seccond Note page has been selected then display the seccond note page
            else if selectedNotePage == "2)NotePage2"{
                TextEditor(text: $GeneralNoteText2)
                    .frame(width: geometry.size.width * 0.85, height: 565)
                    .position(x: geometry.size.width * 0.54, y: 390)
            }
            // If the third Note page has been selected then display the third note page
            else if selectedNotePage == "3)NotePage3"{
                TextEditor(text: $GeneralNoteText3)
                    .frame(width: geometry.size.width * 0.85, height: 565)
                    .position(x: geometry.size.width * 0.54, y: 390)
            }
            // If the fourth Note page has been selected then display the fourth note page
            else if selectedNotePage == "4)NotePage4"{
                TextEditor(text: $GeneralNoteText4)
                    .frame(width: geometry.size.width * 0.85, height: 565)
                    .position(x: geometry.size.width * 0.54, y: 390)
            }
            // If the fifth Note page has been selected then display the fifth note page
            else if selectedNotePage == "5)NotePage5"{
                TextEditor(text: $GeneralNoteText5)
                    .frame(width: geometry.size.width * 0.85, height: 565)
                    .position(x: geometry.size.width * 0.54, y: 390)
            }
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
                .position(x:37, y:200)
            
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
                    .position(x:38, y:200)
            
            // Button to create a new mind map tile
            // Defining the object for button background
            Rectangle()
                .cornerRadius(10)
            // Defining the object size
                .frame(width: 60, height: 60)
            // Defining the object colour
                .foregroundColor(Color("DarkOrange"))
            // Defining the object position
                .position(x:37, y:275)
            
            // Defining button actions to add a mind map tile
            Button(action: {
                TileAmount += 1
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
                    .position(x:38, y:275)
            
            
            // Creating the button which resets how many mind map tiles are created (The maximum amount is 7)
            Button(action: {
                // Reseting the tile amount to zero so you only see the title tile
                TileAmount = 0
                //setting the positions of the mind map tiles to the position they start at before moving them.
                MindMapTitlePos = CGSize(width: 500, height: 500)
                MindMapPos1 = CGSize(width: 300, height: 300)
                MindMapPos2 = CGSize(width: 500, height: 300)
                MindMapPos3 = CGSize(width: 700, height: 300)
                MindMapPos4 = CGSize(width: 900, height: 300)
                MindMapPos5 = CGSize(width: 300, height: 600)
                MindMapPos6 = CGSize(width: 500, height: 600)
                MindMapPos7 = CGSize(width: 700, height: 600)
                
            }) {
                // Adding and resizing the icon that the button will present as
                Text("Reset")
                    // Resizing the icon image
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                    .background(Color("DarkOrange"))
                    .cornerRadius(10)
                }
                // Styling and repositioning the button
                .buttonStyle(PlainButtonStyle())
                .position(x:37, y:350)
            
            // Creating the button which saves the file information of the mind map text
            Button(action: {
                // Saving the files 😁
                writeFile(Filename: "MindMapTitle", Data: MindMapTitleStr)
                writeFile(Filename: "MindMapStr1", Data: MindMapStr1)
                writeFile(Filename: "MindMapStr2", Data: MindMapStr2)
                writeFile(Filename: "MindMapStr3", Data: MindMapStr3)
                writeFile(Filename: "MindMapStr4", Data: MindMapStr4)
                writeFile(Filename: "MindMapStr5", Data: MindMapStr5)
                writeFile(Filename: "MindMapStr6", Data: MindMapStr6)
                writeFile(Filename: "MindMapStr7", Data: MindMapStr7)
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
                .position(x:37, y:425)
        }
    }
}

// Mind map page title (orange square)
private extension ContentView{
    var MindMapTitle: some View{
        GeometryReader { geometry in
            ZStack{
                // The rounded rectangle background
                RoundedRectangle(cornerRadius: 10)
                    // Its size and color
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color("MapTitleOutline"))
                    // Its position is equal to the offset of the drag geasture.
                    .offset(MindMapTitlePos)
                    // Adding the ability to drag it across the screen
                    .gesture(
                        DragGesture()
                        // If the position changes then change the position of the rectangle
                            .onChanged{value in withAnimation(.spring()) {
                                MindMapTitlePos = value.translation
                                // Preventing the sticky note from leaving its intended area
                                if MindMapTitlePos.width <= 77 {
                                    MindMapTitlePos.width = 77
                                }
                                if MindMapTitlePos.height <= 132 {
                                    MindMapTitlePos.height = 132
                                }
                            }
                            }
                    )
                // The text editor inside the mind map title square
                TextEditor(text: $MindMapTitleStr)
                    // Defining the note's size and position
                    .frame(width: 80,height:80)
                    .offset(MindMapTitlePos)
                    // Centering the text in the title
                    .multilineTextAlignment(.center)
                    // Changing the color for mind map text square
                    .colorMultiply(Color("NormOrange"))
                
            }
        }
    }
}

// Mind map page for tile 1
private extension ContentView{
    var MindMapTile1: some View{
        GeometryReader { geometry in
            ZStack{
                // The rounded rectangle background
                RoundedRectangle(cornerRadius: 10)
                    // Its size and color
                    .frame(width: 200, height: 100)
                    .foregroundColor(Color("MindMapTileOutline"))
                    // Its position is equal to the offset of the drag geasture.
                    .offset(MindMapPos1)
                    // Adding the ability to drag it across the screen
                    .gesture(
                        DragGesture()
                        // If the position changes then change the position of the rectangle
                            .onChanged{value in withAnimation(.spring()) {
                                MindMapPos1 = value.translation
                                // Preventing the sticky note from leaving its intended area
                                if MindMapPos1.width <= 77 {
                                    MindMapPos1.width = 77
                                }
                                if MindMapPos1.height <= 132 {
                                    MindMapPos1.height = 132
                                }
                            }
                            }
                    )
                // The text editor inside the mind map tile square
                TextEditor(text: $MindMapStr1)
                    // Defining the note's size and position
                    .frame(width: 180,height:80)
                    .offset(x:MindMapPos1.width, y:MindMapPos1.height)
                    // Centering the text in the title
                    .multilineTextAlignment(.center)
                    // Changing the color for mind map text square
                    .colorMultiply(Color("MindMapTile"))
                
            }
        }
    }
}

// Mind map page for tile 2
private extension ContentView{
    var MindMapTile2: some View{
        GeometryReader { geometry in
            ZStack{
                // The rounded rectangle background
                RoundedRectangle(cornerRadius: 10)
                    // Its size and color
                    .frame(width: 200, height: 100)
                    .foregroundColor(Color("MindMapTileOutline"))
                    // Its position is equal to the offset of the drag geasture.
                    .offset(MindMapPos2)
                    // Adding the ability to drag it across the screen
                    .gesture(
                        DragGesture()
                        // If the position changes then change the position of the rectangle
                            .onChanged{value in withAnimation(.spring()) {
                                MindMapPos2 = value.translation
                                // Preventing the sticky note from leaving its intended area
                                if MindMapPos2.width <= 77 {
                                    MindMapPos2.width = 77
                                }
                                if MindMapPos2.height <= 132 {
                                    MindMapPos2.height = 132
                                }
                            }
                            }
                    )
                // The text editor inside the mind map tile square
                TextEditor(text: $MindMapStr2)
                    // Defining the note's size and position
                    .frame(width: 180,height:80)
                    .offset(x:MindMapPos2.width, y:MindMapPos2.height)
                    // Centering the text in the title
                    .multilineTextAlignment(.center)
                    // Changing the color for mind map text square
                    .colorMultiply(Color("MindMapTile"))
            }
        }
    }
}

// Mind map page for tile 3
private extension ContentView{
    var MindMapTile3: some View{
        GeometryReader { geometry in
            ZStack{
                // The rounded rectangle background
                RoundedRectangle(cornerRadius: 10)
                    // Its size and color
                    .frame(width: 200, height: 100)
                    .foregroundColor(Color("MindMapTileOutline"))
                    // Its position is equal to the offset of the drag geasture.
                    .offset(MindMapPos3)
                    // Adding the ability to drag it across the screen
                    .gesture(
                        DragGesture()
                        // If the position changes then change the position of the rectangle
                            .onChanged{value in withAnimation(.spring()) {
                                MindMapPos3 = value.translation
                                // Preventing the sticky note from leaving its intended area
                                if MindMapPos3.width <= 77 {
                                    MindMapPos3.width = 77
                                }
                                if MindMapPos3.height <= 132 {
                                    MindMapPos3.height = 132
                                }
                            }
                            }
                    )
                // The text editor inside the mind map tile square
                TextEditor(text: $MindMapStr3)
                    // Defining the note's size and position
                    .frame(width: 180,height:80)
                    .offset(x:MindMapPos3.width, y:MindMapPos3.height)
                    // Centering the text in the title
                    .multilineTextAlignment(.center)
                    // Changing the color for mind map text square
                    .colorMultiply(Color("MindMapTile"))
            }
        }
    }
}

// Mind map page for tile 4
private extension ContentView{
    var MindMapTile4: some View{
        GeometryReader { geometry in
            ZStack{
                // The rounded rectangle background
                RoundedRectangle(cornerRadius: 10)
                    // Its size and color
                    .frame(width: 200, height: 100)
                    .foregroundColor(Color("MindMapTileOutline"))
                    // Its position is equal to the offset of the drag geasture.
                    .offset(MindMapPos4)
                    // Adding the ability to drag it across the screen
                    .gesture(
                        DragGesture()
                        // If the position changes then change the position of the rectangle
                            .onChanged{value in withAnimation(.spring()) {
                                MindMapPos4 = value.translation
                                // Preventing the sticky note from leaving its intended area
                                if MindMapPos4.width <= 77 {
                                    MindMapPos4.width = 77
                                }
                                if MindMapPos4.height <= 132 {
                                    MindMapPos4.height = 132
                                }
                            }
                            }
                    )
                // The text editor inside the mind map tile square
                TextEditor(text: $MindMapStr4)
                    // Defining the note's size and position
                    .frame(width: 180,height:80)
                    .offset(x:MindMapPos4.width, y:MindMapPos4.height)
                    // Centering the text in the title
                    .multilineTextAlignment(.center)
                    // Changing the color for mind map text square
                    .colorMultiply(Color("MindMapTile"))
            }
        }
    }
}

// Mind map page for tile 5
private extension ContentView{
    var MindMapTile5: some View{
        GeometryReader { geometry in
            ZStack{
                // The rounded rectangle background
                RoundedRectangle(cornerRadius: 10)
                    // Its size and color
                    .frame(width: 200, height: 100)
                    .foregroundColor(Color("MindMapTileOutline"))
                    // Its position is equal to the offset of the drag geasture.
                    .offset(MindMapPos5)
                    // Adding the ability to drag it across the screen
                    .gesture(
                        DragGesture()
                        // If the position changes then change the position of the rectangle
                            .onChanged{value in withAnimation(.spring()) {
                                MindMapPos5 = value.translation
                                // Preventing the sticky note from leaving its intended area
                                if MindMapPos5.width <= 77 {
                                    MindMapPos5.width = 77
                                }
                                if MindMapPos5.height <= 132 {
                                    MindMapPos5.height = 132
                                }
                            }
                            }
                    )
                // The text editor inside the mind map tile square
                TextEditor(text: $MindMapStr5)
                    // Defining the note's size and position
                    .frame(width: 180,height:80)
                    .offset(x:MindMapPos5.width, y:MindMapPos5.height)
                    // Centering the text in the title
                    .multilineTextAlignment(.center)
                    // Changing the color for mind map text square
                    .colorMultiply(Color("MindMapTile"))
            }
        }
    }
}

// Mind map page for tile 6
private extension ContentView{
    var MindMapTile6: some View{
        GeometryReader { geometry in
            ZStack{
                // The rounded rectangle background
                RoundedRectangle(cornerRadius: 10)
                    // Its size and color
                    .frame(width: 200, height: 100)
                    .foregroundColor(Color("MindMapTileOutline"))
                    // Its position is equal to the offset of the drag geasture.
                    .offset(MindMapPos6)
                    // Adding the ability to drag it across the screen
                    .gesture(
                        DragGesture()
                        // If the position changes then change the position of the rectangle
                            .onChanged{value in withAnimation(.spring()) {
                                MindMapPos6 = value.translation
                                // Preventing the sticky note from leaving its intended area
                                if MindMapPos6.width <= 77 {
                                    MindMapPos6.width = 77
                                }
                                if MindMapPos6.height <= 132 {
                                    MindMapPos6.height = 132
                                }
                            }
                            }
                    )
                // The text editor inside the mind map tile square
                TextEditor(text: $MindMapStr6)
                    // Defining the note's size and position
                    .frame(width: 180,height:80)
                    .offset(x:MindMapPos6.width, y:MindMapPos6.height)
                    // Centering the text in the title
                    .multilineTextAlignment(.center)
                    // Changing the color for mind map text square
                    .colorMultiply(Color("MindMapTile"))
            }
        }
    }
}

// Mind map page for tile 7
private extension ContentView{
    var MindMapTile7: some View{
        GeometryReader { geometry in
            ZStack{
                // The rounded rectangle background
                RoundedRectangle(cornerRadius: 10)
                    // Its size and color
                    .frame(width: 200, height: 100)
                    .foregroundColor(Color("MindMapTileOutline"))
                    // Its position is equal to the offset of the drag geasture.
                    .offset(MindMapPos7)
                    // Adding the ability to drag it across the screen
                    .gesture(
                        DragGesture()
                        // If the position changes then change the position of the rectangle
                            .onChanged{value in withAnimation(.spring()) {
                                MindMapPos7 = value.translation
                                // Preventing the sticky note from leaving its intended area
                                if MindMapPos7.width <= 77 {
                                    MindMapPos7.width = 77
                                }
                                if MindMapPos7.height <= 132 {
                                    MindMapPos7.height = 132
                                }
                            }
                            }
                    )
                // The text editor inside the mind map tile square
                TextEditor(text: $MindMapStr7)
                    // Defining the note's size and position
                    .frame(width: 180,height:80)
                    .offset(x:MindMapPos7.width, y:MindMapPos7.height)
                    // Centering the text in the title
                    .multilineTextAlignment(.center)
                    // Changing the color for mind map text square
                    .colorMultiply(Color("MindMapTile"))
            }
        }
    }
}
// The home page extension which has all three of the quick launch options
private extension ContentView{
    var homepageRecentPage1: some View{
        GeometryReader { geometry in
            ZStack{
                // The first quick load page on the home page
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: geometry.size.width * 0.2, height: 530)
                    .position(x: geometry.size.width * 0.315, y: 462.5)
                    .foregroundColor(.white)
                // The text which appears in the first white box on the home page
                Text(readingFile(inputFile: RecentlyOpened1))
                    .background(.white)
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .frame(width: geometry.size.width * 0.18, height: 515)
                    .position(x: geometry.size.width * 0.315, y: 462.5)
                
                // Creating the button which loads up the first quick load page.
                Button(action: {
                    selectedNotePage = RecentlyOpened1
                    currentPage = 1
                }) {
                    // Adding and resizing the icon that the button will present as
                    Text("Open")
                        // Resizing the icon image
                        .frame(width: 60, height: 15)
                        .foregroundColor(.white)
                        .background(Color("DarkOrange"))
                        .cornerRadius(10)
                    }
                    // Styling and repositioning the button
                    .buttonStyle(PlainButtonStyle())
                    .position(x: geometry.size.width * 0.315, y: 737)
                
                // The seccond quick load page on the home page
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: geometry.size.width * 0.2, height: 530)
                    .position(x: geometry.size.width * 0.54, y: 462.5)
                    .foregroundColor(.white)
                // The text which appears in the seccond white box on the home page
                Text(readingFile(inputFile: RecentlyOpened2))
                    .background(.white)
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .frame(width: geometry.size.width * 0.18, height: 515)
                    .position(x: geometry.size.width * 0.54, y: 462.5)
                
                // Creating the button which loads up the seccond quick load page.
                Button(action: {
                    selectedNotePage = RecentlyOpened2
                    currentPage = 1
                }) {
                    // Adding and resizing the icon that the button will present as
                    Text("Open")
                        // Resizing the icon image
                        .frame(width: 60, height: 15)
                        .foregroundColor(.white)
                        .background(Color("DarkOrange"))
                        .cornerRadius(10)
                    }
                    // Styling and repositioning the button
                    .buttonStyle(PlainButtonStyle())
                    .position(x: geometry.size.width * 0.54, y: 737)
                
                // The third quick load page on the home page
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: geometry.size.width * 0.2, height: 530)
                    .position(x: geometry.size.width * 0.765, y: 462.5)
                    .foregroundColor(.white)
                // The text which appears in the third white box on the home page
                Text(readingFile(inputFile: RecentlyOpened3))
                    .background(.white)
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .frame(width: geometry.size.width * 0.18, height: 515)
                    .position(x: geometry.size.width * 0.765, y: 475)
                
                // Creating the button which loads up the third quick load page.
                Button(action: {
                    selectedNotePage = RecentlyOpened3
                    currentPage = 1
                }) {
                    // Adding and resizing the icon that the button will present as
                    Text("Open")
                        // Resizing the icon image
                        .frame(width: 60, height: 15)
                        .foregroundColor(.white)
                        .background(Color("DarkOrange"))
                        .cornerRadius(10)
                    }
                    // Styling and repositioning the button
                    .buttonStyle(PlainButtonStyle())
                    .position(x: geometry.size.width * 0.765, y: 737)
            }
        }
    }
}

private extension ContentView{
    var PageOutline: some View{
        GeometryReader { geometry in
            VStack{
                // Creating the side bar for every page other than the home page
                // Defining the object
                Rectangle()
                // Defining the object size
                    .frame(width:155, height: 6000)
                // Defining the object colour
                    .foregroundColor(Color("NormOrange"))
                // Defining the object position
                    .position(x: -1, y: 0)
                
                // Creating the top bar for the Home Page i love men
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
                    .position(x: geometry.size.width*0.955, y: 22)
            }
        }
    }
}
