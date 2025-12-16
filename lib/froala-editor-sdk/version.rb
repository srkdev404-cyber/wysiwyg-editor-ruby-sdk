- name: Read gem version
  id: ver
  run: |
    FILE="lib/froala-editor-sdk/version.rb"

    if [ ! -f "$FILE" ]; then
      echo "ERROR: Version file not found: $FILE"
      exit 1
    fi

    MAJOR=$(grep -Eo 'Major\s*=\s*[0-9]+' "$FILE" | grep -Eo '[0-9]+')
    MINOR=$(grep -Eo 'Minor\s*=\s*[0-9]+' "$FILE" | grep -Eo '[0-9]+')
    TINY=$(grep -Eo 'Tiny\s*=\s*[0-9]+' "$FILE" | grep -Eo '[0-9]+')

    if [ -z "$MAJOR" ] || [ -z "$MINOR" ] || [ -z "$TINY" ]; then
      echo "ERROR: Could not extract version components"
      cat "$FILE"
      exit 1
    fi

    VERSION="${MAJOR}.${MINOR}.${TINY}"

    echo "VERSION=$VERSION" >> $GITHUB_ENV
    echo "Extracted version: $VERSION"
