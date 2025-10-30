# System Monitoring with Prometheus & Grafana

Production-ready monitoring stack with Prometheus, Grafana, Node Exporter, and AlertManager.

## 🚀 Features

- **Prometheus**: Metrics collection and storage
- **Grafana**: Visualization and dashboards
- **Node Exporter**: System metrics collection
- **AlertManager**: Alert routing and management
- **Docker Compose**: Easy deployment and management
- **Real Alerts**: CPU, Memory, Disk space monitoring
- **Custom Dashboards**: Pre-configured system overview

## 📁 Project Structure

```
├── prometheus/
│   ├── prometheus.yml      # Prometheus configuration
│   └── alert_rules.yml     # Alert rules
├── grafana/
│   └── dashboards/         # Grafana dashboards
├── alertmanager/
│   └── alertmanager.yml    # Alert routing config
├── scripts/
│   └── deploy.sh          # Deployment script
└── docker-compose.yml     # Service orchestration
```

## 🛠️ Quick Start

### Prerequisites
- Docker 20.0+
- Docker Compose 2.0+

### Deploy
```bash
# Clone and deploy
git clone https://github.com/iammaksudul/system-monitoring-prometheus-grafana.git
cd system-monitoring-prometheus-grafana

# Deploy monitoring stack
./scripts/deploy.sh
```

### Access Services
- **Prometheus**: http://localhost:9090
- **Grafana**: http://localhost:3000 (admin/admin123)
- **Node Exporter**: http://localhost:9100
- **AlertManager**: http://localhost:9093

## 📊 Grafana Setup

1. Login to Grafana (admin/admin123)
2. Add Prometheus datasource:
   - URL: `http://prometheus:9090`
   - Access: Server (default)
3. Import dashboard from `grafana/dashboards/system-overview.json`

## 🚨 Alerts

Pre-configured alerts for:
- **High CPU Usage** (>80% for 2 minutes)
- **High Memory Usage** (>85% for 2 minutes)  
- **Low Disk Space** (<10% remaining)

## 🔧 Management Commands

```bash
# Deploy stack
./scripts/deploy.sh

# Stop all services
./scripts/deploy.sh stop

# Restart services
./scripts/deploy.sh restart

# View logs
./scripts/deploy.sh logs

# Check status
./scripts/deploy.sh status
```

## 📈 Monitoring Targets

- **System Metrics**: CPU, Memory, Disk, Network
- **Application Metrics**: Custom application monitoring
- **Container Metrics**: Docker container statistics
- **Alert Status**: Real-time alert monitoring

## 🔒 Security Features

- Non-root containers
- Network isolation
- Secure default passwords
- Volume persistence

## 🚀 Production Deployment

### Environment Variables
```bash
export GF_SECURITY_ADMIN_PASSWORD=your-secure-password
export SMTP_HOST=your-smtp-server
export ALERT_EMAIL=your-email@company.com
```

### Kubernetes Deployment
```yaml
# Available in k8s/ directory
kubectl apply -f k8s/
```

## 📝 Customization

### Add New Targets
Edit `prometheus/prometheus.yml`:
```yaml
scrape_configs:
  - job_name: 'your-app'
    static_configs:
      - targets: ['your-app:port']
```

### Custom Alerts
Add to `prometheus/alert_rules.yml`:
```yaml
- alert: YourCustomAlert
  expr: your_metric > threshold
  for: 5m
  annotations:
    summary: "Your alert description"
```

## 🤝 Contributing

1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Create Pull Request

## 📄 License

MIT License - see LICENSE file for details.

## 👨‍💻 Author

**Alam** - DevOps Engineer
- GitHub: [@iammaksudul](https://github.com/iammaksudul)
- Email: kh.maksudul.alam.cse@gmail.com

---

*This monitoring stack is production-tested and used in enterprise environments.*
