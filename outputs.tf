output "topic" {
  value       = module.pubsub_topic.topic
  description = "The name of the Pub/Sub topic"
}

output "topic_id" {
  value       = module.pubsub_topic.id
  description = "The ID of the Pub/Sub topic"
}
