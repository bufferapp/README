# Buda Naming Conventions

[Naming things is hard](https://martinfowler.com/bliki/TwoHardThings.html). But having good names and [using them consistently can be crucial](http://www.g9labs.com/2016/04/18/the-joy-of-naming-with-the-powers-of-domain-driven-design/).
One of Buda's core principles is **Consistency**, and this also translates into having a good naming convention that we enforce as much as we can.
You shouldn't have to guess what names or formats to use, and names should be clear, concise, readable and descriptive.

Having a good set of naming conventions in Liger has served us well. This guide uses the [Liger conventions](https://github.com/bufferapp/liger/blob/master/naming_conventions.md) as a basis, but it's expanded to cover the wider footprint of our whole data architecture, and capture the specific conventions we follow to simplify and standardize things in Buda.

## General

- When naming something, always try and imagine how it would be read by someone who knows less about the domain than you do. Can you make things easier for them?
- Don't be verbose. Keep names short, but not so short that they become cryptic. Write `customer` instead of `cust`.
- In general, use `snake_case`. There are some exceptions in this guide, but it's a good default.
- Don't repeat yourself. Try to stay away from names that contain repeated words.
- Make use of context. If your view or table is called `users` don't name your field `user_name`. Instead, you can just use `name` and the fact that it applies to a user can be implied.
- Keep names the same. Wherever possible, try and keep names the same throughout the system. Use the name that we want to consume in the end. For instance, if a value is called `name` in Liger, don't use the name `user_name` in other places.
- If possible, make names descriptive of the type of data it is. For instance, we'll add a `_at` suffix to all timestamps, or a `number_of_` prefix to quantities.
- Be cautious of acronyms unless they are well known. Be especially careful with acronyms you come up with yourself.
- Don't tack on unnecessary or confusing prefixes, suffixes or numbers on names. Don't use things like `new_users`, `users_v2`, `users1`, `users_test`.
- If you're replacing an artifact and you want to keep the old artifact around temporarily, use the same name for the new one and instead rename the old one. Be vigilant in cleaning up these legacy artifacts when they are no longer needed.
- Use a `buda_` prefix to signal that a specific component within a set of shared components (like Kinesis streams, Lambda Functions and Firehose Delivery Streams) is part of the Buda system.

## Types

- All identifier fields use `id`. Each event or entity's identifier field should simply be named `id`. References to other entities will have a `_id` suffix.
  - Example: `user_id`, `helpscout_conversation_id`.
- All timestamp fields have a `_at` suffix.
  - Examples: `created_at`, `updated_at`.
- All fields that represent a integer quantity should have a `number_of_` prefix.
  - Examples: `number_of_messages`, `number_of_updates`.
- All boolean fields have one of the following prefixes:
  - `is_`
  - `has_`
  - `can_`
  - `was_`
  - `did_`
  - Examples: `is_customer`, `has_signed_up`, `can_upgrade`, `was_created_by_hero`.

## Protobuf

We follow the [Protobuf style guide](https://developers.google.com/protocol-buffers/docs/style):
- Use `snake_case` for field names.
- Messages, Enums, Services and RPCs use CamelCase.

## Events Collector

- We use the generic term 'events' to refer to the data we're collecting.
- Events are protobuf messages defined in `buda-protobufs`.
- We use the naming convention: `Collect<EventName>` for service collector message, where EventName is the name of the event and the protobuf message.
  - Examples: `CollectVisit`, `CollectFunnelEvent`.

## Kinesis

- All Buda kinesis streams will have a `buda_` prefix.
- Events from the collector are sent to a Kinesis stream that use the naming convention `buda_<plural_event_name>` where `<plural_event_name>` is the plural name of the event.
  - Examples: a visit is sent to `buda_visits`, a funnel event to `buda_funnel_events`.

## Event Consumers

- Event consumers are currently implemented in AWS Lambda. Event consumer functions names will use the convention `buda_event_consumer_<plural_event_name>`.
  - Examples: `buda_event_consumer_visits`, `buda_event_consumer_funnel_events`.

## Kinesis Firehose

 TODO

## Redshift

 TODO
