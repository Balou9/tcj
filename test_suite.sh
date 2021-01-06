test_profiles_upsert_204() {
  printf "test_profiles_upsert_204\n"
  resp_body="$(mktemp)"
  profile=`echo '{"profileName": "Bob"}' | openssl base64`

  aws lambda invoke \
    --function-name tcjam-test-upsertprofilehandler \
    --payload $profile \
    "$resp_body" \
  > /dev/null

  status=$(cat $resp_body | jq .statusCode)
  assert_equal $status 204
}
