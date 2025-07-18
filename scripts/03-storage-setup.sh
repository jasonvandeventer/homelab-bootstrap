#!/bin/bash
set -e

echo "🗂️ Setting up storage mounts..."

# Define expected labels and mount points
declare -A DRIVES=(
  ["homelab-cache"]="/mnt/ssd-cache"
  ["homelab-downloads"]="/mnt/downloads"
  ["data"]="/mnt/media"
)

for LABEL in "${!DRIVES[@]}"; do
  MOUNTPOINT="${DRIVES[$LABEL]}"
  
  # Find the device by label
  DEVICE=$(blkid -L "$LABEL" || true)
  
  if [ -z "$DEVICE" ]; then
    echo "⚠️  WARNING: Drive with label '$LABEL' not found! Skipping..."
    continue
  fi
  
  echo "✅ Found $LABEL at $DEVICE"
  
  # Create mount point if missing
  mkdir -p "$MOUNTPOINT"
  
  # Get UUID for fstab
  UUID=$(blkid -s UUID -o value "$DEVICE")
  
  # Add to /etc/fstab if not already there
  if ! grep -q "$UUID" /etc/fstab; then
    echo "UUID=$UUID $MOUNTPOINT ext4 defaults 0 2" >> /etc/fstab
    echo "📝 Added $LABEL to /etc/fstab"
  else
    echo "ℹ️  $LABEL already present in /etc/fstab"
  fi
done

# Mount all drives
mount -a

echo "✅ Storage setup complete!"
df -h | grep "/mnt/"
