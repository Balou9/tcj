const { S3 } = require("aws-sdk");
const s3 = new S3({
  apiVersion: "2006-03-01"
})

module.exports.handler = async function (event, context) {
  try {
    if (!event.profileName) {
      return { statusCode: 400 }
    }

    await s3.putObject({
      Key: event.profileName,
      Bucket: process.env.BUCKET_NAME,
      Body: JSON.stringify({ score: 0 })
    }).promise()

    return { statusCode: 204 }
  } catch (err) {
    return {
      statusCode: 500,
      error: err
    }
  }
}
