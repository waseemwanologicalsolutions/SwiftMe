//
//  AnimateSampleView.swift
//  SwiftyMe
//
//  Created by MacBook on 16/01/2023.
//

import SwiftUI

struct AnimateSampleView: View {
    
    @State private var rotateToggle = true
    @State private var slideToggle = false
    @State private var fadeToggle = false
    @State private var slideupToggle = false
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Group{
                        Text("Rotate scale")
                        RotateScaleExample
                    }
                }
                VStack{
                    HStack{
                        Text("Slide")
                        SlideExample
                    }
                    if slideToggle{
                        HikeView(hike: ModelData().hikes[0])
                            .transition(.slide)
                    }
                }
                VStack{
                    HStack{
                        Text("Fade")
                        FadeToggleExample
                    }
                    if fadeToggle{
                        HikeView(hike: ModelData().hikes[0])
                            .transition(.opacity)
                    }
                }
                VStack{
                    HStack{
                        Text("Slide view up")
                        SlideUpToggleExample
                    }
                }
                
                Spacer()
            }
            overlays
        }
    }
    
    var SlideUpToggleExample: some View{
        VStack{
            Button {
                withAnimation {
                    slideupToggle.toggle()
                }
            } label: {
                Label("Graph", systemImage: "chevron.right.circle")
                    .labelStyle(.iconOnly)
                    .imageScale(.large)
                    .rotationEffect(.degrees(slideupToggle ? 90 : 0))
                    .scaleEffect(slideupToggle ? 1.5 : 1)
                    .padding()
            }
            
        }
    }
    
    var FadeToggleExample: some View{
        VStack{
            Button {
                withAnimation {
                    fadeToggle.toggle()
                }
            } label: {
                Label("Graph", systemImage: "chevron.right.circle")
                    .labelStyle(.iconOnly)
                    .imageScale(.large)
                    .rotationEffect(.degrees(fadeToggle ? 90 : 0))
                    .scaleEffect(fadeToggle ? 1.5 : 1)
                    .padding()
            }
            
        }
    }
    
    var SlideExample: some View{
        VStack{
            Button {
                withAnimation {
                    slideToggle.toggle()
                }
            } label: {
                Label("Graph", systemImage: "chevron.right.circle")
                    .labelStyle(.iconOnly)
                    .imageScale(.large)
                    .rotationEffect(.degrees(slideToggle ? 90 : 0))
                    .scaleEffect(slideToggle ? 1.5 : 1)
                    .padding()
            }
            
        }
    }
    
    var RotateScaleExample: some View{
        VStack{
            Button {
                withAnimation {
                    rotateToggle.toggle()
                }
            } label: {
                Label("Graph", systemImage: "chevron.right.circle")
                    .labelStyle(.iconOnly)
                    .imageScale(.large)
                    .rotationEffect(.degrees(rotateToggle ? 90 : 0))
                    .scaleEffect(rotateToggle ? 1.5 : 1)
                    .padding()
            }
            
        }
    }
    
    var overlays: some View{
        Group{
            ZStack(alignment: .bottom){
                if slideupToggle{
                    Color.black
                        .opacity(0.75)
                        .transition(.opacity)
                        .ignoresSafeArea()
                    Button {
                        withAnimation {
                            slideupToggle.toggle()
                        }
                    } label: {
                        Label("Graph", systemImage: "chevron.right.circle")
                            .labelStyle(.iconOnly)
                            .imageScale(.large)
                            .padding()
                    }
                    .background(Color.red)
                    .frame(width:400,height: 400)
                    .transition(.move(edge: .bottom))
                    .environment(\.locale, Locale(identifier: "en_GB"))
                }
            }
            .animation(.easeInOut, value: slideupToggle)
        }
    }
    
}

struct AnimateSampleView_Previews: PreviewProvider {
    static var previews: some View {
        AnimateSampleView()
    }
}

