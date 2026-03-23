-- Add support for fine grained permissions on API Keys

CREATE TABLE api_keys_x_permissions (
	id INT UNSIGNED AUTO_INCREMENT NOT NULL,
	api_key_id INT UNSIGNED NOT NULL,
	permission_id INT UNSIGNED NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY api_keys_x_permissions_api_key_id (api_key_id) REFERENCES api_keys (id) ON DELETE CASCADE,
	FOREIGN KEY api_keys_x_permissions_permission_id (permission_id) REFERENCES permissions (id) ON DELETE CASCADE
);

-- Grant all permissions to every API key to maintain legacy behavior
INSERT INTO api_keys_x_permissions (api_key_id, permission_id)
	SELECT api_keys.id, permissions.id
	FROM api_keys
	CROSS JOIN permissions;

INSERT INTO schema_versioning(version, comment) VALUES ("2.12.0", "Migration Complete");
