#!/bin/bash

# Script to display work bookmarks in walker and open selected URL

WORK_BOOKMARKS_FILE="$HOME/.config/wofi/work_bookmarks.md"
PERSONAL_BOOKMARKS_FILE="$HOME/.config/wofi/personal_bookmarks.md"

# Function to focus browser window in Hyprland
hyprland_focus_browser() {
    # Try to focus Firefox window using hyprctl
    if command -v hyprctl >/dev/null 2>&1; then
        # Find Firefox window and focus it
        if hyprctl clients | grep -q "firefox"; then
            hyprctl dispatch focuswindow "firefox"
            return 0
        fi
    fi
    
    # Fallback: Try wmctrl if available
    if command -v wmctrl >/dev/null 2>&1; then
        if wmctrl -xa "firefox" 2>/dev/null; then
            return 0
        fi
    fi
}

# Extract bookmark names from both files and combine them
combined_bookmarks=""

# Add work bookmarks with [work] prefix
if [ -f "$WORK_BOOKMARKS_FILE" ]; then
    work_bookmarks=$(grep -o '\[.*\]' "$WORK_BOOKMARKS_FILE" | sed 's/\[\(.*\)\]/[work] \1/')
    combined_bookmarks="$work_bookmarks"
fi

# Add personal bookmarks with [personal] prefix
if [ -f "$PERSONAL_BOOKMARKS_FILE" ]; then
    personal_bookmarks=$(grep -o '\[.*\]' "$PERSONAL_BOOKMARKS_FILE" | sed 's/\[\(.*\)\]/[personal] \1/')
    if [ -n "$combined_bookmarks" ]; then
        combined_bookmarks="$combined_bookmarks\n$personal_bookmarks"
    else
        combined_bookmarks="$personal_bookmarks"
    fi
fi

# Let user select from combined list
selection=$(echo -e "$combined_bookmarks" | walker --dmenu)

if [ -n "$selection" ]; then
    # Determine which file to search based on prefix
    if [[ "$selection" == \[work\]* ]]; then
        # Remove the [work] prefix to get the original bookmark name
        bookmark_name=$(echo "$selection" | sed 's/^\[work\] //')
        # Find the URL for the selected bookmark in work file
        url=$(grep "\[$bookmark_name\]" "$WORK_BOOKMARKS_FILE" | sed 's/.*(\(.*\))/\1/')
    elif [[ "$selection" == \[personal\]* ]]; then
        # Remove the [personal] prefix to get the original bookmark name
        bookmark_name=$(echo "$selection" | sed 's/^\[personal\] //')
        # Find the URL for the selected bookmark in personal file
        url=$(grep "\[$bookmark_name\]" "$PERSONAL_BOOKMARKS_FILE" | sed 's/.*(\(.*\))/\1/')
    fi
    
    if [ -n "$url" ]; then
        # Open the URL in default browser
        xdg-open "$url"
        # Give Firefox time to start/load, then focus the window
        sleep 1
        hyprland_focus_browser
    fi
fi
