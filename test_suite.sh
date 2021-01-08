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
#
# test_profiles_upsert_500() {
#   printf "test_profiles_upsert_500\n"
#   resp_body="$(mktemp)"
#
#   aws lambda invoke \
#     --function-name tcjam-test-upsertprofilehandler \
#     --payload '{"profileName":">"}' \
#     $resp_body \
#   > /dev/null
#
#   status=$(cat $resp_body | jq .statusCode)
#   assert_equal $status 500
# }

test_profiles_read_200() {
  printf "test_profiles_read_200\n"
  resp_body="$(mktemp)"

  aws lambda invoke \
    --function-name tcjam-test-upsertprofilehandler \
    --payload '{"profileName":"Bob"}' \
    $resp_body \
  > /dev/null

  status=$(cat $resp_body | jq .statusCode)
  assert_equal $status 204

  resp_body="$(mktemp)"

  aws lambda invoke \
    --function-name tcjam-test-readprofilehandler \
    --payload '{"profileName":"Bob"}' \
    $resp_body \
  > /dev/null

  status=$(cat $resp_body | jq .statusCode)
  assert_equal $status 204
}
