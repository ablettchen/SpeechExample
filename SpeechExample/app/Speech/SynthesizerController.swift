//
//  SynthesizerController.swift
//  SpeechExample
//
//  Created by ablett on 2019/7/11.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//

import UIKit
import AVFoundation

class SynthesizerController: ViewController {
    
    // 提示
    fileprivate lazy var promptLabel: UILabel = {
        let label = UILabel()
        label.text = speech_prompt_text
        label.fontSize = 14
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.blue.withAlphaComponent(0.6)
        return label
    }()
    
    // 输入框
    fileprivate lazy var textView: UITextView = {
        let view = UITextView()
        view.text = speech_text
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = UIColor.darkGray
        view.backgroundColor = UIColor.cyan.withAlphaComponent(0.2);
        return view
    }()
    
    // 合成按钮
    fileprivate lazy var synthesizerButton: UIButton = {
        let darkColor = UIColor.init(argb: 0xffff3333)
        let lightColor = UIColor.init(argb: 0xff009933)
        let button = UIButton.init(type: .custom)
        button.setTitle("开始播放", for: .normal)
        button.setTitle("取消播放", for: .selected)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.setBackgroundImage(UIImage.image(with: lightColor, size: CGSize.init(width: 100.0, height: 50)), for: .normal)
        button.setBackgroundImage(UIImage.image(with: darkColor, size: CGSize.init(width: 100.0, height: 50)), for: .selected)
        button.fontSize = 16
        button.addTarget(self, action: #selector(synthesizerAction(_:)), for: .touchUpInside)
        return button
    }()
    
    // 暂停/继续
    fileprivate lazy var pauseButton: UIButton = {
        let darkColor = UIColor.init(argb: 0xff0099cc)
        let lightColor = UIColor.init(argb: 0xffff9900)
        let button = UIButton.init(type: .custom)
        button.setTitle("暂停播放", for: .normal)
        button.setTitle("继续播放", for: .selected)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.setBackgroundImage(UIImage.image(with: lightColor, size: CGSize.init(width: 100.0, height: 50)), for: .normal)
        button.setBackgroundImage(UIImage.image(with: darkColor, size: CGSize.init(width: 100.0, height: 50)), for: .selected)
        button.fontSize = 16
        button.addTarget(self, action: #selector(pauseAction(_:)), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    //将要播放的文字
    fileprivate lazy var willSpeekLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.fontSize = 14
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.blue.withAlphaComponent(0.6)
        return label
    }()
    
    // 合成器
    lazy var synthesizer: AVSpeechSynthesizer = {
        let s = AVSpeechSynthesizer()
        s.delegate = self
        return s
    }()
    
    override public func prepare() {
        super.prepare()
        prepareViews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        synthesizer.stopSpeaking(at: .immediate)
    }
    
    func prepareViews() -> Void {
        
        view.addSubview(promptLabel)
        promptLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview().inset(15)
            make.height.equalTo(30)
        }
        
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(promptLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(100)
        }
        
        view.addSubview(synthesizerButton)
        synthesizerButton.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(20)
            make.left.right.equalTo(textView)
            make.height.equalTo(35)
        }
        
        view.addSubview(pauseButton)
        pauseButton.snp.makeConstraints { (make) in
            make.top.equalTo(synthesizerButton.snp.bottom).offset(20)
            make.left.right.equalTo(textView)
            make.height.equalTo(35)
        }
        
        view.addSubview(willSpeekLabel)
        willSpeekLabel.snp.makeConstraints { (make) in
            make.top.equalTo(pauseButton.snp.bottom).offset(20)
            make.left.right.equalTo(textView)
            make.height.equalTo(30)
        }
    }
    
    func viewReset() -> Void {
        synthesizerButtonReset()
        pauseButtonReset()
        willSpeekLabel.text = "-"
    }
    
    func synthesizerButtonReset() -> Void {
        synthesizerButton.isSelected = false
    }
    
    func pauseButtonReset() -> Void {
        pauseButton.isEnabled = false
        pauseButton.isSelected = false
    }
    
    @objc func synthesizerAction(_ sender: UIButton) -> Void {
        if sender.isSelected {
            cancelSynthesize(sender)
        }else {
            startSynthesize(sender)
        }
        sender.isSelected = !sender.isSelected
        pauseButton.isEnabled = sender.isSelected
    }
    
    @objc func pauseAction(_ sender: UIButton) -> Void {
        if sender.isSelected {
            continueSynthesize(sender)
        }else {
            pauseSynthesize(sender)
        }
        sender.isSelected = !sender.isSelected
    }
    
}

extension SynthesizerController {
    
    // 开始播放
    @objc fileprivate func startSynthesize(_ sender: UIButton) -> Void {
        
        // 合成语言类型
        let voice = AVSpeechSynthesisVoice(language: "zh-CN")
        
        // 语音表达设置
        let utterance = AVSpeechUtterance(string: textView.text)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance.voice = voice
        utterance.volume = 1
        utterance.postUtteranceDelay = 0.1
        utterance.pitchMultiplier = 1
        
        // 播放
        synthesizer.speak(utterance)
    }
    
    // 取消播放
    @objc fileprivate func cancelSynthesize(_ sender: UIButton) -> Void {
        synthesizer.stopSpeaking(at: .immediate)
    }
    
    // 暂停播放
    @objc fileprivate func pauseSynthesize(_ sender: UIButton) -> Void {
        synthesizer.pauseSpeaking(at: .immediate)
    }
    
    // 继续播放
    @objc fileprivate func continueSynthesize(_ sender: UIButton) -> Void {
        synthesizer.continueSpeaking()
    }
}

extension SynthesizerController: AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("开始播放")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        viewReset()
        print("播放结束")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        print("暂停播放")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        print("继续播放")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        viewReset()
        print("取消播放")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        let subStr = utterance.speechString.dropFirst(characterRange.location).description
        let rangeStr = subStr.dropLast(subStr.count - characterRange.length).description
        willSpeekLabel.text = rangeStr
    }
}
