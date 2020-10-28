const { DynamoDB } = require("aws-sdk");
const { v4: uuidv4 } = require("uuid");

const dynamodb = new DynamoDB.DocumentClient({
  apiVersion: "2012-08-10"
})

module.exports.handler = async function handler ({
  headers,
  body,
  isBase64Encoded
}) {
  console.log("DEBUG:::", event)

  if (!body || !body.length) {
    return { statusCode: 400 }
  }

  const strBody = isBase64Encoded
    ? Buffer.from(body, "base64").toString("utf8")
    : body.toString("utf8")

  console.log("DEBUG:::strBody length", strBody.length)


  if (strBody.length > 5120000) { // 5MiB
    return { statusCode: 413 };
  }

  const params = {
    TableName: process.env.PROFILE_TABLE_NAME,
    Item: {
      "profile_id": uuidv4(),
      "profile": body
    }
  }

  await dynamodb.put(params).promise()
  return { statusCode: 204 }

}

if (!process.env.PROFILE_TABLE_NAME) {
  throw new Error("missing required env var PROFILE_TABLE_NAME");
}
