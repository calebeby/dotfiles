#!/usr/bin/env bash

restic -r /srv/backups --password-file ~/dotfiles/backup-config/home-backup-password backup /home/caleb --exclude-file ~/dotfiles/backup-config/home-backup-ignore --exclude-caches
