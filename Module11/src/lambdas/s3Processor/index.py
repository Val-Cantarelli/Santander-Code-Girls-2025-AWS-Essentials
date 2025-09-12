import json
import boto3
import os
from datetime import datetime

s3 = boto3.client('s3')
ddb = boto3.resource('dynamodb')

def lambda_handler(event, context):
    print('Event:', json.dumps(event))
    table = ddb.Table(os.environ.get('TABLE_NAME'))
    for record in event.get('Records', []):
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']
        try:
            obj = s3.get_object(Bucket=bucket, Key=key)
            body = obj['Body'].read().decode('utf-8')
            item = {
                'id': key,
                'content': body,
                'timestamp': datetime.utcnow().isoformat()
            }
            table.put_item(Item=item)
            print('Saved item', item['id'])
        except Exception as e:
            print('Error processing S3 record', e)
            raise
    return {'statusCode': 200}
