//
//  ContentView.swift
//  FTCEventAPITool
//
//  Created by Isaac Nelson on 1/20/23.
//

import SwiftUI

struct Screen: Identifiable {
    let name: String
    let icon: Image
    var id: String { name }
}

// Main view thing
struct ContentView: View {
    let screens: [Screen] = [
        Screen(  // Event code and schedule
            name: "Home",
            icon: Image(systemName: "house")
        ),
        Screen(  // Match (and team?) search
            name: "Search",
            icon: Image(systemName: "magnifyingglass")
        ),
        Screen(  // Alliance selector
            name: "Alliance",
            icon: Image(systemName: "person.2")
        ),
        Screen(  // Auth settings
            name: "Settings",
            icon: Image(systemName: "gear")
        )
    ]
    @State private var curScreen = "Home"

    let min_width: CGFloat = 640
    let min_height: CGFloat = 480
    let default_padding: CGFloat = 7
    var controller = Controller()
    
    var body: some View {
        
        NavigationSplitView {
            VStack{
                Image("LogoForApp")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.all, default_padding+5)
                    .frame(maxWidth: 128)
                
                ForEach(screens) {screen in
                    HStack{
                        Button(action: {curScreen = screen.name}) {
                            screen.icon.frame(maxWidth: 24)
                            Text(screen.name)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(screen.name == curScreen ? Color.purple : Color.primary)
                        }
    
                        Spacer()
                    }
                    .padding(.all, default_padding)
                }
                
                Spacer()
                
                Button(action: {
                    controller.refreshData()
                    controller.refreshEncodedToken()
                }) {
                    Image(systemName: "arrow.clockwise")
                        .frame(maxWidth: 24)
                }
                .padding()
                
            }.navigationSplitViewColumnWidth(144)
        } detail: {
            switch curScreen {
            case "Search":
                searchView(controller: controller)
            case "Alliance":
                allianceView(controller: controller)
            case "Settings":
                settingsView(controller: controller)
            default:
                homeView(controller: controller)
            }
        }
        .frame(minWidth: min_width, minHeight: min_height)
    }

}

// My views
struct homeView: View {
    var controller: Controller
    var body: some View {
        Text("Home")
            .padding()
        
    }
}
struct searchView: View {
    var controller: Controller
    var body: some View {
        VStack {
            Text("Search")
                .padding()
            ForEach(controller.schedule.schedule) { scheduleElement in
                Text(scheduleElement.description)
            }
            Text("Shaking and crying")
        }
    }
}
struct allianceView: View {
    var controller: Controller
    var body: some View {
        Text("Alliance")
            .padding()
    }
}
struct settingsView: View {
    @ObservedObject var controller: Controller
    
    var body: some View {
        VStack {
            Spacer()
            Text("Set your authentication username and password for the ftc-api here!")
                .padding()
                .font(.title)
            Text("Current API username: \(controller.username)")
            Text("Current API auth token: \(controller.authToken)")
            Text("Current API encoded token: \(controller.encodedToken)")
            Spacer()
            Form (content: {
                TextField(text: $controller.username, prompt: Text("Required")) {
                    Text("Username")
                }
                TextField(text: $controller.authToken, prompt:
                            Text("Required")) {
                    Text("Authentication Token")
                }
                           
            })
            .onSubmit {
                controller.refreshEncodedToken()
                controller.refreshData()
            }
            .frame(maxWidth: 480)
            .padding()
            
            Spacer()
        }
    }
}

// Preview stuff
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
