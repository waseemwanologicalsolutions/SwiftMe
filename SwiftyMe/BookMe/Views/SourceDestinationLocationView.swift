//
//  SourceDestinationLocationView.swift
//  SwiftyMe
//
//  Created by MacBook on 02/02/2023.
//

import Foundation
import SwiftUI
import Combine

struct SourceDestinationLocationView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var searchRouteViewModel:SearchRouteViewModel
    @Binding var showScreen:Bool
    @StateObject var vm = SourceDestinationLocationViewModel()
    @State var searchInputFrom:String = ""
    @State var searchInputTo:String = ""
    
    var body: some View {
        VStack{
            
            HeaderView
            HStack{
                Text(searchRouteViewModel.isSourceLocationSelectting ? "Select Deparature" : "Select Arrival")
                    .font(.sfProRounded(.title, weight:.bold))
                    .padding()
                Spacer()
            }
            
            List(vm.locationRoutes) { item in
                LocationRouteListRowView(item: item)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        if searchRouteViewModel.isSourceLocationSelectting{
                            searchRouteViewModel.selectedLocationFrom = item
                            searchInputFrom = item.name ?? ""
                            searchRouteViewModel.selectedLocationTo = nil
                            searchInputTo = ""
                            withAnimation{
                                searchRouteViewModel.isSourceLocationSelectting = false
                            }
                        }else{
                            searchRouteViewModel.selectedLocationTo = item
                            searchInputTo = item.name ?? ""
                        }
                        self.didLocationSelected()
                    }
                
            }.listStyle(.plain)
            
            
        }
        .navigationBarHidden()
        .onAppear{
            vm.locationRoutes = SourceDestinationLocationViewModelData.initServicesList()
            searchInputFrom = searchRouteViewModel.selectedLocationFrom?.name ?? ""
            searchInputTo = searchRouteViewModel.selectedLocationTo?.name ?? ""
        }
    }
    
    func didLocationSelected(){
        if searchRouteViewModel.selectedLocationFrom != nil && searchRouteViewModel.selectedLocationTo != nil{
            self.mode.wrappedValue.dismiss()
        }
    }
    
    var HeaderView: some View {
        
        VStack(spacing: 10){
            
            LocationFromView
                .onTapGesture {
                    withAnimation{
                        searchRouteViewModel.isSourceLocationSelectting = true
                    }
                }
            LocationToView
                .padding([.bottom], 20)
                .onTapGesture {
                    withAnimation{
                        searchRouteViewModel.isSourceLocationSelectting = false
                    }
                }
            
        }
        .background(Color.bm_blue_bg)
    }
    
    var LocationFromView: some View {
        
        VStack(spacing: 10){
            HStack(alignment: .center){
                ZStack{
                    Rectangle()
                        .fill(searchRouteViewModel.isSourceLocationSelectting ? Color.bm_field_bg : Color.bm_location_field_inactive)
                        .cornerRadius(5)
                    HStack{
                        TextField("From", text:$searchInputFrom,
                                  onEditingChanged: { changed in
                            if changed {
                                print(searchInputFrom)
                            }else{
                                print("no change")
                            }
                        })
                        .onReceive(Just(searchInputFrom)) { searchInput in
                            print(searchInput)
                        }
                        .keyboardType(.default)
                        .foregroundColor(searchRouteViewModel.isSourceLocationSelectting ? Color.bm_black_text : Color.white)
                        .frame(maxWidth: .infinity)
                        .padding([.leading], 15)
                        .padding([.trailing], 5)
                        
                        TextFieldClearButton{
                           searchInputFrom = ""
                        }
                        
                        Divider()
                        
                        if searchRouteViewModel.isSourceLocationSelectting == true{
                            RectButton(title: "Cancel", foreground: Color.blue, background: Color.clear, height: 40, weight: .regular){
                                print("cancel")
                                hideKeyboard()
                                showScreen = false
                            }
                            .frame(width: 85)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 46)
            }
            .padding([.leading, .trailing], 10)
            
        }
        
    }
    
    var LocationToView: some View {
        
        VStack(spacing: 10){
            HStack(alignment: .center){
                ZStack{
                    Rectangle()
                        .fill(searchRouteViewModel.isSourceLocationSelectting ? Color.bm_location_field_inactive : Color.bm_field_bg)
                        .cornerRadius(5)
                    HStack{
                        TextField("From", text:$searchInputTo,
                                  onEditingChanged: { changed in
                            if changed {
                                print(searchInputTo)
                            }else{
                                print("no change")
                            }
                        })
                        .onReceive(Just(searchInputTo)) { searchInput in
                            print(searchInput)
                        }
                        .keyboardType(.default)
                        .foregroundColor(searchRouteViewModel.isSourceLocationSelectting ? Color.white : Color.bm_black_text)
                        .frame(maxWidth: .infinity)
                        .padding([.leading], 15)
                        .padding([.trailing], 5)
                        
                        TextFieldClearButton{
                           searchInputTo = ""
                        }
                        
                        Divider()
                        if searchRouteViewModel.isSourceLocationSelectting == false{
                            RectButton(title: "Cancel", foreground: Color.blue, background: Color.clear, height: 40, weight: .regular){
                                print("cancel")
                                hideKeyboard()
                                showScreen = false
                            }
                            .frame(width: 85)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 46)
            }
            .padding([.leading, .trailing], 10)
            
        }
        
    }
}


struct SourceDestinationLocationView_Previews: PreviewProvider {
    static var previews: some View {
        SourceDestinationLocationView(showScreen: .constant(false))
            .environmentObject(SearchRouteViewModel())
    }
}


struct LocationRouteListRowView:View{
    @State var item:LocationRouteModel
    
    var body: some View{
        ZStack{
            Color.bm_white_text
            VStack{
                Spacer()
                /*
                Button{
                    item.isSelected.toggle()
                    print("item=", item.isSelected)
                }label: {
                    
                }*/
                
                HStack{
                    
                    Image(systemName: "car.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                    
                    Text(item.name ?? "")
                        .foregroundColor(item.isSelected ? Color.blue: Color.bm_black_text)
                    
                    Spacer()
                    
                    HStack{
                        Text(item.shortCode ?? "")
                            .foregroundColor(Color.bm_black_text)
                            .font(.sfProRounded(11))
                    }
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4.0)
                            .stroke(Color.gray, lineWidth: 1))
                    
                    
                }
                .padding([.leading, .trailing], 15)
                .padding([.bottom], 8)
                .padding([.top], 8)
                Divider()
            }
            .frame(maxWidth: .infinity)

        }
        
    }
}
