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

test_profile_upsert_204() {
  printf "test_profile_upsert_204\n"
  resp_head="$(mktemp)"
  resp_body="$(mktemp)"

  lurc \
    -X "PUT" \
    -H "content-type: application/json" \
    --data @./test/fixtures/profile.json \
    -D "$resp_head" \
    "$_BASE_URL/profile"

  assert_status "$resp_head" 204
}


# test_profile_read_200() {
#   printf "test_profile_read_200\n"
#   resp_head="$(mktemp)"
#   resp_body="$(mktemp)"
#
#   profile_id="balou419"
#
#   lurc \
#     -X "GET" \
#     -D "$resp_head" \
#     -H "content-type: application/json" \
#     "$_BASE_URL/profile/$profile_id"
#   > "$resp_body"
#
#   cat "$resp_body"
#   assert_status "$resp_head" 200
# }
