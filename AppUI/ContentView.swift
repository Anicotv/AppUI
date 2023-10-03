//
//  ContentView.swift
//  AppUI
//
//  Created by Anissa on 10/2/23.
//

import SwiftUI
import AVKit
import AVFoundation
import Combine
import UIKit

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SplashView: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<SplashView>) {
    }

    func makeUIView(context: Context) -> UIView {
        return SplashUIView(frame: .zero)
    }
}


class SplashUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var audio: AVAudioPlayer?



    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Load the resource
        let fileUrl = Bundle.main.url(forResource: "splashanim", withExtension: "mov")!


        // Setup the player
        let player = AVPlayer(url: fileUrl)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)

        // Start the movie
        player.play()
        self.audio = try! AVAudioPlayer(contentsOf: fileUrl)

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}


struct ContentView: View {
    @State var isActive : Bool = false

    var body: some View {

        if isActive {
            MainMenu()
        } else {
            ZStack {
                SplashView()
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {                            withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}


