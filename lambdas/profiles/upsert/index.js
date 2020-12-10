const { S3 } = require("aws-sdk");
const s3 = new S3({
  apiVersion: "2006-03-01"
})

module.exports.handler = async function handler ({
  headers,
  body,
  pathParameters,
  isBase64Encoded
}) {

  if (!body || !body.length) {
    return { statusCode: 400 }
  }

  const contentType = headers["content-type"]

  if (!contentType || !contentType.startsWith("application/json")) {
    return { statusCode: 415 }
  }

  const strBody = isBase64Encoded
    ? Buffer.from(body, "base64").toString("utf8")
    : body.toString("utf8")

  // TODO:
  // if (strBody.length > 5120000) { // 5MiB
  //   return { statusCode: 413 };
  // }

  const params = {
    Bucket: process.env.BUCKET_NAME,
    Key: pathParameters.profileName,
    Body: strBody
  }

  await s3.putObject(params).promise()
  return { statusCode: 204 }

}

if (!process.env.BUCKET_NAME) {
  throw new Error("missing required env var BUCKET_NAME");
}
