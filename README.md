# OpenAI Ads Conversions API — Server-side GTM Template

Send server-side conversion events to the
[OpenAI Ads Conversions API](https://developers.openai.com/ads) from a
server-side Google Tag Manager container.

This is the server-side companion to the
[OpenAI Ads Measurement Pixel](https://github.com/Found-Search-Marketing/openai-ads-measurement-pixel-gtm-template)
web template. Use both together to dedupe browser and server events.

## Features

- POSTs to `https://bzr.openai.com/v1/events` with `Authorization: Bearer <key>`
- Standard event dropdown (`page_viewed`, `contents_viewed`, `items_added`,
  `checkout_started`, `order_created`, `lead_created`, `registration_completed`,
  `appointment_scheduled`, `subscription_created`, `trial_started`) plus a
  Custom event mode
- Auto-derives `data.type` from the event name
  (`order_created` → `contents`, `lead_created` → `customer_action`, etc.)
- Reads `oppref` from the `__oppref` first-party cookie set by the OpenAI
  Pixel SDK; also accepts `event_data.__oppref`, `event_data.oppref`, or a
  `?oppref=` URL parameter, then persists it to a 90-day cookie
- Maps GA4 `items[]` → OpenAI `contents[]`, with auto decimal-to-integer
  conversion (`25.99` → `2599`)
- sha256-hashes PII fields before send
  (`email`, `phone`, `first_name`, `last_name`, `city`, `state`, `postal_code`,
  `country`, `external_id`); already-hashed values pass through
- Multi-pixel fan-out via a single tag fire
- Event enhancement via a first-party `_gtmeec` cookie so subsequent events
  can reuse hashed user data when the data layer is empty
- Optional BigQuery request/response logging
- `validate_only` flag for testing
- Consent-mode gating (skip send when `ad_storage` denied)

## Setup

1. Install this template: in your **server-side** GTM container, open
   **Templates → Tag Templates → New → ⋮ → Import** and pick
   [`template.tpl`](template.tpl).
2. Create a tag from the template.
3. Provide your **Pixel ID** and **API Key** from the Conversions tab in
   OpenAI Ads Manager.
4. Pick a **Standard Event** that matches your data layer event, or set
   Event Type to **Custom**.
5. Set the trigger and publish.

For browser/server deduplication, install the matching
[OpenAI Ads Measurement Pixel](https://github.com/Found-Search-Marketing/openai-ads-measurement-pixel-gtm-template)
template on the web container and reuse the same `event_id` (browser) /
`id` (server). For custom events, also reuse the same `custom_event_name`.

## Permissions

The template requests the minimum needed:

- `send_http` to `https://bzr.openai.com/*`
- `get_cookies` / `set_cookies` for `__oppref` and `_gtmeec` only
- `read_request` for the `trace-id` and `referer` headers
- `read_event_data`, `logging`, `access_bigquery` (used only if BigQuery
  logging is enabled)

## Tests

The template ships with scenario tests covering: bearer auth, custom events,
`validate_only`, consent gating, oppref cookie, items → contents mapping,
and PII hashing. Open the template in GTM → **Tests** tab → **Run all**.

## Support

Open an issue on this repository.

## License

Licensed under the [Apache 2.0 License](LICENSE).
