___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "OpenAI Ads Conversions API",
  "categories": ["CONVERSIONS", "ADVERTISING"],
  "description": "Send server-side conversion events to the OpenAI Ads Conversions API. Supports standard and custom events, multi-pixel fan-out, event enhancement via first-party cookie, and BigQuery logging.",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "credentials",
    "displayName": "Credentials",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "TEXT",
        "name": "pixelId",
        "displayName": "Pixel ID",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "help": "Your Pixel ID from the Conversions tab in OpenAI Ads Manager."
      },
      {
        "type": "TEXT",
        "name": "apiKey",
        "displayName": "API Key",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "help": "Conversions API key. Sent as 'Authorization: Bearer <API-KEY>'."
      },
      {
        "type": "CHECKBOX",
        "name": "enableMultipixelSetup",
        "checkboxText": "Send to additional pixels",
        "simpleValueType": true
      },
      {
        "type": "SIMPLE_TABLE",
        "name": "pixelIdAndApiKeyTable",
        "displayName": "Additional Pixels",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Pixel ID",
            "name": "pixelId",
            "type": "TEXT"
          },
          {
            "defaultValue": "",
            "displayName": "API Key",
            "name": "apiKey",
            "type": "TEXT"
          }
        ],
        "enablingConditions": [
          {
            "paramName": "enableMultipixelSetup",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "CHECKBOX",
        "name": "validateOnly",
        "checkboxText": "Validate only (does not save events)",
        "simpleValueType": true,
        "help": "Sends 'validate_only: true' in the request body. Use during testing."
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "event",
    "displayName": "Event",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "RADIO",
        "name": "eventName",
        "displayName": "Event Type",
        "radioItems": [
          {
            "value": "standard",
            "displayValue": "Standard"
          },
          {
            "value": "custom",
            "displayValue": "Custom"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "standard"
      },
      {
        "type": "SELECT",
        "name": "eventNameStandard",
        "displayName": "Standard Event",
        "selectItems": [
          { "value": "page_viewed", "displayValue": "page_viewed (contents)" },
          { "value": "contents_viewed", "displayValue": "contents_viewed (contents)" },
          { "value": "items_added", "displayValue": "items_added (contents)" },
          { "value": "checkout_started", "displayValue": "checkout_started (contents)" },
          { "value": "order_created", "displayValue": "order_created (contents)" },
          { "value": "lead_created", "displayValue": "lead_created (customer_action)" },
          { "value": "registration_completed", "displayValue": "registration_completed (customer_action)" },
          { "value": "appointment_scheduled", "displayValue": "appointment_scheduled (customer_action)" },
          { "value": "subscription_created", "displayValue": "subscription_created (plan_enrollment)" },
          { "value": "trial_started", "displayValue": "trial_started (plan_enrollment)" }
        ],
        "simpleValueType": true,
        "defaultValue": "order_created",
        "enablingConditions": [
          {
            "paramName": "eventName",
            "paramValue": "standard",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "eventNameCustom",
        "displayName": "Custom Event Type Value",
        "simpleValueType": true,
        "help": "Sent as the 'type' field. Use 'custom' for fully custom events.",
        "defaultValue": "custom",
        "enablingConditions": [
          {
            "paramName": "eventName",
            "paramValue": "custom",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "SELECT",
        "name": "actionSource",
        "displayName": "Action Source",
        "selectItems": [
          { "value": "web", "displayValue": "web" },
          { "value": "mobile_app", "displayValue": "mobile_app" },
          { "value": "offline", "displayValue": "offline" },
          { "value": "physical_store", "displayValue": "physical_store" },
          { "value": "phone_call", "displayValue": "phone_call" },
          { "value": "email", "displayValue": "email" },
          { "value": "other", "displayValue": "other" }
        ],
        "simpleValueType": true,
        "defaultValue": "web"
      },
      {
        "type": "TEXT",
        "name": "sourceUrlOverride",
        "displayName": "source_url Override",
        "simpleValueType": true,
        "help": "Defaults to event_data.page_location. Required when action_source is 'web'."
      },
      {
        "type": "CHECKBOX",
        "name": "optOut",
        "checkboxText": "Opt event out of user-level personalization",
        "simpleValueType": true,
        "help": "Sets 'opt_out: true' on the event."
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "userData",
    "displayName": "User Data",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "PARAM_TABLE",
        "name": "userList",
        "displayName": "User Fields",
        "paramTableColumns": [
          {
            "param": {
              "type": "TEXT",
              "name": "name",
              "displayName": "Field Name",
              "simpleValueType": true
            },
            "isUnique": true
          },
          {
            "param": {
              "type": "TEXT",
              "name": "value",
              "displayName": "Value",
              "simpleValueType": true
            },
            "isUnique": false
          }
        ],
        "help": "Top-level entries written under the event 'user' object. PII keys (email, phone, first_name, last_name, city, state, postal_code, country, external_id) are auto sha256-hashed unless already hashed."
      },
      {
        "type": "TEXT",
        "name": "userObject",
        "displayName": "User Object (advanced)",
        "simpleValueType": true,
        "help": "Pass a variable referencing an object to merge wholesale into 'user'."
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "eventDataGroup",
    "displayName": "Event Data Overrides",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "PARAM_TABLE",
        "name": "eventDataList",
        "displayName": "Custom Data Fields",
        "paramTableColumns": [
          {
            "param": {
              "type": "TEXT",
              "name": "name",
              "displayName": "Field Name",
              "simpleValueType": true
            },
            "isUnique": true
          },
          {
            "param": {
              "type": "TEXT",
              "name": "value",
              "displayName": "Value",
              "simpleValueType": true
            },
            "isUnique": false
          }
        ],
        "help": "Entries written under the event 'data' object (alongside 'type', 'amount', etc.)."
      },
      {
        "type": "TEXT",
        "name": "eventDataObject",
        "displayName": "Data Object (advanced)",
        "simpleValueType": true,
        "help": "Pass a variable referencing an object to merge wholesale into 'data'."
      },
      {
        "type": "PARAM_TABLE",
        "name": "serverEventDataList",
        "displayName": "Top-level Event Field Overrides",
        "paramTableColumns": [
          {
            "param": {
              "type": "SELECT",
              "name": "name",
              "displayName": "Field",
              "selectItems": [
                { "value": "id", "displayValue": "id" },
                { "value": "type", "displayValue": "type" },
                { "value": "timestamp_ms", "displayValue": "timestamp_ms" },
                { "value": "action_source", "displayValue": "action_source" },
                { "value": "source_url", "displayValue": "source_url" },
                { "value": "oppref", "displayValue": "oppref" },
                { "value": "opt_out", "displayValue": "opt_out" },
                { "value": "custom_event_name", "displayValue": "custom_event_name" }
              ],
              "simpleValueType": true
            },
            "isUnique": true
          },
          {
            "param": {
              "type": "TEXT",
              "name": "value",
              "displayName": "Value",
              "simpleValueType": true
            },
            "isUnique": false
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "itemIdKey",
        "displayName": "Item ID Key",
        "simpleValueType": true,
        "defaultValue": "item_id",
        "help": "Key on each items[] entry used as 'contents[].id' (e.g. 'item_id', 'sku', 'id')."
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "consent",
    "displayName": "Consent",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "RADIO",
        "name": "adStorageConsent",
        "displayName": "Ad Storage Consent",
        "radioItems": [
          {
            "value": "optional",
            "displayValue": "Send event regardless of consent state"
          },
          {
            "value": "required",
            "displayValue": "Require ad_storage consent (skip event if denied)"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "optional"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "cookies",
    "displayName": "Cookies",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "overrideCookieDomain",
        "checkboxText": "Override cookie domain",
        "simpleValueType": true
      },
      {
        "type": "TEXT",
        "name": "overridenCookieDomain",
        "displayName": "Cookie Domain",
        "simpleValueType": true,
        "defaultValue": "auto",
        "enablingConditions": [
          {
            "paramName": "overrideCookieDomain",
            "paramValue": true,
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "CHECKBOX",
        "name": "useHttpOnlyCookie",
        "checkboxText": "Set HttpOnly on __oppref cookie",
        "simpleValueType": true
      },
      {
        "type": "CHECKBOX",
        "name": "enableEventEnhancement",
        "checkboxText": "Enable event enhancement (_gtmeec cookie)",
        "simpleValueType": true,
        "help": "Persists hashed user fields in a first-party HttpOnly cookie so subsequent events can reuse them when the data layer is empty."
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "delivery",
    "displayName": "Delivery",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "useOptimisticScenario",
        "checkboxText": "Optimistic scenario (call gtmOnSuccess immediately)",
        "simpleValueType": true,
        "help": "Resolves the tag immediately without waiting for the API response. Useful when the next tag depends on this one completing fast."
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "logs",
    "displayName": "Logs",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "RADIO",
        "name": "logType",
        "displayName": "Console Logging",
        "radioItems": [
          { "value": "no", "displayValue": "Do not log" },
          { "value": "debug", "displayValue": "Log during debug & preview only" },
          { "value": "always", "displayValue": "Always log" }
        ],
        "simpleValueType": true,
        "defaultValue": "debug"
      },
      {
        "type": "RADIO",
        "name": "bigQueryLogType",
        "displayName": "BigQuery Logging",
        "radioItems": [
          { "value": "no", "displayValue": "Do not log to BigQuery" },
          { "value": "always", "displayValue": "Log to BigQuery" }
        ],
        "simpleValueType": true,
        "defaultValue": "no"
      },
      {
        "type": "TEXT",
        "name": "logBigQueryProjectId",
        "displayName": "BigQuery Project ID",
        "simpleValueType": true,
        "help": "Leave blank to use 'GOOGLE_CLOUD_PROJECT' from the server container.",
        "enablingConditions": [
          {
            "paramName": "bigQueryLogType",
            "paramValue": "always",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "logBigQueryDatasetId",
        "displayName": "BigQuery Dataset ID",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "enablingConditions": [
          {
            "paramName": "bigQueryLogType",
            "paramValue": "always",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "logBigQueryTableId",
        "displayName": "BigQuery Table ID",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "enablingConditions": [
          {
            "paramName": "bigQueryLogType",
            "paramValue": "always",
            "type": "EQUALS"
          }
        ]
      }
    ]
  }
]


___SANDBOXED_JS_FOR_SERVER___

const encodeUriComponent = require("encodeUriComponent");
const getAllEventData = require("getAllEventData");
const JSON = require("JSON");
const Math = require("Math");
const sendHttpRequest = require("sendHttpRequest");
const getTimestampMillis = require("getTimestampMillis");
const setCookie = require("setCookie");
const getCookieValues = require("getCookieValues");
const getContainerVersion = require("getContainerVersion");
const logToConsole = require("logToConsole");
const sha256Sync = require("sha256Sync");
const decodeUriComponent = require("decodeUriComponent");
const parseUrl = require("parseUrl");
const getRequestHeader = require("getRequestHeader");
const getType = require("getType");
const makeString = require("makeString");
const makeNumber = require("makeNumber");
const makeInteger = require("makeInteger");
const toBase64 = require("toBase64");
const fromBase64 = require("fromBase64");
const createRegex = require("createRegex");
const testRegex = require("testRegex");
const Promise = require("Promise");
const BigQuery = require("BigQuery");

/*==============================================================================
==============================================================================*/

const STANDARD_EVENTS = {
  page_viewed: "contents",
  contents_viewed: "contents",
  items_added: "contents",
  checkout_started: "contents",
  order_created: "contents",
  lead_created: "customer_action",
  registration_completed: "customer_action",
  appointment_scheduled: "customer_action",
  subscription_created: "plan_enrollment",
  trial_started: "plan_enrollment",
};

const HASH_KEYS = {
  email: "em",
  phone: "ph",
  first_name: "fn",
  last_name: "ln",
  city: "ct",
  state: "st",
  postal_code: "zp",
  country: "country",
  external_id: "external_id",
};

const traceId = getRequestHeader("trace-id");

const eventData = getAllEventData();

if (!isConsentGivenOrNotRequired()) {
  return data.gtmOnSuccess();
}

const url = eventData.page_location || getRequestHeader("referer");
if (url && url.lastIndexOf("https://gtm-msr.appspot.com/", 0) === 0) {
  return data.gtmOnSuccess();
}

const commonCookie = eventData.common_cookie || {};

let oppref =
  getCookieValues("__oppref")[0] ||
  commonCookie.__oppref ||
  eventData.__oppref ||
  eventData.oppref;

if (url && !oppref) {
  const urlParsed = parseUrl(url);
  if (urlParsed && urlParsed.searchParams && urlParsed.searchParams.oppref) {
    oppref = decodeUriComponent(urlParsed.searchParams.oppref);
  }
}

const cookieOptions = {
  domain: isUIFieldTrue(data.overrideCookieDomain)
    ? data.overridenCookieDomain || "auto"
    : "auto",
  path: "/",
  samesite: "Lax",
  secure: true,
  "max-age": 7776000, // 90 days
  HttpOnly: !!data.useHttpOnlyCookie,
};

if (oppref) {
  setCookie("__oppref", oppref, cookieOptions);
}

const mappedEvent = mapEvent(eventData, data);

if (data.enableEventEnhancement) {
  mappedEvent.user = enhanceUserData(mappedEvent.user || {});
  setGtmEecCookie(mappedEvent.user);
  if (objectKeys(mappedEvent.user).length === 0) mappedEvent.user = undefined;
}

let pixelsConfig = [
  {
    pixelId: data.pixelId,
    apiKey: data.apiKey,
  },
];
if (data.enableMultipixelSetup && data.pixelIdAndApiKeyTable) {
  pixelsConfig = pixelsConfig.concat(data.pixelIdAndApiKeyTable);
}

const requests = pixelsConfig.map((pixelConfig) => {
  const pixelId = pixelConfig.pixelId;
  const apiKey = pixelConfig.apiKey;
  const postUrl = "https://bzr.openai.com/v1/events?pid=" + enc(pixelId);

  const postBody = {
    validate_only: !!data.validateOnly,
    events: [mappedEvent],
  };

  log({
    Name: "OpenAI",
    Type: "Request",
    TraceId: traceId,
    EventName: mappedEvent.type,
    RequestMethod: "POST",
    RequestUrl: postUrl,
    RequestBody: postBody,
  });

  return sendHttpRequest(
    postUrl,
    {
      headers: {
        "content-type": "application/json",
        authorization: "Bearer " + apiKey,
      },
      method: "POST",
    },
    JSON.stringify(postBody),
  );
});

Promise.all(requests)
  .then((results) => {
    let someRequestFailed = false;

    results.forEach((result) => {
      log({
        Name: "OpenAI",
        Type: "Response",
        TraceId: traceId,
        EventName: mappedEvent.type,
        ResponseStatusCode: result.statusCode,
        ResponseHeaders: result.headers,
        ResponseBody: result.body,
      });

      if (result.statusCode < 200 || result.statusCode >= 300) {
        someRequestFailed = true;
      }
    });

    if (!data.useOptimisticScenario) {
      if (someRequestFailed) data.gtmOnFailure();
      else data.gtmOnSuccess();
    }
  })
  .catch((result) => {
    log({
      Name: "OpenAI",
      Type: "Response",
      TraceId: traceId,
      EventName: mappedEvent.type,
      Message: "Some request failed or timed out.",
      Reason: JSON.stringify(result),
    });

    if (!data.useOptimisticScenario) data.gtmOnFailure();
  });

if (data.useOptimisticScenario) {
  data.gtmOnSuccess();
}

/*==============================================================================
  Vendor related functions
==============================================================================*/

function getEventName(data) {
  if (data.eventName === "standard") return data.eventNameStandard;
  return data.eventNameCustom || "custom";
}

function getDataType(eventName) {
  return STANDARD_EVENTS[eventName] || "custom";
}

function getEventId(eventData) {
  if (eventData.event_id) return makeString(eventData.event_id);
  if (eventData.transaction_id) return makeString(eventData.transaction_id);
  return undefined;
}

function mapEvent(eventData, data) {
  const eventName = getEventName(data);
  const dataType = getDataType(eventName);

  let mapped = {
    id: getEventId(eventData),
    type: eventName,
    timestamp_ms: getTimestampMillis(),
    action_source: data.actionSource || "web",
    data: { type: dataType },
    user: {},
  };

  if (eventName === "custom" && eventData.custom_event_name) {
    mapped.custom_event_name = eventData.custom_event_name;
  }

  if (oppref) mapped.oppref = oppref;

  if (mapped.action_source === "web") {
    const sourceUrl =
      data.sourceUrlOverride || eventData.page_location || url;
    if (sourceUrl) mapped.source_url = sourceUrl;
  }

  if (data.optOut === true || data.optOut === "true") mapped.opt_out = true;

  mapped = addEventData(eventData, mapped, dataType);
  mapped = addUserData(eventData, mapped);
  mapped = overrideDataIfNeeded(mapped);
  mapped = cleanupData(mapped);
  mapped = hashUserDataIfNeeded(mapped);

  if (!mapped.id) mapped.id = generateFallbackId(mapped);

  return mapped;
}

function addEventData(eventData, mapped, dataType) {
  const d = mapped.data;

  if (dataType === "contents") {
    addContentsData(eventData, d);
  } else if (dataType === "customer_action") {
    addAmountCurrency(eventData, d);
  } else if (dataType === "plan_enrollment") {
    addAmountCurrency(eventData, d);
    if (eventData.plan_id) d.plan_id = eventData.plan_id;
    else if (eventData.subscription_id) d.plan_id = eventData.subscription_id;
    else if (eventData.item_id) d.plan_id = eventData.item_id;
  } else {
    addAmountCurrency(eventData, d);
    if (eventData.plan_id) d.plan_id = eventData.plan_id;
  }

  return mapped;
}

function addContentsData(eventData, d) {
  let currencyFromItems = "";
  let amountFromItems = 0;
  const itemIdKey = data.itemIdKey || "item_id";

  if (eventData.items && eventData.items[0]) {
    d.contents = [];
    currencyFromItems = eventData.items[0].currency;

    eventData.items.forEach((item) => {
      const content = {};
      if (item[itemIdKey]) content.id = makeString(item[itemIdKey]);
      if (item.item_name) content.name = item.item_name;
      content.content_type = item.content_type || "product";
      if (item.quantity) content.quantity = makeInteger(item.quantity);
      if (item.price) {
        const itemAmount = toAmount(item.price);
        content.amount = itemAmount;
        if (item.currency) content.currency = item.currency;
        amountFromItems += item.quantity
          ? makeInteger(item.quantity) * itemAmount
          : itemAmount;
      }
      d.contents.push(content);
    });
  }

  addAmountCurrency(eventData, d);
  if (!d.amount && amountFromItems) d.amount = amountFromItems;
  if (!d.currency && currencyFromItems) d.currency = currencyFromItems;
}

function addAmountCurrency(eventData, d) {
  const rawAmount =
    eventData.amount !== undefined
      ? eventData.amount
      : eventData["x-ga-mp1-ev"] !== undefined
        ? eventData["x-ga-mp1-ev"]
        : eventData["x-ga-mp1-tr"] !== undefined
          ? eventData["x-ga-mp1-tr"]
          : eventData.value;

  if (rawAmount !== undefined && rawAmount !== null && rawAmount !== "") {
    d.amount = toAmount(rawAmount);
  }
  if (eventData.currency) d.currency = eventData.currency;
}

// OpenAI uses integer minor-currency-unit values (e.g. 2599 = $25.99).
// If the inbound value looks like a decimal (e.g. 25.99), convert to cents.
function toAmount(v) {
  const n = makeNumber(v);
  if (n !== n) return 0; // NaN guard
  if (Math.floor(n) === n) return makeInteger(n);
  return makeInteger(Math.round(n * 100));
}

function addUserData(eventData, mapped) {
  let user_data = {};
  let address = {};
  if (getType(eventData.user_data) === "object") {
    user_data = eventData.user_data;
    const addressType = getType(user_data.address);
    if (addressType === "object" || addressType === "array") {
      address = user_data.address[0] || user_data.address;
    }
  }

  if (eventData.email) mapped.user.email = eventData.email;
  else if (user_data.email_address) mapped.user.email = user_data.email_address;
  else if (user_data.email) mapped.user.email = user_data.email;
  else if (user_data.sha256_email_address)
    mapped.user.email = user_data.sha256_email_address;

  if (eventData.phone) mapped.user.phone = eventData.phone;
  else if (user_data.phone_number) mapped.user.phone = user_data.phone_number;

  if (eventData.firstName) mapped.user.first_name = eventData.firstName;
  else if (eventData.first_name) mapped.user.first_name = eventData.first_name;
  else if (user_data.first_name) mapped.user.first_name = user_data.first_name;
  else if (address.first_name) mapped.user.first_name = address.first_name;

  if (eventData.lastName) mapped.user.last_name = eventData.lastName;
  else if (eventData.last_name) mapped.user.last_name = eventData.last_name;
  else if (user_data.last_name) mapped.user.last_name = user_data.last_name;
  else if (address.last_name) mapped.user.last_name = address.last_name;

  if (eventData.external_id)
    mapped.user.external_id = makeString(eventData.external_id);
  else if (eventData.user_id)
    mapped.user.external_id = makeString(eventData.user_id);
  else if (eventData.userId)
    mapped.user.external_id = makeString(eventData.userId);

  if (eventData.ip_override) {
    mapped.user.client_ip_address = eventData.ip_override
      .split(" ")
      .join("")
      .split(",")[0];
  }
  if (eventData.user_agent)
    mapped.user.client_user_agent = eventData.user_agent;

  if (eventData.city) mapped.user.city = eventData.city;
  else if (address.city) mapped.user.city = address.city;

  if (eventData.state) mapped.user.state = eventData.state;
  else if (eventData.region) mapped.user.state = eventData.region;
  else if (address.region) mapped.user.state = address.region;

  if (eventData.zip) mapped.user.postal_code = eventData.zip;
  else if (eventData.postal_code) mapped.user.postal_code = eventData.postal_code;
  else if (address.postal_code) mapped.user.postal_code = address.postal_code;

  if (eventData.country) mapped.user.country = eventData.country;
  else if (eventData.countryCode) mapped.user.country = eventData.countryCode;
  else if (address.country) mapped.user.country = address.country;

  return mapped;
}

function overrideDataIfNeeded(mapped) {
  if (getType(data.userObject) === "object") {
    mergeObj(mapped.user, data.userObject);
  }
  if (data.userList) {
    data.userList.forEach((d) => {
      mapped.user[d.name] = d.value;
    });
  }

  if (getType(data.eventDataObject) === "object") {
    mergeObj(mapped.data, data.eventDataObject);
  }
  if (data.eventDataList) {
    data.eventDataList.forEach((d) => {
      mapped.data[d.name] = d.value;
    });
  }

  if (data.serverEventDataList) {
    data.serverEventDataList.forEach((d) => {
      if (
        d.name === "id" ||
        d.name === "type" ||
        d.name === "timestamp_ms" ||
        d.name === "action_source" ||
        d.name === "source_url" ||
        d.name === "oppref" ||
        d.name === "opt_out" ||
        d.name === "custom_event_name"
      ) {
        mapped[d.name] = d.value;
      }
    });
  }

  return mapped;
}

function cleanupData(mapped) {
  if (mapped.user) {
    const user = {};
    for (const k in mapped.user) {
      if (isValidValue(mapped.user[k])) user[k] = mapped.user[k];
    }
    mapped.user = objectKeys(user).length === 0 ? undefined : user;
  }

  if (mapped.data) {
    const d = {};
    for (const k in mapped.data) {
      if (isValidValue(mapped.data[k])) d[k] = mapped.data[k];
    }
    mapped.data = d;
  }

  return mapped;
}

function hashUserDataIfNeeded(mapped) {
  if (!mapped.user) return mapped;
  for (const key in mapped.user) {
    if (HASH_KEYS[key]) {
      mapped.user[key] = hashData(key, mapped.user[key]);
    }
  }
  return mapped;
}

function hashData(key, value) {
  if (!value) return value;

  const type = getType(value);
  if (type === "undefined" || value === "undefined") return undefined;
  if (type === "array") return value.map((v) => hashData(key, v));
  if (isHashed(value)) return value;

  let v = makeString(value).trim().toLowerCase();
  if (key === "phone") v = normalizePhoneNumber(v);
  else if (key === "city") v = v.split(" ").join("");

  return sha256Sync(v, { outputEncoding: "hex" });
}

function generateFallbackId(mapped) {
  return (
    mapped.type +
    "_" +
    makeString(getTimestampMillis()) +
    "_" +
    makeString(eventData.engagement_time_msec || "0")
  );
}

/*==============================================================================
  Event enhancement (mirrors Meta CAPI _gtmeec pattern)
==============================================================================*/

function setGtmEecCookie(user) {
  const eec = {};
  for (const k in user) {
    if (HASH_KEYS[k] && user[k]) eec[k] = user[k];
  }
  if (objectKeys(eec).length === 0) return;

  setCookie("_gtmeec", toBase64(JSON.stringify(eec)), {
    domain: isUIFieldTrue(data.overrideCookieDomain)
      ? data.overridenCookieDomain || "auto"
      : "auto",
    path: "/",
    samesite: "strict",
    secure: true,
    "max-age": 7776000, // 90 days
    HttpOnly: true,
  });
}

function enhanceUserData(user) {
  const cookieValues = getCookieValues("_gtmeec");
  const encoded =
    (cookieValues && cookieValues[0]) || commonCookie._gtmeec;
  if (!encoded) return user;

  const jsonStr = fromBase64(encoded);
  if (!jsonStr) return user;

  const eec = JSON.parse(jsonStr);
  if (!eec) return user;

  for (const k in HASH_KEYS) {
    if (!user[k] && eec[k]) user[k] = eec[k];
  }
  return user;
}

/*==============================================================================
  Helpers
==============================================================================*/

function enc(value) {
  return encodeUriComponent(value || "");
}

function isHashed(value) {
  if (!value) return false;
  return makeString(value).match("^[A-Fa-f0-9]{64}$") !== null;
}

function isValidValue(value) {
  const t = getType(value);
  return t !== "null" && t !== "undefined" && value !== "";
}

function normalizePhoneNumber(phoneNumber) {
  if (!phoneNumber) return phoneNumber;
  const itemRegex = createRegex("^[0-9]$");
  return phoneNumber
    .split("")
    .filter((item) => testRegex(itemRegex, item))
    .join("");
}

function isUIFieldTrue(field) {
  return [true, "true"].indexOf(field) !== -1;
}

function mergeObj(target, source) {
  for (const key in source) {
    if (source.hasOwnProperty(key)) target[key] = source[key];
  }
  return target;
}

function objectKeys(obj) {
  const keys = [];
  for (const k in obj) {
    if (obj.hasOwnProperty(k)) keys.push(k);
  }
  return keys;
}

function isConsentGivenOrNotRequired() {
  if (data.adStorageConsent !== "required") return true;
  if (eventData.consent_state) return !!eventData.consent_state.ad_storage;
  const xGaGcs = eventData["x-ga-gcs"] || "";
  return xGaGcs[2] === "1";
}

/*==============================================================================
  Logging
==============================================================================*/

function log(rawDataToLog) {
  const handlers = {};
  if (determinateIsLoggingEnabled()) handlers.console = logConsole;
  if (determinateIsLoggingEnabledForBigQuery()) handlers.bigQuery = logToBigQuery;

  const keyMappings = {
    bigQuery: {
      Name: "tag_name",
      Type: "type",
      TraceId: "trace_id",
      EventName: "event_name",
      RequestMethod: "request_method",
      RequestUrl: "request_url",
      RequestBody: "request_body",
      ResponseStatusCode: "response_status_code",
      ResponseHeaders: "response_headers",
      ResponseBody: "response_body",
    },
  };

  for (const dest in handlers) {
    const handler = handlers[dest];
    if (!handler) continue;

    const mapping = keyMappings[dest];
    const dataToLog = mapping ? {} : rawDataToLog;

    if (mapping) {
      for (const key in rawDataToLog) {
        const mappedKey = mapping[key] || key;
        dataToLog[mappedKey] = rawDataToLog[key];
      }
    }

    handler(dataToLog);
  }
}

function logConsole(dataToLog) {
  logToConsole(JSON.stringify(dataToLog));
}

function logToBigQuery(dataToLog) {
  const connectionInfo = {
    projectId: data.logBigQueryProjectId,
    datasetId: data.logBigQueryDatasetId,
    tableId: data.logBigQueryTableId,
  };

  dataToLog.timestamp = getTimestampMillis();

  ["request_body", "response_headers", "response_body"].forEach((p) => {
    dataToLog[p] = JSON.stringify(dataToLog[p]);
  });

  BigQuery.insert(connectionInfo, [dataToLog], { ignoreUnknownValues: true });
}

function determinateIsLoggingEnabled() {
  const containerVersion = getContainerVersion();
  const isDebug = !!(
    containerVersion &&
    (containerVersion.debugMode || containerVersion.previewMode)
  );

  if (!data.logType) return isDebug;
  if (data.logType === "no") return false;
  if (data.logType === "debug") return isDebug;
  return data.logType === "always";
}

function determinateIsLoggingEnabledForBigQuery() {
  if (data.bigQueryLogType === "no") return false;
  return data.bigQueryLogType === "always";
}


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "all"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_container_data",
        "versionId": "1"
      },
      "param": []
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "send_http",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://bzr.openai.com/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "__oppref"
              },
              {
                "type": 1,
                "string": "_gtmeec"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "set_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedCookies",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "__oppref"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "_gtmeec"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_event_data",
        "versionId": "1"
      },
      "param": [
        {
          "key": "eventDataAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_request",
        "versionId": "1"
      },
      "param": [
        {
          "key": "headerWhitelist",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "trace-id"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "referer"
                  }
                ]
              }
            ]
          }
        },
        {
          "key": "headersAllowed",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "requestAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "headerAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "queryParameterAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_bigquery",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedTables",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "projectId"
                  },
                  {
                    "type": 1,
                    "string": "datasetId"
                  },
                  {
                    "type": 1,
                    "string": "tableId"
                  },
                  {
                    "type": 1,
                    "string": "operation"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Standard event sends POST to OpenAI with Bearer auth and correct body
  code: |-
    const JSON = require('JSON');
    const mockData = {
      pixelId: 'test-pixel-id',
      apiKey: 'test-api-key',
      eventName: 'standard',
      eventNameStandard: 'order_created',
      actionSource: 'web',
      adStorageConsent: 'optional',
    };

    let capturedUrl;
    let capturedHeaders;
    let capturedBody;

    mock('getAllEventData', function() {
      return {
        page_location: 'https://example.com/checkout/done',
        transaction_id: 'tx_123',
        value: 25.99,
        currency: 'USD',
      };
    });

    mock('getCookieValues', function() { return []; });

    mock('sendHttpRequest', function(url, options, body) {
      capturedUrl = url;
      capturedHeaders = options.headers;
      capturedBody = JSON.parse(body);
      return {
        then: function(cb) { cb({statusCode: 200, headers: {}, body: '{}'}); return {catch: function() {}}; }
      };
    });

    runCode(mockData);

    assertThat(capturedUrl).contains('test-pixel-id');
    assertThat(capturedUrl).contains('https://bzr.openai.com/v1/events');
    assertThat(capturedHeaders.authorization).isEqualTo('Bearer test-api-key');
    assertThat(capturedBody.events[0].type).isEqualTo('order_created');
    assertThat(capturedBody.events[0].data.type).isEqualTo('contents');
    assertThat(capturedBody.events[0].id).isEqualTo('tx_123');
    assertThat(capturedBody.events[0].source_url).isEqualTo('https://example.com/checkout/done');
    assertThat(capturedBody.events[0].data.amount).isEqualTo(2599);
    assertThat(capturedBody.events[0].data.currency).isEqualTo('USD');

- name: Custom event sends type=custom with custom_event_name from event data
  code: |-
    const JSON = require('JSON');
    const mockData = {
      pixelId: 'pid',
      apiKey: 'key',
      eventName: 'custom',
      eventNameCustom: 'custom',
      actionSource: 'web',
      adStorageConsent: 'optional',
    };

    let capturedBody;

    mock('getAllEventData', function() {
      return {
        page_location: 'https://example.com',
        event_id: 'evt_42',
        custom_event_name: 'quote_requested',
      };
    });
    mock('getCookieValues', function() { return []; });
    mock('sendHttpRequest', function(url, options, body) {
      capturedBody = JSON.parse(body);
      return { then: function(cb) { cb({statusCode: 200, headers: {}, body: '{}'}); return {catch: function() {}}; } };
    });

    runCode(mockData);

    assertThat(capturedBody.events[0].type).isEqualTo('custom');
    assertThat(capturedBody.events[0].custom_event_name).isEqualTo('quote_requested');
    assertThat(capturedBody.events[0].id).isEqualTo('evt_42');
    assertThat(capturedBody.events[0].data.type).isEqualTo('custom');

- name: validate_only flag propagates to request body
  code: |-
    const JSON = require('JSON');
    const mockData = {
      pixelId: 'pid',
      apiKey: 'key',
      eventName: 'standard',
      eventNameStandard: 'page_viewed',
      validateOnly: true,
      actionSource: 'web',
      adStorageConsent: 'optional',
    };

    let capturedBody;

    mock('getAllEventData', function() { return { page_location: 'https://example.com' }; });
    mock('getCookieValues', function() { return []; });
    mock('sendHttpRequest', function(url, options, body) {
      capturedBody = JSON.parse(body);
      return { then: function(cb) { cb({statusCode: 200, headers: {}, body: '{}'}); return {catch: function() {}}; } };
    });

    runCode(mockData);

    assertThat(capturedBody.validate_only).isTrue();

- name: Consent denied skips send and resolves successfully
  code: |-
    const JSON = require('JSON');
    const mockData = {
      pixelId: 'pid',
      apiKey: 'key',
      eventName: 'standard',
      eventNameStandard: 'order_created',
      adStorageConsent: 'required',
    };

    mock('getAllEventData', function() {
      return {
        page_location: 'https://example.com',
        consent_state: { ad_storage: false },
      };
    });
    mock('getCookieValues', function() { return []; });
    mock('sendHttpRequest', function() { fail('sendHttpRequest should not be called when consent denied'); });

    runCode(mockData);

    assertApi('sendHttpRequest').wasNotCalled();
    assertApi('gtmOnSuccess').wasCalled();

- name: oppref read from __oppref cookie is included in event payload
  code: |-
    const JSON = require('JSON');
    const mockData = {
      pixelId: 'pid',
      apiKey: 'key',
      eventName: 'standard',
      eventNameStandard: 'order_created',
      actionSource: 'web',
      adStorageConsent: 'optional',
    };

    let capturedBody;

    mock('getAllEventData', function() { return { page_location: 'https://example.com' }; });
    mock('getCookieValues', function(name) {
      if (name === '__oppref') return ['oppref_abc123'];
      return [];
    });
    mock('sendHttpRequest', function(url, options, body) {
      capturedBody = JSON.parse(body);
      return { then: function(cb) { cb({statusCode: 200, headers: {}, body: '{}'}); return {catch: function() {}}; } };
    });

    runCode(mockData);

    assertThat(capturedBody.events[0].oppref).isEqualTo('oppref_abc123');

- name: Items array maps to contents with integer amounts
  code: |-
    const JSON = require('JSON');
    const mockData = {
      pixelId: 'pid',
      apiKey: 'key',
      eventName: 'standard',
      eventNameStandard: 'order_created',
      actionSource: 'web',
      adStorageConsent: 'optional',
      itemIdKey: 'item_id',
    };

    let capturedBody;

    mock('getAllEventData', function() {
      return {
        page_location: 'https://example.com',
        transaction_id: 'tx_99',
        currency: 'USD',
        items: [
          { item_id: 'sku_1', item_name: 'Bundle', quantity: 2, price: 25.99 },
          { item_id: 'sku_2', item_name: 'Addon', quantity: 1, price: 9.5 },
        ],
      };
    });
    mock('getCookieValues', function() { return []; });
    mock('sendHttpRequest', function(url, options, body) {
      capturedBody = JSON.parse(body);
      return { then: function(cb) { cb({statusCode: 200, headers: {}, body: '{}'}); return {catch: function() {}}; } };
    });

    runCode(mockData);

    const contents = capturedBody.events[0].data.contents;
    assertThat(contents).hasLength(2);
    assertThat(contents[0].id).isEqualTo('sku_1');
    assertThat(contents[0].amount).isEqualTo(2599);
    assertThat(contents[0].quantity).isEqualTo(2);
    assertThat(contents[1].amount).isEqualTo(950);
    // Aggregated amount: 2*2599 + 1*950 = 6148
    assertThat(capturedBody.events[0].data.amount).isEqualTo(6148);

- name: PII fields are sha256-hashed before send
  code: |-
    const JSON = require('JSON');
    const mockData = {
      pixelId: 'pid',
      apiKey: 'key',
      eventName: 'standard',
      eventNameStandard: 'order_created',
      actionSource: 'web',
      adStorageConsent: 'optional',
    };

    let capturedBody;

    mock('getAllEventData', function() {
      return {
        page_location: 'https://example.com',
        email: 'Test@Example.com',
        phone: '+1 (415) 555-0100',
      };
    });
    mock('getCookieValues', function() { return []; });
    mock('sendHttpRequest', function(url, options, body) {
      capturedBody = JSON.parse(body);
      return { then: function(cb) { cb({statusCode: 200, headers: {}, body: '{}'}); return {catch: function() {}}; } };
    });

    runCode(mockData);

    const user = capturedBody.events[0].user;
    // sha256("test@example.com")
    assertThat(user.email).isEqualTo('973dfe463ec85785f5f95af5ba3906eedb2d931c24e69824a89ea65dba4e813b');
    // sha256("14155550100")
    assertThat(user.phone).isEqualTo('5e7ec4c79ccac6e420876e65ad0e6b4b2ccf73ec3dccb50297bf2890a1ec73b9');


___NOTES___

# OpenAI Conversions API — Server-side GTM Tag Template

Sends conversion events to https://bzr.openai.com/v1/events. Designed to feel familiar to anyone using the Meta CAPI server-side template (Stape pattern).

## Setup

1. Obtain a Pixel ID and Conversions API key from the Conversions tab in OpenAI Ads Manager.
2. Configure the Pixel SDK on the browser side per https://developers.openai.com/ads — it will set the `__oppref` first-party cookie which this tag reads automatically.
3. In your server-side container, create a tag from this template, plug in the Pixel ID + API key, point it at a GA4-style data layer event, and you are done.

## Event mapping

The tag auto-derives `data.type` from the event name:

| Event name | data.type |
| --- | --- |
| page_viewed, contents_viewed, items_added, checkout_started, order_created | contents |
| lead_created, registration_completed, appointment_scheduled | customer_action |
| subscription_created, trial_started | plan_enrollment |
| custom | custom |

## Deduplication

To dedupe browser pixel and server events, ensure the same `event_id` (browser) and `id` (server) are used. The tag pulls `id` from `event_data.event_id` first, then `transaction_id`. For custom events, also keep `custom_event_name` consistent on both sides — set it on `event_data.custom_event_name`, or override via the "Top-level Event Field Overrides" table.

## oppref

The `__oppref` first-party cookie set by the OpenAI Pixel SDK is read automatically. The tag also falls back to `event_data.__oppref`, `event_data.oppref`, or an `?oppref=` URL parameter, and persists the discovered value back to a 90-day cookie.

## Amount values

OpenAI expects integer minor-currency-unit values (e.g. 2599 for $25.99). The tag converts decimals automatically when it detects them.

## PII hashing

These keys are sha256-hashed before being sent: email, phone, first_name, last_name, city, state, postal_code, country, external_id. Already-hashed values (64-char hex) are passed through. Phones are normalized to digits; cities are de-spaced.
