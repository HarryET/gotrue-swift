public struct User {
    public var id: String
    public var aud: String
    public var role: String
    public var email: String
    public var confirmedAt: String?
    public var lastSignInAt: String?
    public var appMetadata: [String: Any]?
    public var userMetadata: [String: Any]?
    public var createdAt: String
    public var updatedAt: String

    init?(from dictionary: [String: Any]) {
        guard let id: String = dictionary["id"] as? String,
              let aud: String = dictionary["aud"] as? String,
              let email: String = dictionary["email"] as? String,
              let createdAt: String = dictionary["created_at"] as? String,
              let updatedAt: String = dictionary["updated_at"] as? String,
              let role: String = dictionary["role"] as? String
        else {
            return nil
        }

        self.id = id
        self.aud = aud
        self.email = email
        self.role = role
        self.createdAt = createdAt
        self.updatedAt = updatedAt

        if let confirmedAt: String = dictionary["confirmed_at"] as? String {
            self.confirmedAt = confirmedAt
        }

        if let lastSignInAt: String = dictionary["last_sign_in_at"] as? String {
            self.lastSignInAt = lastSignInAt
        }

        if let appMetadata: [String: Any] = dictionary["app_metadata"] as? [String: Any] {
            self.appMetadata = appMetadata
        }

        if let userMetadata: [String: Any] = dictionary["user_metadata"] as? [String: Any] {
            self.userMetadata = userMetadata
        }
    }
}

extension User: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case aud
        case role
        case email
        case confirmedAt = "confirmed_at"
        case lastSignInAt = "last_sign_in_at"
        case appMetadata = "app_metadata"
        case userMetadata = "user_metadata"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        aud = try container.decode(String.self, forKey: .aud)
        role = try container.decode(String.self, forKey: .role)
        email = try container.decode(String.self, forKey: .email)
        confirmedAt = try container.decode(String.self, forKey: .confirmedAt)
        lastSignInAt = try container.decode(String.self, forKey: .lastSignInAt)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)

        appMetadata = try? container.decode([String: Any].self, forKey: .appMetadata)
        userMetadata = try? container.decode([String: Any].self, forKey: .userMetadata)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(aud, forKey: .aud)
        try container.encode(role, forKey: .role)
        try container.encode(email, forKey: .email)
        try container.encode(confirmedAt, forKey: .confirmedAt)
        try container.encode(lastSignInAt, forKey: .lastSignInAt)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)

        try? container.encode(appMetadata, forKey: .appMetadata)
        try? container.encode(userMetadata, forKey: .userMetadata)
    }
}
