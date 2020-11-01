# NOTE: requires env vars _ACCESS_TOKEN, _OTHER_TOKEN, and _BASE_URL

assert_status() {
  # usage: assert_status "$header_file" $status_code
  if [[ -z "$1" ]] || [[ -z "$2" ]]; then
    exit 1
  fi

  printf -v pattern "HTTP/[1-9]\.?[1-9]? %d" $2

  if ! grep -qE "$pattern" "$1"; then
    >&2 printf "http status does not equal %d\n" $2
    >&2 cat "$1"
    exit 1
  fi
}

assert_equal() {
  # usage: assert_equal "$a" "$b"
  if [[ -z "$1" ]] || [[ -z "$2" ]]; then
    exit 1
  fi

  if [[ "$1" != "$2" ]]; then
    >&2 printf "values are not equal\n" "$1" "$2"
    exit 1
  fi
}

assert_match() {
  # usage: assert_match "$string" $pattern
  if [[ -z "$1" ]] || [[ -z "$2" ]]; then
    exit 1
  fi

  if [[ ! $1 =~ $2 ]]; then
    >&2 printf "string %s does not match pattern %s\n" "$1" "$2"
    exit 1
  fi
}

lurc() {
  curl -s --proto '=https' --tlsv1.2 "$@"
}

test_profiles_upsert_204() {
  printf "test_profiles_upsert_204\n"
  resp_head="$(mktemp)"

  lurc \
    -X "PUT" \
    -H "content-type: application/json" \
    --data @./test/fixtures/good_profile.json \
    -D "$resp_head" \
    "$_BASE_URL/profiles"

  assert_status "$resp_head" 204
}

test_profiles_upsert_400_no_body() {
  printf "test_profiles_upsert_400_no_body/n"
  resp_head="$(mktemp)"

  lurc \
    -X "PUT" \
    -H "content-type: application/json" \
    -D "$resp_head" \
    "$_BASE_URL/profiles"

  assert_status "$resp_head" 400
}

# test_profiles_upsert_413() {
#   printf "test_profiles_upsert_413/n"
#   resp_head="$(mktemp)"
#   resp_body="$(mktemp)"
#
#   lurc \
#     -X "PUT" \
#     -H "content-type: application/json" \
#     --data @./test/fixtures/xxl_profile.json \
#     -D "$resp_head" \
#     "$_BASE_URL/profiles"
#   > "$resp_body"
#
#   assert_status "$resp_head" 413
# }

test_profiles_upsert_415_no_content_type() {
  printf "test_profiles_upsert_415/n"

  resp_head="$(mktemp)"
  resp_body="$(mktemp)"

  lurc \
    -X "PUT" \
    --data @./test/fixtures/good_profile.json \
    -D "$resp_head" \
    "$_BASE_URL/profiles"

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
    "$_BASE_URL/profiles"

  assert_status "$resp_head" 415
}

test_profiles_read_200 () {
  printf "test_profiles_read_200/n"

  resp_head="$(mktemp)"
  resp_body="$(mktemp)"

  profile_id="0c1a9b12-8459-43ea-80c5-0f07ac85b270"

  lurc \
    -X "GET" \
    -H "content-type: application/json" \
    -D "$resp_head" \
    "$_BASE_URL/profiles/$profile_id"
  > "$resp_body"

  cat "$resp_body"
  assert_status "$resp_head" 200
}

test_profiles_read_404 () {
  print "test_profiles_read_404/n"

  profile_id="msmc"

  lurc \
    -X "GET" \
    -H "content-type: application/json" \
    -D "$resp_head" \
    "$_BASE_URL/profiles/$profile_id"
  > "$resp_body"

  assert_status "$resp_head" 404
}
