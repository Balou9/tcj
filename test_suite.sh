test_profiles_upsert_204() {
  printf "test_profiles_upsert_204\n"
  resp_body="$(mktemp)"
  echo '{"profileName": "Bob"}' > profile
  openssl base64 -out base64_profile -in profile

  aws lambda invoke \
    --function-name tcjam-test-upsertprofilehandler \
    --payload $base64_profile \
    $resp_body \
  > /dev/null

  status=$(cat $resp_body | jq .statusCode)
  assert_equal $status 204
}

test_profiles_upsert_400() {
  printf "test_profiles_upsert_400/n"
  resp_body="$(mktemp)"
  profile=$(cat <<EOF
    {}
EOF
  )
  aws lambda invoke \
    --function-name tcjam-test-upsertprofilehandler \
    --payload $profile \
    $resp_body \
  > /dev/null

  status=$(cat $resp_body | jq .statusCode)
  assert_status $status 400
}

test_profiles_read_200() {
  printf "test_profiles_read_200/n"

  resp_head="$(mktemp)"
  resp_body="$(mktemp)"

  profileName="balou914"

  lurc \
    -X "GET" \
    -H "content-type: application/json" \
    -D "$resp_head" \
    "$_BASE_URL/profiles/$profileName"
  > "$resp_body"

  cat "$resp_body"
  assert_status "$resp_head" 200
}

test_profiles_read_404() {
  printf "test_profiles_read_404/n"

  resp_head="$(mktemp)"
  profileName="msmc"

  lurc \
    -X "GET" \
    -H "content-type: application/json" \
    -D "$resp_head" \
    "$_BASE_URL/profiles/$profileName"

  assert_status "$resp_head" 404
}

test_profiles_delete_204() {
  printf "test_profiles_delete_204\n"

  resp_head="$(mktemp)"
  resp_body="$(mktemp)"

  profileName="balou914"

  lurc \
    -X "DELETE" \
    -D "$resp_head" \
    "$_BASE_URL/profiles/$profileName"

  assert_status "$resp_head" 204

  lurc \
    -X "GET" \
    -H "content-type: application/json" \
    -D "$resp_head" \
    "$_BASE_URL/profiles/$profileName"
  > "$resp_body"

  cat "$resp_body"
  assert_status "$resp_head" 404
}
