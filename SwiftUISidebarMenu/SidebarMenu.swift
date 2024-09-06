//
//  SideBarMenu.swift
//
//  SwiftUISidebarMenu
//
//  Created by Amir Fleminger on 9/6/24.
//

import SwiftUI

struct SidebarMenuItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let destination: SideMenuDestination
}

class SidebarViewModel: ObservableObject {
    // Encapsulate AppStorage inside the ViewModel
    @AppStorage("lastSelectedDestination") private var lastSelectedDestinationRawValue: String?

    @Published var navigationPath: [SideMenuDestination] = []
    @Published var selectedDestination: SideMenuDestination? {
        didSet {
            saveLastSelectedDestination()
        }
    }

    let menuItems: [SidebarMenuItem] = SideMenuDestination.menuItems()
    
    func navigate(to destination: SideMenuDestination) {
        navigationPath = [destination]
    }
    
    // Save the last selected destination to AppStorage
    private func saveLastSelectedDestination() {
        if let selectedDestination = selectedDestination {
            lastSelectedDestinationRawValue = selectedDestination.rawValue
        }
    }
    
    // Restore the last selected destination from AppStorage
    func restoreLastSelectedDestination() {
        if let rawValue = lastSelectedDestinationRawValue,
           let destination = SideMenuDestination(rawValue: rawValue) {
            selectedDestination = destination
        }
    }
}

/**The side bar itself**/
struct SidebarView: View {
    @ObservedObject var viewModel: SidebarViewModel
    @Binding var isSidebarVisible: Bool
    var titleView: AnyView?
    
    var body: some View {
        VStack(spacing: 0) {
            titleView
            
            List {
                ForEach(viewModel.menuItems) { item in
                    Button(action: {
                        viewModel.selectedDestination = item.destination
                        withAnimation {
                            isSidebarVisible = false
                        }
                    }) {
                        Text(item.title)
                    }
                    .padding()
                }
            }
            .listStyle(.plain)
        }
        .frame(width: 270)
        .frame(maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
    }
}

/**Holds the side bar and the destination pages**/
struct SidebarContainerView: View {
    @StateObject private var sidebarViewModel = SidebarViewModel()
    @State private var isSidebarVisible = false
    var sideBarTitleView: AnyView?
    
    var body: some View {
        NavigationStack(path: $sidebarViewModel.navigationPath) {
            ZStack {
                // Main content
                Group {
                    if let selectedDestination = sidebarViewModel.selectedDestination {
                        SideMenuDestination.destinationView(for: selectedDestination)
                    } else {
                        Text("Select an item from the menu")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                        Color.black.ignoresSafeArea()
                        .opacity(isSidebarVisible ? 0.4 : 0)
                        .onTapGesture {
                            withAnimation {
                                isSidebarVisible = false
                            }
                        }
                )
                
                // Sidebar
                GeometryReader { geometry in
                    HStack(spacing: 0) {
                        SidebarView(viewModel: sidebarViewModel, isSidebarVisible: $isSidebarVisible, titleView: sideBarTitleView)
                            .frame(width: 300)
                            .frame(height: geometry.size.height)
                            .background(Color(UIColor.systemBackground))
                            .offset(x: isSidebarVisible ? 0 : -300)
                        
                        Spacer()
                    }
                }
                .animation(.easeInOut, value: isSidebarVisible)
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                sidebarViewModel.restoreLastSelectedDestination()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        withAnimation {
                            isSidebarVisible.toggle()
                        }
                    }) {
                        Image(systemName: "line.3.horizontal")
                    }
                }
            }
        }
    }
}

