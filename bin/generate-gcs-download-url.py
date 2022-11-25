#!/usr/bin/python3
#
# Generates a temporary URL to an object in a GCS bucket for wget/curl to grab
#
# You need to be authed to GCS for it to work. Do:
# export GOOGLE_APPLICATION_CREDENTIALS="/home/user/Downloads/service-account-file.json"
# replacing the path with the service account json keyfile
#
# Author: Chuck Findlay <chuck@findlayis.me>
# License: LGPL v3.0
import sys, getopt, datetime

from google.cloud import storage

def main():
    argv = sys.argv[1:]
    bucket = None
    ourObject = None

    try:
      opts, args = getopt.getopt(argv,"hb:o:",["bucket=","object="])
    except getopt.GetoptError:
      print(sys.argv[0] + " -b <gcs-bucket> -o <fileinbucket.pdf>")
      sys.exit(2)

    for opt, arg in opts:
      if opt == '-h':
        print(sys.argv[0] + " -b <gcs-bucket> -o <fileinbucket.pdf>")
        sys.exit()
      elif opt in ("-b", "--bucket"):
         bucket = arg
      elif opt in ("-o", "--object"):
         ourObject = arg
      else:
        print("Error in usage. Try " + sys.argv[0] + " -h")
        sys.exit(2)

    if (bucket == None) or (ourObject == None):
        print("No bucket and/or object provided to generate url for. See " + sys.argv[0] + " -h")
        sys.exit(2)

    print(generate_download_signed_url_v4(bucket, ourObject))

# Below function is from Google's example, just with expiration adjusted
# See https://cloud.google.com/storage/docs/samples/storage-generate-signed-url-v4 (September 2022)
def generate_download_signed_url_v4(bucket_name, blob_name):
    """Generates a v4 signed URL for downloading a blob.

    Note that this method requires a service account key file. You can not use
    this if you are using Application Default Credentials from Google Compute
    Engine or from the Google Cloud SDK.
    """
    # bucket_name = 'your-bucket-name'
    # blob_name = 'your-object-name'

    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(blob_name)

    url = blob.generate_signed_url(
        version="v4",
        # Six hour valid URL
        expiration=datetime.timedelta(hours=6),
        # Allow GET requests using this URL.
        method="GET",
    )

    return url

if __name__ == "__main__":
    main()
