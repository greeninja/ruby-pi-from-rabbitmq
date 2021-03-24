## Summary

Pulls an interger out of RabbitMQ, then calculates Pi to that number of decimal points.

## Populate RabbitMQ (needs the 'foo' queue)

```bash
for i in `seq 1 1000`
  do curl -u guest:guest -X POST -d "{\"properties\":{\"delivery_mode\":2},\"routing_key\":\"foo\",\"payload\":\"$( echo $RANDOM )\",\"payload_encoding\":\"string\"}" http://127.0.0.1:8080/api/exchanges/%2f/amq.default/publish
done
```

