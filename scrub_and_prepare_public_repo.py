import os
import shutil

# Paths
source_dir = "/Users/charlie/Documents/PERSONAL/vpn-pritunl-helm-chart"
target_dir = "/Users/charlie/Documents/PERSONAL/vpn-pritunl-helm-chart-public"

# Replacements
replacements = {
    "pritunlroot": "your-root-password",
    "pritunluser": "your-db-username",
    "UserPass123": "your-db-password",
    "pritunldb": "your-db-name",
    "auth.edusuc.net": "auth.example.com",
    "vpn.dev.edusuc.net": "vpn.example.com",
    "pritunl-dev-tls": "pritunl-tls",
    "edusuc.net": "example.com",
    "WEBFORX": "example-corp",
    "webforx": "example-corp",
}

sensitive_files = [
    "secrets.sops.yaml",
    "temp-secret.yaml",
    ".sops.yaml",
    ".env",
    "terraform.tfvars"
]

def scrub_repo():
    if os.path.exists(target_dir):
        shutil.rmtree(target_dir)

    shutil.copytree(source_dir, target_dir)

    for root, _, files in os.walk(target_dir):
        for file in files:
            file_path = os.path.join(root, file)
            if file.endswith(('.yaml', '.yml', '.md', '.tpl', '.json', '.conf')):
                with open(file_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                for key, val in replacements.items():
                    content = content.replace(key, val)
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(content)
            if file in sensitive_files:
                os.remove(file_path)
                print(f"Removed sensitive file: {file_path}")

    print(f"Sanitized repo copied to: {target_dir}")

if __name__ == "__main__":
    scrub_repo()

