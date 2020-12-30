const { S3 } = require("aws-sdk");
const s3 = new S3({
  apiVersion: "2006-03-01"
})

module.exports.handler = async function handler (event, context) {
  try {
    if (!event.profile) {
      return { statusCode: 400 }
    }

    await s3.putObject({
      Key: uuidv4(),
      Bucket: process.env.PROFILE_BUCKET_NAME,
      Body: event.profile
    }).promise()

    return { statusCode: 204 }

  }
}
