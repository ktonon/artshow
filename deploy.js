const AWS = require('aws-sdk');
const BPromise = require('bluebird');
const fs = require('fs');
const mime = require('mime-types');
const sysPath = require('path');

const Bucket = process.argv[2];
const src = sysPath.join(__dirname, 'public');
const files = fs.readdirSync(src);
const s3 = BPromise.promisifyAll(new AWS.S3({ apiVersion: '2006-03-01' }));

if (!Bucket) {
  console.log('Usage: npm run deploy your.host.com');
  process.exit();
}

s3
.listBucketsAsync({})
.then((data) => {
  if (!data.Buckets.find(b => b.Name === Bucket)) {
    return s3.createBucketAsync({
      Bucket,
      ACL: 'public-read',
    });
  }
  return BPromise.resolve();
})
.then(() =>
  s3.putBucketWebsiteAsync({
    Bucket,
    WebsiteConfiguration: {
      ErrorDocument: { Key: 'error.html' },
      IndexDocument: { Suffix: 'index.html' },
    },
  })
)
.then(() => BPromise.all(files.map(Key =>
  s3.uploadAsync({
    ACL: 'public-read',
    ContentType: mime.lookup(Key),
    Body: fs.readFileSync(sysPath.join(src, Key)),
    Bucket,
    Key,
  })
)))
.then(() => {
  console.log(`Deployed to: http://${Bucket}.s3-website-us-east-1.amazonaws.com/`);
})
.catch((err) => {
  console.error(err);
});
