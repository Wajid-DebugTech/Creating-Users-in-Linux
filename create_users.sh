#!/usr/bin/env bash
# create_users.sh - Fixed and safe version

set -euo pipefail

CSV_FILE="users.csv"

# Ensure CSV exists
if [ ! -f "$CSV_FILE" ]; then
    echo "ERROR: CSV file '$CSV_FILE' not found."
    exit 1
fi

# Process CSV safely
while IFS=',' read -r username fullname group homedir shell dir; do

    # Remove carriage returns and trim spaces
    username=$(echo "$username" | tr -d '\r' | xargs)
    fullname=$(echo "$fullname" | tr -d '\r' | xargs)
    group=$(echo "$group" | tr -d '\r' | xargs)
    homedir=$(echo "$homedir" | tr -d '\r' | xargs)
    shell=$(echo "$shell" | tr -d '\r' | xargs)
    dir=$(echo "$dir" | tr -d '\r' | xargs)

    # Skip empty username lines
    if [ -z "$username" ]; then
        continue
    fi

    echo ">> Processing user: $username"

    # 1) Create group if missing
    if ! getent group "$group" > /dev/null; then
        echo "   Creating group: $group"
        sudo groupadd "$group"
    else
        echo "   Group '$group' already exists"
    fi

    # 2) Create user if missing
    if ! id -u "$username" &>/dev/null; then
        echo "   Creating user: $username"
        sudo useradd -c "$fullname" -d "$homedir" -s "$shell" -m -g "$group" "$username"

        # Set temporary password and force password reset
        echo "$username:Password123!" | sudo chpasswd
        sudo chage -d 0 "$username"
    else
        echo "   User '$username' already exists, skipping."
    fi

    # 3) Ensure directory exists and set permissions
    if [ -n "$dir" ]; then
        echo "   Setting up directory: $dir"
        sudo mkdir -p "$dir"
        sudo chown "$username:$group" "$dir"
        sudo chmod 2775 "$dir"
    fi

done < <(tail -n +2 "$CSV_FILE" | grep -v '^[[:space:]]*$')

