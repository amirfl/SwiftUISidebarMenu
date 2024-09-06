//
//  ContentView.swift
//
//  SwiftUISidebarMenu
//
//  Created by Amir Fleminger on 9/5/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        SidebarContainerView(sideBarTitleView: AnyView(Text("My App").font(.largeTitle).padding()))
    }
}


#Preview {
    ContentView()
}

