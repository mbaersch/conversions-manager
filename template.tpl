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
    "CONVERSIONS",
    "UTILITY"
  ],
  "brand": {
    "id": "github.com_mbaersch",
    "displayName": "mbaersch",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAMAAADXqc3KAAAAb1BMVEUAAADT09PKysrX19fZ2dliYmLy8vKPj4+ysrKBgYHv7+9lZWV0dHSEhIRoaGiKiorn5+dra2vt7e2kpKTa2tq7u7u3t7ebm5uYmJiVlZV+fn54eHhubm7h4eHb29vT09PNzc3Hx8fBwcGpqalzc3PgukEeAAAABXRSTlMAjspxYsZNnOwAAAClSURBVCjPrZBZEoIwEEQj2iYQsgGyu3v/M0qiGVS+rOL9zbyp6q5h61NyYvslUhCClpvXvPdk4SKPQo5yFtrNIrfpJLKj9UJco2BOXqa5UJDCiwbmLQxUD1FpQE2i1TjEeO3DiwEoQ7iiXon0rYrbObQa2AcP8NDKuhAws5O68qKMjQgDV9tTBwomFDzyzhYkPWT3s6MPsH9EyxW04fVCjAg0bHWeA7MIlinpEToAAAAASUVORK5CYII\u003d"
  },
  "description": "Push conversion / event data to dataLayer for triggering different tags with centralized conversion rule set. Enables using one tag per service for multiple conversions or events.",
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
    "defaultValue": "managedConversionEvent",
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
        "displayName": "Add at least one conversion rule and add conversion data to be pushed to the dataLayer along with the defined conversion event name. NOTE: you can use a Google Spreadsheet to edit this table. Find a link at https://github.com/mbaersch/conversions-manager/#readme.",
        "paramTableColumns": [
          {
            "param": {
              "type": "TEXT",
              "name": "pattern",
              "displayName": "Conversion rule",
              "simpleValueType": true,
              "help": "Use partial match (default): Enter a string that has to be contained in the URL (including parameters) for creating a dataLayer event. You can split multiple patterns with a \"|\" when using this default mode without any prefix. \n\nNote: You can use the prefix \"uc:\" for \"URL contains\" if you want all rules  to use the same structure. \n\nRegEx: To use regular expressions with URL, use \"re:\" or \"ur:\" as prefix (example: \"re:something_.*\\.html$\")\n\nEquals: Use \"ue:\" to define a pattern that has to completely match the current URL. \n\nTo compare with events name instead of URL: Use prefix \"ec:\" to compare with the current event name (\"event contains\"), \"ee:\" for \"event equals\" or \"er:\" for \"event matches regex\"."
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
              "displayName": "Value",
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
              "help": "add optional parameters as string or valid JSON here. The tag will try to parse and add data as an array / object to the dataLayer event if a value is present. If it cannot be parsed as JSON, it will remain a string value."
            },
            "isUnique": false
          }
        ]
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "grpAdvanced",
    "displayName": "Advanced Options",
    "groupStyle": "ZIPPY_OPEN_ON_PARAM",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "enableCustomInput",
        "checkboxText": "Enable custom rule input",
        "simpleValueType": true,
        "defaultValue": false,
        "help": "Optionally define a custom value to use in a rule. If active and a \"Custom value\" is set, you can use the prefix \"ce:\" in a rule to look for a custom value that is identical with the rule pattern (\"equals\"). \"cc:\" finds a partial match (\"contains\") and \"cr:\" allows you to use a regex for the custom value."
      },
      {
        "type": "TEXT",
        "name": "customInput",
        "displayName": "Custom value",
        "simpleValueType": true,
        "help": "Enter a variable or multiple variables as a value to compare to (instead of URL or event name) in rules with \"ce:\", \"cc:\", or \"cr:\" prefix. You can access single keys from an object, with \"pe:\", \"pc:\", or \"pr:\", too. See documentation at https://github.com/mbaersch/conversions-manager/#readme for more details and examples.",
        "enablingConditions": [
          {
            "paramName": "enableCustomInput",
            "paramValue": true,
            "type": "EQUALS"
          }
        ],
        "valueValidators": [
          {
            "type": "NON_EMPTY"
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
  let currentConversions = data.conversionData.filter(function(x) {
    if (!x.pattern) return false;
    let cinput = "", ckeyval;
    let haystack =  url;
    let needle = x.pattern;
    let method = "contains";
    if (data.enableCustomInput === true && data.customInput) {
      cinput =  data.customInput;
      if ((needle.slice(0,1) == "p") && (needle.slice(2,3) == ":")) {
        //format for path search, example pageTitle (from custom) contains "404": pc:pageTitle:404
        var needleParts = needle.split(":");
        var ckey = needleParts[1];
        if (ckey != undefined) {
          if (typeof(cinput) === "string") cinput = JSON.parse(cinput); 
          ckeyval = (cinput||{})[ckey];
          needle = needleParts[0] + ":" + needleParts[2];
        }
      }
    }
    
    if (needle.slice(2,3) == ":") {
      let type = needle.slice(0,2);
      if (type === "ue") method = "equals"; else
      if ((type === "re") || (type === "ur")) method = "regex"; else
      if (type === "ee") { haystack = event_name; method = "equals"; } else 
      if (type === "er") { haystack = event_name; method = "regex"; } else 
      if (type === "ec") haystack = event_name; else 
      if (type === "ce")  { haystack = cinput; method = "equals"; } else
      if (type === "cr")  { haystack = cinput; method = "regex"; } else
      if (type === "cc")  haystack = cinput; else
      if (ckeyval) {  
        if (type === "pe") { haystack = ckeyval; method = "equals"; } else 
        if (type === "pr") { haystack = ckeyval; method = "regex"; } else 
        if (type === "pc") haystack = ckeyval;
      }
      needle = needle.slice(3);
    }
    
    let match = false;
    if (method === "regex") {
      match = haystack.match(needle);
    } else if (method === "equals") {
      match = haystack === needle;
    } else {
      //find matching strings 
      let pt = needle.split("|");
      pt.forEach(function(y){
        if (y && y != "") match = match || haystack.indexOf(y) >= 0;
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


