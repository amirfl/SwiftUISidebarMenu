//
//  SidebarMenuDestinations.swift
//  SwiftUISidebarMenu
//
//  Created by Amir Fleminger on 9/6/24.
//

import SwiftUI

/**Customise this enum with the side bar destinations for the app*/
enum SideMenuDestination: String, Hashable {
    case homePage // Replace with your actual destination
    case settingsPage // Replace with your actual destination
    // Add more destinations here
    
    static func menuItems() -> [SidebarMenuItem] {
        return [
            SidebarMenuItem(title: "Home", destination: .homePage), // Replace with your actual title
            SidebarMenuItem(title: "Settings", destination: .settingsPage), // Replace with your actual title
            // Add more menu items here
        ]
    }
    /**Add a case for each destination in the app*/
    @ViewBuilder
    static func destinationView(for destination: SideMenuDestination) -> some View {
        switch destination {
        case .homePage:
            HomePageView() // Replace with your actual view
        case .settingsPage:
            SettingsPage() // Replace with your actual view
        // Add more cases here
        }
    }
}
