#!/bin/bash

ORG="rh-aiservices-bu"
REPO="sdg-notebook"



# Fetch tags using Quay.io API
tags=$(curl -s "https://quay.io/api/v1/repository/${ORG}/${REPO}/tag/?limit=100" | jq -r '.tags[].name')

# Filter and sort tags that match semver with patch 0 (e.g., 0.1.0)
latest_tag=$(echo "$tags" | grep -E '^[0-9]+\.[0-9]+\.0$' | sort -t. -k1,1n -k2,2n | tail -n1)

if [[ -n "$latest_tag" ]]; then
    major=$(echo "$latest_tag" | cut -d. -f1)
    minor=$(echo "$latest_tag" | cut -d. -f2)
    next_minor=$((minor + 1))
    next_tag="${major}.${next_minor}.0"
else
    # Default starting tag if none found
    next_tag="0.1.0"
fi

echo $next_tag

