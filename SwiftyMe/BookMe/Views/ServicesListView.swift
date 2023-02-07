//
//  ServicesListView.swift
//  SwiftyMe
//
//  Created by MacBook on 25/01/2023.
//

import SwiftUI
import Combine

struct ServicesListView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var searchRouteViewModel:SearchRouteViewModel
    @Binding var showServiceScreen:Bool
    @StateObject var vm:ServicesListViewModel = ServicesListViewModel()
    @State var searchInput:String = ""
    
    
    var body: some View {
        VStack{
            HeaderView
            
            List(vm.services) { item in
                ServiceListRowView(item: item)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        searchRouteViewModel.selectedService = item
                        self.mode.wrappedValue.dismiss()
                    }
                
            }.listStyle(.plain)
            
            
        }
        .navigationBarHidden()
        .onAppear{
            vm.services = ServiceListViewModelData.initServicesList()
        }
    }
    
    
    var HeaderView: some View {
        
        VStack(spacing: 15){
            
            HStack(alignment: .center){
                ZStack{
                    Rectangle()
                        .fill(Color.bm_field_bg)
                        .cornerRadius(5)
                    HStack{
                        TextField("Search service", text:$searchInput,
                                  onEditingChanged: { changed in
                            if changed {
                                print(searchInput)
                            }
                            else{
                                print("no change")
                            }
                        })
                        .onReceive(Just(searchInput)) { searchInput in
                            print(searchInput)
                        }
                        .keyboardType(.default)
                        .foregroundColor(Color.bm_black_text)
                        .frame(maxWidth: .infinity)
                        .padding([.leading], 15)
                        .padding([.trailing], 5)
                        
                        Divider()
                        
                        RectButton(title: "Cancel", foreground: Color.blue, background: Color.clear, height: 40, weight: .regular){
                            print("cancel")
                            hideKeyboard()
                            showServiceScreen = false
                        }
                        .frame(width: 85)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 46)
            }
            .padding([.leading, .trailing], 10)
            .padding([.bottom], 20)
            
        }
        .background(Color.bm_blue_bg)
    }
}


struct ServicesListView_Previews: PreviewProvider {
    static var previews: some View {
        ServicesListView(showServiceScreen: .constant(false))
    }
}


struct ServiceListRowView:View{
    @State var item:SericeModel
    
    var body: some View{
        ZStack{
            VStack{
                Spacer()
                Button{
                    item.isSelected.toggle()
                    print("item=", item.isSelected)
                }label: {
                    HStack{
                        
                        Text(item.name ?? "")
                            .foregroundColor(item.isSelected ? Color.blue: Color.bm_black_text)
                        
                        Text(" - ")
                        
                        Text(item.discount ?? "")
                            .foregroundColor(Color.bm_black_text)
                        Spacer()
                        
                    }
                    .padding([.leading, .trailing], 15)
                    .padding([.bottom], 8)
                    .padding([.top], 8)
                    Divider()
                }
                //Spacer()
            }
           
            .frame(maxWidth: .infinity)
            //.frame(minHeight:100)
           
        }
        
    }
}
