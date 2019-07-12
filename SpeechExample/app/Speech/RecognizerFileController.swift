//
//  RecognizerFileController.swift
//  SpeechExample
//
//  Created by ablett on 2019/7/11.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//

import UIKit
import Foundation
import Speech

class RecognizerFileController: ViewController {

    // 提示
    fileprivate lazy var promptLabel: UILabel = {
        let label = UILabel()
        label.text = recognizer_prompt_text
        label.fontSize = 14
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.blue.withAlphaComponent(0.6)
        return label
    }()
    
    // 输入框
    fileprivate lazy var textView: UITextView = {
        let view = UITextView()
        view.text = ""
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = UIColor.darkGray
        view.backgroundColor = UIColor.cyan.withAlphaComponent(0.2);
        view.isEditable = false
        return view
    }()
    
    // 合成按钮
    fileprivate lazy var recognizerButton: UIButton = {
        let darkColor = UIColor.init(argb: 0xffff3333)
        let lightColor = UIColor.init(argb: 0xff009933)
        let button = UIButton.init(type: .custom)
        button.setTitle("开始识别", for: .normal)
        button.setTitle("取消识别", for: .selected)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.setBackgroundImage(UIImage.image(with: lightColor, size: CGSize.init(width: 100.0, height: 50)), for: .normal)
        button.setBackgroundImage(UIImage.image(with: darkColor, size: CGSize.init(width: 100.0, height: 50)), for: .selected)
        button.fontSize = 16
        button.addTarget(self, action: #selector(recognizerAction(_:)), for: .touchUpInside)
        return button
    }()
    
    // 播放/停止
    fileprivate lazy var playButton: UIButton = {
        let darkColor = UIColor.init(argb: 0xff0099cc)
        let lightColor = UIColor.blue.withAlphaComponent(0.6)
        let button = UIButton.init(type: .custom)
        button.setTitle("音频文件播放", for: .normal)
        button.setTitle("停止播放", for: .selected)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.setBackgroundImage(UIImage.image(with: lightColor, size: CGSize.init(width: 100.0, height: 50)), for: .normal)
        button.setBackgroundImage(UIImage.image(with: darkColor, size: CGSize.init(width: 100.0, height: 50)), for: .selected)
        button.fontSize = 16
        button.addTarget(self, action: #selector(playAction(_:)), for: .touchUpInside)
        return button
    }()
    
    override public func prepare() {
        super.prepare()
        prepareViews()
        
        // 权限检测
        permissionDetection()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        cancelRecognizer(recognizerButton)
        player.stop()
    }
    
    // UI
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
            make.height.equalTo(200)
        }
        
        view.addSubview(recognizerButton)
        recognizerButton.snp.makeConstraints { (make) in
            make.top.equalTo(textView.snp.bottom).offset(20)
            make.left.right.equalTo(textView)
            make.height.equalTo(35)
        }
        
        view.addSubview(playButton)
        playButton.snp.makeConstraints { (make) in
            make.top.equalTo(recognizerButton.snp.bottom).offset(20)
            make.left.right.equalTo(recognizerButton)
            make.height.equalTo(35)
        }
    }
    
    // 识别按钮点击事件
    @objc func recognizerAction(_ sender: UIButton) -> Void {
        if sender.isSelected {
            cancelRecognizer(sender)
        }else {
            startRecognizer(sender)
        }
        sender.isSelected = !sender.isSelected
    }
    
    // 播放按钮点击事件
    @objc func playAction(_ sender: UIButton) -> Void {
        if sender.isSelected {
            stopAudio(sender)
        }else {
            playAudio(sender)
        }
        sender.isSelected = !sender.isSelected
    }

    // 权限检测
    func permissionDetection() -> Void {
        let p = SpeechPermission()
        if p.isDenied {
            let alert = UIAlertController.init(title: "权限被拒", message: "请到设置里面打开语音识别权限", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (action) in
                self.navigationController?.popViewController(animated: true)
            }))
            alert.addAction(UIAlertAction.init(title: "去设置", style: .default, handler: { (action) in
                UIApplication.shared.open(
                    URL.init(string: UIApplication.openSettingsURLString)!
                )
            }))
            self.present(alert, animated: true) {}
        }
        
        if p.isDenied == false {
            p.request {
                self.permissionDetection()
            }
        }
    }
    
    // 识别相关
    
    fileprivate var recognitionTask: SFSpeechRecognitionTask?
    
    fileprivate lazy var recognitionRequest: SFSpeechURLRecognitionRequest = {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "cross-talk1", ofType: "mp3") ?? "")
        let r = SFSpeechURLRecognitionRequest(url: url)
        r.shouldReportPartialResults = true
        return r
    }()
    
    fileprivate lazy var recognizer: SFSpeechRecognizer = {
        let r = SFSpeechRecognizer(locale: Locale(identifier: "zh-CN"))
        r?.delegate = self
        return r!
    }()
    
    // 播放器
    fileprivate lazy var player: AudioPlayer = {
        let p = AudioPlayer()
        return p
    }()
    
    fileprivate var isPlaying = false
}

extension RecognizerFileController {
    
    // 开始识别
    @objc fileprivate func startRecognizer(_ sender: UIButton) -> Void {
        cancelRecognizer(sender)
        textView.text = ""
        recognitionTask = recognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            if result == nil { return }
            var text = ""
            for obj in result!.transcriptions{
                text += obj.formattedString
            }
            self.textView.text = text
            self.textView.scrollRangeToVisible(NSMakeRange(self.textView.text.count, 1))
            
            if result!.isFinal{
                self.recognizerButton.isSelected = false
                self.recognitionTask = nil
            }
        })
    }

    // 取消识别
    @objc fileprivate func cancelRecognizer(_ sender: UIButton) -> Void {
        if recognitionTask != nil{
            recognitionTask?.cancel()
            recognitionTask = nil
        }
    }
    
    fileprivate func playAudio(_ sender: UIButton) -> Void {
        player.play(fileName: "cross-talk1.mp3") {
            self.playButton.isSelected = false
        }
    }
    
    fileprivate func stopAudio(_ sender: UIButton) -> Void {
        player.stop()
    }
}

extension RecognizerFileController: SFSpeechRecognizerDelegate {
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        recognizerButton.isEnabled = available
    }
}

