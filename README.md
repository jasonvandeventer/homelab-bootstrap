# 🏠 Homelab Bootstrap – Phase 1

> **Automated media stack deployment on Proxmox with persistent volumes and GPU acceleration**

This repository provides simple scripts to **deploy, manage, and reset** a containerized media stack on Proxmox or any Linux host.  

✅ **Single-command deployment**  
✅ **GPU-accelerated Plex streaming**  
✅ **Persistent storage on mounted drives**  
✅ **Easy teardown and rebuild**  

---

## 📂 Repo Structure

```
homelab-bootstrap/
├── README.md                # The documentation we just generated
├── bootstrap.sh             # Installs Docker + runs media stack
├── teardown.sh              # Nukes all containers/volumes/networks
├── docker-compose/
│   └── media-stack.yml      # Plex, SABnzbd, Sonarr, Radarr, Portainer, NPM
├── scripts/                 
│   ├── 01-system-update.sh
│   ├── 02-docker-install.sh
│   └── 03-storage-setup.sh  # Optional, mounts drives
└── docs/
    └── test-log.md          # Future test notes/logs
```

---

## 🖥️ Current Services (Phase 1)

| Service        | Purpose                 | Default Port |
|----------------|-------------------------|--------------|
| **Plex**       | GPU-accelerated media server | `32400` |
| **Portainer**  | Container management UI | `9000` |
| **Nginx Proxy Manager** | Reverse proxy & SSL | `81` (UI), `80/443` |
| **Radarr**     | Movie management        | `7878` |
| **Sonarr**     | TV show management      | `8989` |
| **Bazarr**     | Subtitle management     | `6767` |
| **SABnzbd**    | Usenet downloader       | `8080` |

All persistent data is stored on **mounted drives**:
- `/mnt/media_library` → Plex media
- `/mnt/downloads` → Downloads
- `/mnt/ssd_cache` → App configs

---

## 🚀 Quick Start

1️⃣ **Clone this repo to your Proxmox host**
```bash
git clone https://github.com/<your-username>/homelab-bootstrap.git
cd homelab-bootstrap
```

2️⃣ **Ensure your storage is mounted**
```bash
df -h | grep mnt
# should show media_library, downloads, and ssd_cache mounted
```

3️⃣ **Deploy the media stack**
```bash
docker compose -f /srv/homelab/media/docker-compose.yml up -d
```

4️⃣ **Check container status**
```bash
./scripts/status-check.sh
```

---

## ♻️ Management Commands

✅ **Check container health**
```bash
./scripts/status-check.sh
```

✅ **Teardown everything (containers, volumes, networks)**
```bash
./scripts/teardown.sh
```

✅ **Reset stack (teardown + rebuild)**
```bash
./scripts/reset.sh
```

---

## 🔧 Troubleshooting

- **Missing mount points?**
  ```bash
  sudo mkdir -p /mnt/{media_library,downloads,ssd_cache}
  sudo mount -a
  df -h | grep mnt
  ```

- **GPU not detected in Plex?**
  ```bash
  ls -la /dev/dri
  docker exec plex ls -la /dev/dri
  ```

- **Force rebuild of all containers**
  ```bash
  ./scripts/reset.sh
  ```

---

## 🛠️ Next Steps

This repo is **Phase 1 only** – a basic Docker + media stack deployment.  
Upcoming phases will add:

- **LibreChat AI stack** (Phase 1.5)
- **Monitoring + Grafana + SSO** (Phase 2)
- **Home Assistant + IoT integration** (Phase 3)
- **K3s + GitOps migration** (Phase 4)

---

## 📈 Portfolio Value

This demonstrates:
- **Infrastructure as Code** principles
- **Persistent volume management**
- **GPU passthrough for containers**
- **Repeatable teardown & rebuild workflow**

---

## 📝 Credits

Built as part of a **weekend-friendly homelab plan** for learning **DevOps + automation** skills while producing portfolio-ready projects.

---

**Quick Commands Recap:**
```bash
# Check containers
./scripts/status-check.sh

# Nuke everything
./scripts/teardown.sh

# Nuke & rebuild in one go
./scripts/reset.sh
```
