//
//  ExampleViewController.swift
//  SpeechExample
//
//  Created by ablett on 2019/7/11.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//

import UIKit
import SnapKit

class ExampleViewController: TableViewController {

    override func prepare() {
        super.prepare()
        prepareDataSource()
        self.navigationItem.title = "Speech Example"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func prepareDataSource() -> Void {
        let datas: [String] = ["语音合成",
                               "语音识别-音频文件转文字",
                               "语音识别-实时语音转文字"];
        for obj in datas {
            dataSourceItems.append(DataSourceItem.init(data: obj, width: Screen.width, height: 60))
        }
    }
}

extension ExampleViewController {
    @objc
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewCell.init(style: .default, reuseIdentifier: NSStringFromClass(TableViewCell.self))
        cell.backgroundColor = ((indexPath.row % 2) == 0) ? .white: UIColor.init(argb: 0x0D000000);
        let text: String = dataSourceItems[indexPath.row].data as! String
        cell.textLabel?.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = dataSourceItems[indexPath.row].height
        return height!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text: String = dataSourceItems[indexPath.row].data as! String
        var controller: ViewController?
        switch text {
        case "语音合成":
            controller = SynthesizerController()
            break
        case "语音识别-音频文件转文字":
            controller = RecognizerFileController()
            break
        case "语音识别-实时语音转文字":
            controller = RecognizerSpeechController()
        default: break
        }
        controller!.navigationItem.title = text
        navigationController?.pushViewController(controller!, animated: true)
    }
}




