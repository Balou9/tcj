const { S3 } = require("aws-sdk");
const s3 = new S3({
  apiVersion: "2006-03-01"
});

module.exports.handler = async function handler ({
  pathParameters
}) {

  const params = {
    Bucket: process.env.BUCKET_NAME,
    Key: {
      "profileName": pathParameters.profileName
    }
  }

  await dynamodb.delete(params).promise()

  return { "statusCode": 204 }

}

if (!process.env.PROFILE_TABLE_NAME) {
  throw new Error("missing required env var PROFILE_TABLE_NAME");
}
