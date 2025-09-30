#!/bin/bash

# Script to display work bookmarks in wofi and open selected URL

WORK_BOOKMARKS_FILE="$HOME/.config/wofi/work_bookmarks.md"

# Function to focus browser window
kwin_focus_browser() {
    # Method 1: Try wmctrl first (if available)
    if command -v wmctrl >/dev/null 2>&1; then
        if wmctrl -xa "$firefox" 2>/dev/null; then
            return 0
        fi
    fi
}

# Extract bookmark names and URLs, then let user select
selection=$(grep -o '\[.*\]' "$WORK_BOOKMARKS_FILE" | sed 's/\[\(.*\)\]/[work] \1/' | wofi --dmenu --prompt "open bookmark:")

if [ -n "$selection" ]; then
    # Remove the [work] prefix to get the original bookmark name
    bookmark_name=$(echo "$selection" | sed 's/^\[work\] //')
    # Find the URL for the selected bookmark
    url=$(grep "\[$bookmark_name\]" "$WORK_BOOKMARKS_FILE" | sed 's/.*(\(.*\))/\1/')
    
    if [ -n "$url" ]; then
        # Open the URL in default browser
        xdg-open "$url"
        # Focus the browser window (try multiple common browser class names)
        kwin_focus_browser
    fi
fi
