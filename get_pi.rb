#!/usr/local/env ruby

require 'bunny'
require "bigdecimal/math"
include BigMath

puts "[x] Starting up..."

rabbit_host = ENV["rabbit_host"] || "127.0.0.1"

puts "[x] Using #{rabbit_host} for RabbitMQ..."

connection = Bunny.new(automatically_recover: false, host: rabbit_host, log_level: 'warn')
connection.start

channel = connection.create_channel
channel.prefetch(1)

len = channel.queue_declare('foo', durable: true)

queue = channel.queue('foo', durable: true, auto_delete: false)


while len.message_count == 0
  puts "[x] Waiting for Queue to be be populated"
  puts "[x] Sleeping for 10 seconds"
  sleep 10
  len = channel.queue_declare('foo', durable: true)
end

puts "[x] Queue has #{len.message_count} in the queue, starting"

while len.message_count > 0
  delivery_info, properties, payload = queue.pop
  puts "[x] Working out Pi to #{payload *1000 } points of accuracy..."
  puts "[x] Pi: #{BigMath.PI(payload.to_i).to_s('F')}"
  len = channel.queue_declare('foo', durable: true)
end

connection.close
