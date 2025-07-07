# vpn-pritunl Helm Chart

Helm chart for deploying [Pritunl Zero](https://github.com/pritunl/pritunl-zero) with optional MongoDB and OIDC authentication. Designed for secure, scalable VPN infrastructure with TLS, ingress, and GitHub Actions CI compatibility.

---

## 🚀 Features

- **Pritunl VPN** deployed to Kubernetes via Helm
- **MongoDB** support (Bitnami chart compatible)
- **OIDC authentication** integration (e.g., Keycloak, Auth0)
- **NGINX ingress** with optional TLS (cert-manager support)
- **Custom health probes** via ConfigMap override
- **Dry-run and CI testing** with `dev-values.yaml`
- Follows [Helm best practices](https://helm.sh/docs/chart_best_practices/)

---

## 📦 Chart Structure

```
vpn-pritunl-helm-chart/
├── charts/                  # Helm dependencies (e.g. MongoDB tgz)
├── templates/               # Kubernetes manifests
│   ├── _helpers.tpl         # Label helpers
│   ├── deployment.yaml      # Pritunl deployment
│   ├── service.yaml         # Kubernetes Service
│   ├── ingress.yaml         # NGINX ingress
│   ├── certificate.yaml     # TLS via cert-manager
│   └── override-mongo-probes.yaml # ConfigMap for MongoDB probe override
├── dev-values.yaml          # Development override values
├── values.yaml              # Default production-safe values
├── Chart.yaml               # Chart metadata
└── README.md                # Documentation (you are here)
```

---

## 🔧 Installation

### Prerequisites

- Kubernetes cluster (Kind, Minikube, EKS, etc.)
- Helm 3.x
- cert-manager (for TLS)
- NGINX Ingress Controller

### Install the Chart

```bash
helm upgrade --install vpn-pritunl ./ \
  -f dev-values.yaml \
  --namespace vpn --create-namespace
```

---

## ⚙️ Configuration

### MongoDB (default enabled)

```yaml
mongodb:
  enabled: true
  auth:
    rootPassword: pritunlroot
    username: pritunluser
    password: UserPass123
    database: pritunldb
```

---

### OIDC Authentication

```yaml
pritunl:
  oidc:
    enabled: true
    client_id: your-client-id
    client_secret: your-client-secret
    issuer_url: https://auth.example.com
    redirect_uri: https://vpn.example.com/auth/callback
```

Create the required secret:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: pritunl-secret
type: Opaque
stringData:
  oidc-client-id: your-client-id
  oidc-client-secret: your-client-secret
```

---

## 🌐 Ingress & TLS

```yaml
ingress:
  enabled: true
  className: nginx
  clusterIssuer: letsencrypt-staging
  host: vpn.example.com
  tlsSecret: pritunl-tls
```

---

## 🧪 Health Check Override (MongoDB)

Customize MongoDB readiness/liveness probes:

```yaml
mongodb:
  extraVolumes:
    - name: custom-mongo-probes
      configMap:
        name: override-mongo-probes
        defaultMode: 0555
  extraVolumeMounts:
    - name: custom-mongo-probes
      mountPath: /bitnami/scripts/readiness-probe.sh
      subPath: readiness-probe.sh
    - name: custom-mongo-probes
      mountPath: /bitnami/scripts/liveness-probe.sh
      subPath: liveness-probe.sh
```

---

## 🧪 Dry-Run Test (CI or local)

```bash
helm template vpn-pritunl . -f dev-values.yaml
```

Or lint it:

```bash
helm lint .
```

---

## 🧪 CI Compatibility

- `dev-values.yaml` supports dry-run pipeline testing
- GitHub Actions sample included (`.github/workflows/helm-ci.yml`)
- Lint + template rendering check with Helm 3.x

---

## 🧠 Author

**Temitayo Charles Akinniranye**  
DevOps Engineer | Kubernetes | Terraform | CI/CD  
[GitHub @temitayocharles](https://github.com/temitayocharles)  
[meetcharlie.live](https://www.meetcharlie.live)

---

## 📄 License

MIT
