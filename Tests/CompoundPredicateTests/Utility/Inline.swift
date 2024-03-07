////
////  File.swift
////  
////
////  Created by Noah Kamara on 03.03.24.
////
//
//import InlineSnapshotTesting
//import Foundation
//
//extension Snapshotting where Value: EncodableWithConfiguration, Format == String {
//    /// A snapshot strategy for comparing encodable structures based on their JSON representation.
//    ///
//    /// ```swift
//    /// assertSnapshot(of: user, as: .json)
//    /// ```
//    ///
//    /// Records:
//    ///
//    /// ```json
//    /// {
//    ///   "bio" : "Blobbed around the world.",
//    ///   "id" : 1,
//    ///   "name" : "Blobby"
//    /// }
//    /// ```
//    @available(iOS 11.0, macOS 10.13, tvOS 11.0, watchOS 4.0, *)
//    public static func json(with configuration: Value.EncodingConfiguration) -> Snapshotting {
//        let encoder = JSONEncoder()
//        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
//        return .json(encoder, configuration: configuration)
//    }
//
//    /// A snapshot strategy for comparing encodable structures based on their JSON representation.
//    ///
//    /// - Parameter encoder: A JSON encoder.
//    public static func json(_ encoder: JSONEncoder, configuration: Value.EncodingConfiguration) -> Snapshotting {
//        var snapshotting = SimplySnapshotting.lines.pullback { (encodable: Value) in
//            try! String(decoding: encoder.encode(encodable, configuration: configuration), as: UTF8.self)
//        }
//        snapshotting.pathExtension = "json"
//        return snapshotting
//    }
//
//    /// A snapshot strategy for comparing encodable structures based on their property list
//    /// representation.
//    ///
//    /// ```swift
//    /// assertSnapshot(of: user, as: .plist)
//    /// ```
//    ///
//    /// Records:
//    ///
//    /// ```xml
//    /// <?xml version="1.0" encoding="UTF-8"?>
//    /// <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
//    ///  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
//    /// <plist version="1.0">
//    /// <dict>
//    ///   <key>bio</key>
//    ///   <string>Blobbed around the world.</string>
//    ///   <key>id</key>
//    ///   <integer>1</integer>
//    ///   <key>name</key>
//    ///   <string>Blobby</string>
//    /// </dict>
//    /// </plist>
//    /// ```
//    public static func plist(with configuration: Value.EncodingConfiguration) -> Snapshotting {
//        let encoder = Foundation.PropertyListEncoder()
//        encoder.outputFormat = .xml
//        return .plist(encoder, configuration: configuration)
//    }
//
//    /// A snapshot strategy for comparing encodable structures based on their property list
//    /// representation.
//    ///
//    /// - Parameter encoder: A property list encoder.
//    public static func plist(_ encoder: Foundation.PropertyListEncoder, configuration: Value.EncodingConfiguration) -> Snapshotting {
//        var snapshotting = SimplySnapshotting.lines.pullback { (encodable: Value) in
//            try! String(decoding: encoder.encode(encodable, configuration: configuration), as: UTF8.self)
//        }
//        snapshotting.pathExtension = "plist"
//        return snapshotting
//    }
//}
