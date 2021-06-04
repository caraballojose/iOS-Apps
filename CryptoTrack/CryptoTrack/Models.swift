//
//  Models.swift
//  CryptoTrack
//
//  Created by Jose Caraballo on 10/5/21.
//

import Foundation

struct Crypto: Codable {
    let asset_id: String
    let name: String?
    let price_usd: Float?
    let id_icon: String?
    
}

struct Icon: Codable {
    let asset_id: String
    let url: String
}

//"asset_id": "USD",
//  "name": "US Dollar",
//  "type_is_crypto": 0,
//  "data_start": "2010-07-17",
//  "data_end": "2021-05-10",
//  "data_quote_start": "2014-02-24T17:43:05.0000000Z",
//  "data_quote_end": "2021-05-10T20:30:01.0633333Z",
//  "data_orderbook_start": "2014-02-24T17:43:05.0000000Z",
//  "data_orderbook_end": "2020-08-05T14:38:00.7082850Z",
//  "data_trade_start": "2010-07-17T23:09:17.0000000Z",
//  "data_trade_end": "2021-05-10T20:30:03.6866667Z",
//  "data_symbols_count": 56024,
//  "volume_1hrs_usd": 10732452018.36,
//  "volume_1day_usd": 53055153806.38,
//  "volume_1mth_usd": 1237098910613.25,
//  "id_icon": "0a4185f2-1a03-4a7c-b866-ba7076d8c73b"
