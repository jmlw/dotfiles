today() {
  NOTES="$HOME/Sync/daily-notes"
  TEMPLATE="$NOTES/template.md"
  CURRENT_MONTH=`date +%m`
  CURRENT_YEAR=`date +%Y`
  DIRECTORY="$NOTES/$CURRENT_YEAR/$CURRENT_MONTH"
  TODAY=`date +%Y-%m-%d`
  FILE="$DIRECTORY/$TODAY.md"
  if [ ! -d $DIRECTORY ]; then
    mkdir -p "$DIRECTORY"
  fi
  if [ ! -f "$FILE" ] && [ -f "$TEMPLATE" ]; then
    sed -e "s/##TODAY##/$TODAY/g" "$TEMPLATE" > "$FILE"
  fi

  $EDITOR "$FILE"
}

yesterday() {
  NOTES="$HOME/Sync/daily-notes"
  LAST=`ls -d "$NOTES"/*/*/*.md | tail -n 2 | head -n 1`
  if [ ! -z "$LAST" ]; then
    echo "opening $LAST"
    $EDITOR $LAST
  else
    echo "couldn't find a previous note to open!"
  fi
}
