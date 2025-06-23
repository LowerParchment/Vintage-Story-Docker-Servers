#!/bin/bash

VS_CONFIG_PATH="/root/.config/VintagestoryData"
PLAYERDATA_PATH="$VS_CONFIG_PATH/Playerdata"
PLAYERDATA_FILE="$PLAYERDATA_PATH/playerdata.json"

mkdir -p "$PLAYERDATA_PATH"

echo "Welcome to the Vintage Story Docker server setup."
read -p "Enter your exact in-game username (case-sensitive): " playerName

echo "Starting Vintage Story server..."
./VintagestoryServer &
SERVER_PID=$!

echo "Waiting for player '$playerName' to join..."
while true; do
    for file in "$PLAYERDATA_PATH"/*.json; do
        filePlayerName=$(jq -r '.LastKnownName' "$file" 2>/dev/null)
        if [[ "$filePlayerName" == "$playerName" ]]; then
            PLAYER_UID=$(basename "$file" .json)
            echo "✔ Found UID for $playerName: $PLAYER_UID"
            break 2
        fi
    done
    sleep 1
done

# Wait a moment to ensure playerdata.json is initialized
sleep 3

echo "Patching $PLAYERDATA_FILE with admin role for $playerName..."

# Remove any existing entries for this UID
tmpfile=$(mktemp)
jq "map(select(.PlayerUID != \"$PLAYER_UID\"))" "$PLAYERDATA_FILE" > "$tmpfile" && mv "$tmpfile" "$PLAYERDATA_FILE"

# Append admin entry
jq ". + [{
  \"PlayerUID\": \"$PLAYER_UID\",
  \"RoleCode\": \"admin\",
  \"PermaPrivileges\": [],
  \"DeniedPrivileges\": [],
  \"PlayerGroupMemberShips\": {},
  \"AllowInvite\": true,
  \"LastKnownPlayername\": \"$playerName\",
  \"CustomPlayerData\": {},
  \"ExtraLandClaimAllowance\": 0,
  \"ExtraLandClaimAreas\": 0,
  \"FirstJoinDate\": \"$(date '+%m/%d/%Y %H:%M')\",
  \"LastJoinDate\": \"$(date '+%m/%d/%Y %H:%M')\",
  \"LastCharacterSelectionDate\": null
}]" "$PLAYERDATA_FILE" > "$tmpfile" && mv "$tmpfile" "$PLAYERDATA_FILE"

echo "✔ Admin privileges granted to $playerName via playerdata.json."

# Let the server keep running
wait "$SERVER_PID"
