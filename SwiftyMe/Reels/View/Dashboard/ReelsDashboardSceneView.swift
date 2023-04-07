//
//  ReelsDashboardSceneView.swift
//  SwiftyMe
//
//  Created by MacBook on 30/03/2023.
//

import SwiftUI
import AVKit

struct ReelsDashboardSceneView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var stateManager:StateManager
    @StateObject var vm = ReelsDashboardSceneViewModel()
    @State private var selectedSortType = "Most Voted"
    @Binding var tabSelection: TabBarItem
    let filterTypes = ["Most Voted", "Most Recent", "Oldest"]
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 350, maximum: UIScreen.main.bounds.width - 30))
    ]
    
    var body: some View {
        ZStack{
            VStack{
                HeaderView
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        Section(
                            header: ReelListHeaderView(vm: vm)
                                .padding([.horizontal])
                                
                        ){
                            
                            ForEach(vm.datasource, id: \.id) { item in
                                ReelListCardView(reel: item, vm: vm)
                                    //.padding([.horizontal])
                            }
                        }
                    }
                }
            }
        }
        .redacted(reason: vm.isLoading ? .placeholder : [])
        .navigationBarHidden(true)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .buttonStyle(.plain)
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea([.bottom])
        //.padding([.top])
        .onAppear{
            if vm.isAPICall == false{
                vm.datasource = stateManager.data
                DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                    vm.isAPICall = true
                    vm.isLoading = false
                }
            }
            
        }
        .alert(isPresented: $vm.showAlert) {
            switch vm.activeAlert{
            case .confirmation:
                return Alert(
                    title: Text("Are you ready to confirm?"),
                    primaryButton: .destructive(Text("Let's do it!")) {
                         
                        print("did we reach the bottom?")

                    },
                    secondaryButton: .cancel())
            case .error:
              return  Alert(
                title: Text(vm.errorMsgTitle),
                message: Text(vm.errorMsg)
                )
            }
        }
        .onChange(of: vm.showVideoFeeds){ newVal in
            tabSelection = .feed
        }
        /*
        .navigationDestination(isPresented: $vm.showSubmitEnttry) {
            SubmitEntrySceneView(tabSelection: .constant(.add))
        }
        .navigationDestination(isPresented: $vm.showVideoFeeds) {
            
            VideosFeedSceneView(data: $vm.datasource, tabSelection: .constant(.feed))
        }*/
    }
    
    var HeaderView: some View {
        
        VStack(spacing: 15){
            
            HStack(alignment: .center, spacing: 5){
                
                Button(action:{
                    self.mode.wrappedValue.dismiss()
                }){
                    HStack{
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.reel_black_text)
                            .frame(width: 26, height: 26)
                        Spacer()
                    }
                }
                .frame(width: 40, height: 40)
                .padding([.leading], 10)
                
                Spacer()
                
                Link(destination: URL(string: "https://tripscon.com/contest/public/rules")!){
                    Text("Rules")
                        .underline()
                        .font(.sfProRounded(16, weight: .regular))
                        .foregroundColor(Color.reel_black_text)
                }
                
                HStack{
                    Menu {
                        Picker(selection: $selectedSortType) {
                            ForEach(filterTypes, id: \.self) {
                                Text($0)
                            }
                        }label: {
                            Text("Sort")
                                .font(.largeTitle)
                        }
                        .font(.sfProRounded(16, weight: .bold))
                        .underline()
                        .foregroundColor(Color.reel_black_text)
                        .tint(Color.reel_black_text)
                    }
                    
                }
                .frame(height: 40)
                .frame(minWidth: 100)
                
                RectButton(title: "+", foreground: Color.reel_white_text, background: Color.reel_black_text, fontSize: 30, height: 40, weight: .semibold){
                    print("Submit Entry")
                    
                    //self.vm.showSubmitEnttry.toggle()
                    self.tabSelection = .add
                }
                .frame(width: 40)
                .cornerRadius(20)
                .padding([.trailing])
                
                
            }
            .padding([.leading, .trailing], 1)
            .padding([.bottom], 10)
            .shadow(radius: 0)
    
        }
        .frame(maxWidth:.infinity)
        .background(Color.reel_white_text)
        .shadow(color:Color.reel_black_text.opacity(0.35), radius: 4, x: 0, y: 2)
    }
    
}

struct ReelsDashboardSceneView_Previews: PreviewProvider {
    static var previews: some View {
        ReelsDashboardSceneView(tabSelection: .constant(.home))
    }
}
