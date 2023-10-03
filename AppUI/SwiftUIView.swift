//
//  SwiftUIView.swift
//  AppUI
//
//  Created by Anissa on 10/3/23.
//

import SwiftUI
import AVKit
import UIKit
import AVFoundation
import Combine



struct SplashView: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<SplashView>) {
    }

    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(frame: .zero)
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
        let player = AVQueuePlayer()
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

struct SwiftUIView: View {
    @State var isActive : Bool = false
    
    var body: some View {
        ZStack {
            if isActive {
                ContentView()
            } else
            {
                PlayerView()
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    }
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
