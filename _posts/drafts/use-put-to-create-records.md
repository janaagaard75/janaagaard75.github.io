# Why you should use PUT to create records

PUT is idempotent, POST is not. This is not something inherit to the HTTP verbs, but something that the implementation should respect.

PUT is usually used when updating a record.

When a request time out, the client cannot assume that the creation failed. It could very well be that the internet connection that died, so the response OK that never reached the client. Sending a second POST would create a duplicate record.

Using PUT solves this because the client just has to send the request again.

This means that the client has to specify the ID of th record being created. But this is easy to solve by using UUIDs instead of auto incrementing IDs. Pretty much all programming languages have a good reference implementation for generating UUIDs.

Senior will often tell you that you have to use POST for creating records, but this is not true. And PUT is better.
