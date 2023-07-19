//
//  CodableConformanceView.swift
//  CupcakeCorner
//
//  Created by Rob Ranf on 7/19/23.
//

import SwiftUI

// It's better to use a class and conform it to Codable is it's much safer than the
// stringly typed API of UserDefaults.

final class User: ObservableObject, Codable {
    @Published var name = "Madison Ranf"
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        // This means "this data should have a container where the keys match whatever cases
        // in the CodingKeys enum." It's a throwing call, it's possible those keys don't exist.
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Read values directly from that container by referencing cases in the enum. This
        // provides really strong safety in two ways: making it clear we expect to read a string
        // and also using a case in the CodingKeys enum rather than a plain string, so
        // no chance of typos.
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

struct CodableConformanceView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CodableConformanceView_Previews: PreviewProvider {
    static var previews: some View {
        CodableConformanceView()
    }
}
