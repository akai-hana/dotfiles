#!/bin/sh

# --- Config ---
KEY_TYPE="ed25519"
EMAIL="$1"
KEY_PATH="$HOME/.ssh/id_$KEY_TYPE"
# --------------

if [ -z "$EMAIL" ]; then
  echo "❌ Usage: $0 your_email@example.com"
  exit 1
fi

# Check for existing key
if [ -f "$KEY_PATH" ]; then
  echo "✅ SSH key already exists at $KEY_PATH"
else
  echo "🔐 Generating a new SSH key..."
  ssh-keygen -t $KEY_TYPE -C "$EMAIL" -f "$KEY_PATH" -N ""
fi

# Start ssh-agent
echo "🚀 Starting ssh-agent..."
eval "$(ssh-agent -s)"

# Add SSH key
echo "➕ Adding SSH key to agent..."
ssh-add "$KEY_PATH"

# Copy key to clipboard
echo "📋 Copying public key to clipboard..."
if command -v xclip &>/dev/null; then
  xclip -selection clipboard < "$KEY_PATH.pub"
  echo "✔️ Public key copied to clipboard using xclip."
elif command -v pbcopy &>/dev/null; then
  pbcopy < "$KEY_PATH.pub"
  echo "✔️ Public key copied to clipboard using pbcopy."
else
  echo "⚠️ Could not detect xclip or pbcopy. Please copy it manually:"
  cat "$KEY_PATH.pub"
fi

# Final instructions
echo -e "\n✅ Now add this SSH key to your GitHub account:"
echo "👉 https://github.com/settings/keys"
echo "Then test with: ssh -T git@github.com"
