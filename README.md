# SwiftUI Sidebar Menu

## By Amir Fleminger

This is a reusable SwiftUI Sidebar Menu designed for easy integration into any SwiftUI project. The sidebar allows for customizable destinations and menu items, making it an ideal solution for projects that require quick and efficient navigation between different views.

## Features
- Reusable Sidebar Menu: Easily integrate the sidebar into any SwiftUI app with minimal configuration.
- Persistent Navigation: Uses AppStorage to store the last selected destination, allowing users to resume where they left off.
- Customizable Menu Items: Modify destinations in one place for ease of use in new projects.
- Responsive Sidebar: With animations and a hamburger menu for easy toggling of the sidebar.

## File Structure

### SidebarMenuDestinations.swift
Customize this file according to your navigation structure. This file defines the possible destinations for the sidebar. You should customize the destinations here by modifying the SideMenuDestination enum.

### SidebarMenu.swift
This file contains:
- `SidebarContainerView` struct: The main container for the sidebar and the destination views. It manages the display of the sidebar and the content area based on which destination is selected.
- `SidebarMenuItem` struct: Defines the structure of individual menu items.
- `SidebarViewModel` class: Manages the state of the sidebar, including which destination is currently selected and storing/restoring the last selected destination using AppStorage.
- `SidebarView` struct: Defines the layout and functionality of the sidebar itself.

### ContentView.swift
This file is a simple entry point that initializes the SidebarContainerView. You can pass a custom title view for the sidebar.

## Installation & Usage

1. Copy the files: Add SidebarMenuDestinations.swift, ContentView.swift and SideBarMenu.swift to your SwiftUI project.
2. Customize Destinations: Modify the SideMenuDestination enum in SidebarMenuDestinations.swift to fit your app’s navigation structure.
3. Customize Menu Items: Update the menuItems() function in SidebarMenuDestinations.swift to reflect the actual destinations and titles for your app.
4. Customize the Sidebar Title: Pass a custom title view when calling SidebarContainerView in ContentView.swift if needed.

## License
Distributed under Open Source License
