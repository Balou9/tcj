test_profiles_upsert_204() {
  printf "test_profiles_upsert_204\n"
  resp_body="$(mktemp)"

  aws lambda invoke \
    --function-name tcjam-test-upsertprofilehandler \
    --payload @.test/fixtures/profile.json \
    $resp_body \
  > /dev/null

  status=$(cat $resp_body | jq .statusCode)
  assert_equal $status 204
}

test_profiles_upsert_400_no_body() {
  printf "test_profiles_upsert_400_no_body/n"

  resp_head="$(mktemp)"
  profileName="balou914"

  lurc \
    -X "PUT" \
    -H "content-type: application/json" \
    -D "$resp_head" \
    "$_BASE_URL/profiles/$profileName"

  assert_status "$resp_head" 400
}

test_profiles_upsert_415_no_content_type() {
  printf "test_profiles_upsert_415/n"

  resp_head="$(mktemp)"
  resp_body="$(mktemp)"
  profileName="balou914"

  lurc \
    -X "PUT" \
    --data @./test/fixtures/good_profile.json \
    -D "$resp_head" \
    "$_BASE_URL/profiles/$profileName"

  assert_status "$resp_head" 415
}

test_profiles_upsert_415_unexpected_content_type() {
  printf "test_profiles_upsert_415/n"

  resp_head="$(mktemp)"
  resp_body="$(mktemp)"

  lurc \
    -X "PUT" \
    -H "content-type: application/xml" \
    --data @./test/fixtures/good_profile.json \
    -D "$resp_head" \
    "$_BASE_URL/profiles/$profileName"

  assert_status "$resp_head" 415
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
