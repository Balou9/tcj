const { S3 } = require("aws-sdk");
const s3 = new S3({
  apiVersion: "2006-03-01"
})

module.exports.handler = async function (event, context) {
  try {
    if (!event.profile) {
      return { statusCode: 400 }
    }

    await s3.putObject({
      Key: 'Bob',
      Bucket: process.env.BUCKET_NAME,
      Body: event.profile
    }).promise()

    return { statusCode: 204 }
  } catch (err) {
    return { statusCode: 500 }
  }
}
