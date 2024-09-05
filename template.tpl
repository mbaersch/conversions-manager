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
  "displayName": "Conversions Manager",
  "categories": [
    "UTILITY"
  ],
  "brand": {
    "id": "mbaersch",
    "displayName": "mbaersch"
  },
  "description": "push conversion data to dataLayer for triggering different tags with simple and centralized page url rules. Enables you to use one conversion tag per service for multiple conversions.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "eventName",
    "displayName": "Event name",
    "simpleValueType": true,
    "help": "Enter a name for the dataLayer event that will be pushed along with all conversion data",
    "alwaysInSummary": true,
    "defaultValue": "pageConversionEvent",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "placeholder",
    "displayName": "Empty value placeholder",
    "simpleValueType": true,
    "help": "It is recommended to add a unique string as a placeholder instead of using \"undefined\" for all unset string parameters. This helps to build more robust triggers.",
    "alwaysInSummary": false,
    "defaultValue": "NONE",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "grpConversionData",
    "displayName": "Conversion data",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "PARAM_TABLE",
        "name": "conversionData",
        "displayName": "Add at least one conversion pattern and add conversion data to be pushed to the dataLayer along with the defined conversion event name.",
        "paramTableColumns": [
          {
            "param": {
              "type": "TEXT",
              "name": "pattern",
              "displayName": "Trigger pattern",
              "simpleValueType": true,
              "help": "Use partial match (default): Enter a string that has to be contained in the URL (including for creating a dataLayer event. Split multiple patterns with a \"|\". \n\nRegEx: To use regular expressions, use \"re:\" as prefix (example: \"re:something_.*\\.html$\")\n\nEvents: Use prefix \"ev:\" to compare with the current event name (case sensitive, partial match)"
            },
            "isUnique": false
          },
          {
            "param": {
              "type": "TEXT",
              "name": "name",
              "displayName": "Event name",
              "simpleValueType": true
            },
            "isUnique": false
          },
          {
            "param": {
              "type": "TEXT",
              "name": "value",
              "displayName": "Conversion value",
              "simpleValueType": true,
              "defaultValue": 0,
              "valueValidators": [
                {
                  "type": "NON_NEGATIVE_NUMBER"
                }
              ]
            },
            "isUnique": false
          },
          {
            "param": {
              "type": "TEXT",
              "name": "ads_label",
              "displayName": "Conversion label",
              "simpleValueType": true
            },
            "isUnique": false
          },
          {
            "param": {
              "type": "TEXT",
              "name": "custom",
              "displayName": "Custom data",
              "simpleValueType": true,
              "lineCount": 10,
              "help": "add optional parameters as string or valid JSON here. The tag will try parse data and add it as an array / object to the dataLayer event if a value is present. If it cannot be parsed as JSON, it will remain a string value."
            },
            "isUnique": false
          }
        ]
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const dataLayerPush = require('createQueue')('dataLayer');
const event_name = require('copyFromDataLayer')('event');
const makeNumber = require('makeNumber');
const JSON = require('JSON');
const url = require("getUrl")();

if (data.conversionData) {
  var currentConversions = data.conversionData.filter(function(x) {
    if (!x.pattern) return false;
    var match = false;
    if (x.pattern.slice(0,3) === "re:") {
      //use regex
      match = url.match(x.pattern.slice(3));
    } else if (x.pattern.slice(0,3) === "ev:") {
      //use event name
      match = event_name.indexOf(x.pattern.slice(3)) >= 0;
    } else {
      //find matching strings 
      var pt = x.pattern.split("|");
      pt.forEach(function(y){
        if (y && y != "") match = match || url.indexOf(y) >= 0;
      });
    }  
    return match;
  });
  
  if (currentConversions && currentConversions.length > 0) {
    currentConversions.forEach(function(x){
      let customData = x.custom ? JSON.parse(x.custom)||x.custom : undefined;
      let dlEvent = {
        event: data.eventName||"pageConversionEvent", 
          conversionInfo: {
            name: x.name||data.placeholder,
            value: makeNumber(x.value||0),
            ads_label: x.ads_label||data.placeholder,
            custom: customData||data.placeholder
          }
        };
      //require("logToConsole")(dlEvent);
      dataLayerPush(dlEvent);
    });
  }  
}

data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "dataLayer"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
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
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
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
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "event"
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

scenarios: []


___NOTES___

Created on 6.9.2024, 00:11:43
