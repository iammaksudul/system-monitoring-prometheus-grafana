#!/bin/bash

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log() { echo -e "${GREEN}[INFO] $1${NC}"; }
warn() { echo -e "${YELLOW}[WARN] $1${NC}"; }
error() { echo -e "${RED}[ERROR] $1${NC}"; exit 1; }

check_docker() {
    if ! command -v docker &> /dev/null; then
        error "Docker not found. Please install Docker."
    fi
    
    if ! command -v docker-compose &> /dev/null; then
        error "Docker Compose not found. Please install Docker Compose."
    fi
    
    log "Docker and Docker Compose are available"
}

deploy_stack() {
    log "Deploying monitoring stack..."
    
    # Stop existing containers
    docker-compose down 2>/dev/null || true
    
    # Start services
    docker-compose up -d
    
    log "Waiting for services to start..."
    sleep 30
    
    # Check service health
    check_services
}

check_services() {
    log "Checking service health..."
    
    services=("prometheus:9090" "grafana:3000" "node-exporter:9100" "alertmanager:9093")
    
    for service in "${services[@]}"; do
        IFS=':' read -r name port <<< "$service"
        if curl -s "http://localhost:$port" > /dev/null; then
            log "✅ $name is healthy"
        else
            warn "⚠️  $name may not be ready yet"
        fi
    done
}

show_info() {
    echo ""
    log "=== Monitoring Stack Deployed Successfully ==="
    echo ""
    log "Access URLs:"
    log "📊 Prometheus: http://localhost:9090"
    log "📈 Grafana: http://localhost:3000 (admin/admin123)"
    log "🖥️  Node Exporter: http://localhost:9100"
    log "🚨 AlertManager: http://localhost:9093"
    log "🌐 Sample App: http://localhost:8080"
    echo ""
    log "Grafana Setup:"
    log "1. Login with admin/admin123"
    log "2. Add Prometheus datasource: http://prometheus:9090"
    log "3. Import dashboards from grafana/dashboards/"
    echo ""
    log "Commands:"
    log "View logs: docker-compose logs -f"
    log "Stop stack: docker-compose down"
    log "Restart: docker-compose restart"
}

main() {
    log "Starting monitoring stack deployment..."
    
    check_docker
    deploy_stack
    show_info
    
    log "Deployment completed successfully!"
}

case "${1:-deploy}" in
    "deploy") main ;;
    "stop") docker-compose down ;;
    "restart") docker-compose restart ;;
    "logs") docker-compose logs -f ;;
    "status") docker-compose ps ;;
    *) echo "Usage: $0 {deploy|stop|restart|logs|status}"; exit 1 ;;
esac
