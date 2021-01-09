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
    --function-name tcjam-test-readprofilehandler \
    --payload '{"profileName":"Bob"}' \
    $resp_body \
  > /dev/null

  status=$(cat $resp_body | jq .statusCode)
  assert_equal $status 200
}

test_profiles_read_400() {
  printf "test_profiles_read_400\n"
  resp_body="$(mktemp)"

  aws lambda invoke \
    --function-name tcjam-test-readprofilehandler \
    --payload '{}' \
    $resp_body \
  > /dev/null

  status=$(cat $resp_body | jq .statusCode)
  assert_equal $status 400
}

test_profiles_read_404() {
  printf "test_profiles_read_404\n"
  resp_body="$(mktemp)"

  aws lambda invoke \
    --function-name tcjam-test-readprofilehandler \
    --payload '{"profileName":"Alice"}' \
    $resp_body \
  > /dev/null

  status=$(cat $resp_body | jq .statusCode)
  assert_equal $status 404
}

test_profiles_delete_204() {
  printf "test_profiles_delete_204\n"
  resp_body_upsert="$(mktemp)"

  aws lambda invoke \
    --function-name tcjam-test-upsertprofilehandler \
    --payload '{"profileName":"Alice"}' \
    $resp_body_upsert \
  > /dev/null

  upsert_status=$(cat $resp_body_upsert | jq .statusCode)
  assert_equal $status 204

  aws lambda invoke \
    --function-name tcjam-test-deleteprofilehandler \
    --payload '{"profileName":"Alice"}' \
    $resp_body_delete \
  > /dev/null

  status_delete=$(cat $resp_body_delete | jq .statusCode)
  assert_equal $status_delete 204
}
