//
//  AudioManager.swift
//  Loopliner
//
//  Created by Lonard Steven on 20/01/25.
//

import AVFoundation
import Foundation
import SwiftUI

class AudioManager: ObservableObject {
    static let helper = AudioManager()
    var audioPlayer: AVAudioPlayer!
    var secondAudioPlayer: AVAudioPlayer!
    var sfxPlayer: AVAudioPlayer!
    
    private var playbackMonitorTimer: Timer?
    private var playbackMonitorSecondLayerTimer: Timer?
    @Published var isMusicPlaying = false
    
    @AppStorage("musicEnabled") private var isMusicEnabled: Bool = true
    @AppStorage("sfxEnabled") private var isSfxEnabled: Bool = true
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(stopAudioWhenInBackground), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    func playBackgroundMusic(assetName: String, volume: Float = 0.4, loopStartTime: TimeInterval = 0, loopEndTime: TimeInterval = 13.25) {
        guard !isMusicPlaying else { return }
        
        guard let backgroundMusicAsset = NSDataAsset(name: assetName) else {
            print("Error: A background music file couldn't be found in Assets, with the name of: \(assetName)")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(data: backgroundMusicAsset.data)
            audioPlayer.numberOfLoops = 0
            audioPlayer.currentTime = loopStartTime
            audioPlayer.setVolume(volume, fadeDuration: 3)
            audioPlayer.play()
            
            startPlaybackMonitor(loopStartTime: loopStartTime, loopEndTime: loopEndTime)
        } catch {
            print("Background music couldn't be played, due to: \(error.localizedDescription)")
        }
    }
    
    func playBackgroundMusicOnce(assetName: String, volume: Float = 0.4) {
        guard !isMusicPlaying else { return }
        
        guard let backgroundMusicAsset = NSDataAsset(name: assetName) else {
            print("Error: A background music file played once couldn't be found in Assets, with the name of: \(assetName)")
            return
        }
        
        do {
            playbackMonitorTimer?.invalidate()
            playbackMonitorTimer = nil

            audioPlayer = try AVAudioPlayer(data: backgroundMusicAsset.data)
            audioPlayer.numberOfLoops = 0
            audioPlayer.setVolume(volume, fadeDuration: 3)
            audioPlayer.play()
        } catch {
            print("Background music played once couldn't be played, due to: \(error.localizedDescription)")
        }
    }
    
    func playBackgroundMusicSecondLayer(assetName: String, volume: Float = 0.55, startTime: TimeInterval = 0, endTime: TimeInterval = 15.2) {
        
        guard let backgroundMusicAsset = NSDataAsset(name: assetName) else {
            print("Error: A second background music file couldn't be found in Assets, with the name of: \(assetName)")
            return
        }
        
        do {
            secondAudioPlayer = try AVAudioPlayer(data: backgroundMusicAsset.data)
            secondAudioPlayer.numberOfLoops = 0
            secondAudioPlayer.currentTime = startTime
            secondAudioPlayer.setVolume(volume, fadeDuration: 5)
            secondAudioPlayer.play()
            
            startPlaybackMonitorForSecondLayer(startTime: startTime, endTime: endTime)
        } catch {
            print("Second background music couldn't be played, due to: \(error.localizedDescription)")
        }
    }
    
    func playSFX(assetName: String, volume: Float = 0.65) {
        guard isSfxEnabled else { return }
        
        guard let sfxAsset = NSDataAsset(name: assetName) else {
            print("Error: A SFX file couldn't be found in Assets, with the name of: \(assetName)")
            return
        }
        
        do {
            sfxPlayer = try AVAudioPlayer(data: sfxAsset.data)
            sfxPlayer?.numberOfLoops = 0
            sfxPlayer?.setVolume(volume, fadeDuration: 2)
            
            sfxPlayer?.play()
        } catch {
            print("Sound effect couldn't be played, due to: \(error.localizedDescription)")
        }
    }
    
    private func startPlaybackMonitor(loopStartTime: TimeInterval, loopEndTime: TimeInterval) {
        playbackMonitorTimer?.invalidate()
        
        playbackMonitorTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self, let player = self.audioPlayer else { return }
            if player.currentTime >= loopEndTime {
                player.currentTime = loopStartTime
                player.play()
            }
        }
    }
    
    private func startPlaybackMonitorForSecondLayer(startTime: TimeInterval, endTime: TimeInterval) {
        playbackMonitorSecondLayerTimer?.invalidate()
        
        playbackMonitorSecondLayerTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { [weak self] _ in
            guard let self = self, let player = self.secondAudioPlayer else { return }
            if player.currentTime >= endTime {
                player.currentTime = startTime
            }
        }
    }
    
    func stopBackgroundMusic() {
        playbackMonitorTimer?.invalidate()
        playbackMonitorTimer = nil
        if audioPlayer?.isPlaying == true {
            audioPlayer?.stop()
            audioPlayer?.currentTime = 0
        }
    }
    
    func stopSFX() {
        if sfxPlayer?.isPlaying == true {
            sfxPlayer?.stop()
            sfxPlayer?.currentTime = 0
        }
    }
    
    func configureAudioMix() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio shared mix, due to: \(error.localizedDescription)")
        }
    }
    
    @objc private func stopAudioWhenInBackground() {
        stopBackgroundMusic()
        stopSFX()
    }
}

