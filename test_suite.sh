test_profiles_upsert_204() {
  printf "test_profiles_upsert_204\n"
  resp_body="$(mktemp)"

  aws lambda invoke \
    --function-name tcjam-test-upsertprofilehandler \
    --payload '{"profileName":"Bob"}' \
    $resp_body \
  > /dev/null

  status=$(cat $resp_body | jq .statusCode)
  assert_equal $status 204
}

test_profiles_upsert_400() {
  printf "test_profiles_upsert_400\n"
  resp_body="$(mktemp)"

  aws lambda invoke \
    --function-name tcjam-test-upsertprofilehandler \
    --payload '{}' \
    $resp_body \
  > /dev/null

  status=$(cat $resp_body | jq .statusCode)
  assert_equal $status 400
}

test_profiles_upsert_500() {
  printf "test_profiles_upsert_500\n"
  resp_body="$(mktemp)"

  aws lambda invoke \
    --function-name tcjam-test-upsertprofilehandler \
    --payload '{"profileName": ">a)"}' \
    $resp_body \
  > /dev/null

  status=$(cat $resp_body | jq .statusCode)
  assert_equal $status 500
}
