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


struct PlayerView: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
    }

    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(frame: .zero)
    }
}


class LoopingPlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    private var audio: AVAudioPlayer?



    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Load the resource
        let fileUrl = Bundle.main.url(forResource: "menu", withExtension: "mov")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        

        // Setup the player
        let player = AVQueuePlayer()
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)

        // Create a new player looper with the queue player and template item
        playerLooper = AVPlayerLooper(player: player, templateItem: item)

        // Start the movie
        player.play()
        self.audio = try! AVAudioPlayer(contentsOf: fileUrl)
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}


struct SplashView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return splashScreenUIView(frame: .zero)
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<SplashView>) {
    }

}

class splashScreenUIView: UIView {
    private let splashLayer = AVPlayerLayer()
    private var audio: AVAudioPlayer?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)

        // Load the resource
        let fileUrl = Bundle.main.url(forResource: "splashanim", withExtension: "mov")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)

        
        // Setup the player
        let player = AVQueuePlayer()
        splashLayer.player = player
        splashLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(splashLayer)

        //Start splash screen animation
        player.play()
        self.audio = try! AVAudioPlayer(contentsOf: fileUrl)
        

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        splashLayer.frame = bounds
    }
}


struct ContentView: View {
    var body: some View {

            ZStack {
                PlayerView()
                .edgesIgnoringSafeArea(.all)

        }
    }
}
