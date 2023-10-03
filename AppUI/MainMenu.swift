//
//  MainMenu.swift
//  AppUI
//
//  Created by Anissa on 10/3/23.
//

import SwiftUI
import AVKit
import UIKit
import AVFoundation
import Combine


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

struct MainMenu: View {
    var body: some View {
        NavigationStack {
            ZStack {
                PlayerView()
                    .edgesIgnoringSafeArea(.all)
                NavigationLink(destination: CreditsView()) {
                    Image(systemName:"info")
                        .foregroundColor(Color.black)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 23)
                        .background(Color.white)
                        .cornerRadius(100)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .position(x: 780, y: 355)
                        .imageScale(/*@START_MENU_TOKEN@*/.large/*@END_MENU_TOKEN@*/)
                        .opacity(0.6)
                        .onTapGesture {
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        }
                }
                NavigationLink(destination: CreditsView()) {
                    Image(systemName:"bell.fill")
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                        .padding(.vertical, 17)
                        .padding(.horizontal, 17)
                        .background(Color.white)
                        .cornerRadius(100)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .position(x: 730, y: 355)
                        .imageScale(/*@START_MENU_TOKEN@*/.large/*@END_MENU_TOKEN@*/)
                        .opacity(0.6)
                }

            }
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
