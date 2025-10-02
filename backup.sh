#!/bin/bash

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Create backup directory with timestamp
BACKUP_DIR=~/dotfiles_backup_$(date +%Y%m%d_%H%M%S)

echo "📦 Creating backup..."
echo -e "${YELLOW}Backup directory: $BACKUP_DIR${NC}"
echo ""

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Copy dotfiles
echo "Copying dotfiles..."
cp -r ~/dotfiles "$BACKUP_DIR/"

echo ""
echo -e "${GREEN}✅ Backup completed!${NC}"
echo -e "${GREEN}Location: $BACKUP_DIR${NC}"
echo ""
echo "To restore:"
echo "  cp -r $BACKUP_DIR/dotfiles ~/"
