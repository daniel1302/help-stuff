

// ...

function mfa 
{
  SOURCE_PROFILE="$1";
  OP_ITEM_ID="${SOURCE_PROFILE}_AWS"

  eval "$(op signin)";
  USERNAME="$(op get item $OP_ITEM_ID --fields 'username')";
  TOTP="$(op get totp $OP_ITEM_ID)";
  ~/.aws/mfa2 "$SOURCE_PROFILE" "$USERNAME" "$TOTP";
  export AWS_PROFILE="${SOURCE_PROFILE}_MFA";
}
