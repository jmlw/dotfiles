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
  TODAY=`date +%Y-%m-%d`
  CURRENT_MONTH=`date +%m`
  CURRENT_YEAR=`date +%Y`
  TAIL=1
  if [ -f "$NOTES/$CURRENT_YEAR/$CURRENT_MONTH/$TODAY.md" ]; then
    TAIL+=1
  fi
  LAST=`ls -d "$NOTES"/*/*/*.md | tail -n $TAIL | head -n 1`
  if [ ! -z "$LAST" ]; then
    echo "opening $LAST"
    $EDITOR $LAST
  else
    echo "couldn't find a previous note to open!"
  fi
}
