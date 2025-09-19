import json
import boto3
import os

ddb = boto3.resource('dynamodb')

def lambda_handler(event, context):
    try:
        table = ddb.Table(os.environ.get('TABLE_NAME'))
        resp = table.scan()
        items = resp.get('Items', [])
        return {
            'statusCode': 200,
            'headers': {'Content-Type': 'application/json'},
            'body': json.dumps(items)
        }
    except Exception as e:
        print(e)
        return {'statusCode': 500, 'body': json.dumps({'error': 'Internal'})}
