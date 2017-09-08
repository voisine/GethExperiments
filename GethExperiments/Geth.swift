//
//  Geth.swift
//  breadwallet
//
//  Created by Aaron Voisine on 9/7/17.
//  Copyright © 2017 breadwallet LLC. All rights reserved.
//

import Foundation
import Geth

class HeaderHandler: NSObject, GethNewHeadHandlerProtocol {
    public func onError(_ failure: String!) {
    }
    
    public func onNewHead(_ header: GethHeader!) {
        print("#\(header.getNumber): \(header.getHash().getHex())")
    }
}

func ethFoo() throws {
    let ctx = GethContext()
    let docDir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let node = GethNode(docDir.path, config: GethNodeConfig())
    
    try node?.start()

    let info = node?.getInfo()

    print("name: \(info!.getName())")
    print("address: \(info!.getListenerAddress())")
    print("protocols: \(info!.getProtocols())")
    
    let ec = try node?.getEthereumClient()
    
    print("latest block:\(try ec!.getBlockByNumber(ctx, number: -1).getNumber), syncing...")
    
    try ec?.subscribeNewHead(ctx, handler: HeaderHandler(), buffer: 16)
}
