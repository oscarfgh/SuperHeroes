//
//  AlertViews.swift
//  Superheroes
//
//  Created by Oscar on 17/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import Foundation
import SwiftMessages

class AlertView: MessageView {

    func showErrorView(retryAction: @escaping ((_ button: UIButton) -> Void)) {
        let view = MessageView.viewFromNib(layout: .tabView)
        view.configureTheme(.error)
        view.configureContent(title: NSLocalizedString("title_error_view", comment: ""),
                               body: NSLocalizedString("subtitle_error_view", comment: ""))
        view.button?.setTitle(NSLocalizedString("title_button_error_view", comment: ""), for: .normal)
        view.buttonTapHandler = retryAction

        var config = SwiftMessages.defaultConfig
        config.presentationContext = .automatic
        config.duration = .forever
        config.presentationStyle = .center
        config.dimMode = .color(color: .clear, interactive: true)

        SwiftMessages.show(config: config, view: view)
    }
    
    func showLoadingView() {
        guard let view = try? SwiftMessages.viewFromNib() as LoadingView else {
            fatalError("SwiftMessages not found")
        }
        view.configureTheme(.error)
        view.configureContent(title: NSLocalizedString("title_error_view", comment: ""),
                              body: NSLocalizedString("subtitle_error_view", comment: ""))
        
        var config = SwiftMessages.defaultConfig
        config.presentationContext = .automatic
        config.duration = .forever
        config.presentationStyle = .center
        config.dimMode = .color(color: .clear, interactive: true)
        
        SwiftMessages.show(config: config, view: view)
    }
    
    func hide() {
        SwiftMessages.hide()
    }
}

class LoadingView: MessageView  {
    
}
