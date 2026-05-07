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


const logToConsole = require("logToConsole");
logToConsole("hello");
data.gtmOnSuccess();


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


