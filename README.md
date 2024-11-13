# Conversions Manager

**Create (conversion) event pushes to dataLayer depending on URLs (Custom Tag Template for Google Tag Manager)**

[![Template Status](https://img.shields.io/badge/Community%20Template%20Gallery%20Status-published-green)](https://tagmanager.google.com/gallery/#/owners/mbaersch/templates/conversions-manager) ![Repo Size](https://img.shields.io/github/repo-size/mbaersch/conversions-manager) ![License](https://img.shields.io/github/license/mbaersch/conversions-manager)

## Why this template? 
If you only track a single type of conversion like a purchase for a few services, this tag might not be for you. But when there are multiple conversions or other events, depending on different dataLayer events and / or URLs, and several services like Google Ads, Google Analytics, Meta, Pinterest, Awin and others, you will end up with a lot of different triggers and tags. Additionally, with every change the chance of missing a tag or service rises. Over the years, such a container can easily contain 100+ assets just to inform every service about different conversions or important events. 

The idea behind this tag is to reduce the amount of assets like tags and triggers as well as the risk of inconsistent tagging by leaving out vendors when implementing new conversions and events - or change / update existing ones. 

![image](https://github.com/user-attachments/assets/d5a43c5d-52d2-4cef-b318-f34497bc6be1)

In order to create a **centralized management for every conversion or important event**, you can use this tag template. 

**Note:** This might not cover 100% of all conversion events and it can be necessary to keep some conversions and triggers seperate, but the tag should already cover a lot of cases.      

## Usage
After installing the template, create a new tag and trigger it with every page view (or the according event from your CMP) and / or for specific dataLayer events; depending on your conversion set-up. Whenever the tag gets fired, it will compare the current **URL, event name or any custom input value** with a pattern, either using "contains" (default) "equals" to find **matches** or a **regular expression** as operator.

You can define several rules and add properties like a conversion name, value, Google Ads conversion label and any other information that you need to feed yor conversion tags. 

This data will then get pushed to the dataLayer with an event name (default: `managedConversionEvent`) so you can access things like the current Google Ads conversion label as a dataLayer variable for example and use this to fill out your Google Ads Conversion tag, along with the `value` and optionally dynamic Google Ads conversion IDs, if you feed several accounts. Other keys like the `name` can be used in a GA4 tag, a Meta Custom Event and whatever is needed for tracking a conversion in all destination services.

## Options
Enter a **name for the dataLayer event** that will be pushed along with all conversion data in the first field and add a **placeholder** for empty values. It is recommended adding a unique string here that will appear instead of "undefined" for all unset string parameters. This helps to build more robust triggers.

### Conversion rules and data
The main configuration work will be done in this section. Add a new entry to the table for every conversion that you want to track by a common dataLayer event created by this tag.

#### Conversion rules
There are several options for defining a "rule" that will trigger a dataLayer push. If you do not want to remember the syntax but still use more than the default option described below and / or create and maintain a lot of rules, you can use the ["Conversions Manager Toolbox"](https://github.com/mbaersch/conversions-manager?tab=readme-ov-file#conversions-manager-toolbox) Google Sheet template:

![image](https://github.com/mbaersch/conversions-manager/blob/main/_res/pattern-helper.png)

#### Conversion rule syntax

- **Partial URL match, simple input version (default)**: If you want to track a specific page, you can enter a full URL including *https://* and the domain or just a part of the path that the current page URL has to **contain**. Example: `/some/path?success=true` will match any URL that contains this path, regardless of domain, earlier parts of the path, or other paramaters that might follow.   

- **Simple URL lists**: If there are several versions for a path that should fire the same conversion, add multiple entries and split them with a "|". Example: `/page1/confirm|page2/confirm|some/other/path`. As the full URL is used, you can react to parameters as well. 

- **Partial URL match, prefix version**: As other input values than the current URL require a specific syntax, you can use optional the prefix `uc:` (for "*URL contains*"). A pattern like `uc:/some/path?success=true` would lead to the same result as the simple version `/some/path?success=true`. 

- **URL Matches**: The prefix `um:` (for "*URL matches*") compares a full URL (including protocol!) with the value after the colon. Example: `um:https://www.mydomain.com/some/path?success=true` will only fire when the URL completely matches. Other hosts or additional parameters would not trigger this rule. 

- **URL RegEx**: To use regular expressions, use `ur:` (for "*URL matches RegEx*") or simply `re:` ("*RegEx*", as the URL is the default value to compare to) as prefix. Example: `re:something_.*\.html$`.

- **Compare event name instead of URL**: Use prefix `ec:` to compare with the current event name ("*event contains*"), `ee:` for "*event equals*" or `er:` for "*event matches regex*". Example: `ee:purchase`.

- **Compare to custom input value**: When you check the advanced option *Enable custom rule input*, one or multiple variables can be used to access data like `{{Click Classes}}` or others. If a value is present and the option is active, you can use the prefix `cc:` to *compare* with the custom value (partial match), `ce:` for *equals* or `cr:` for RegEx use. Example: `cc:btn-finish|btn-send`. Note: As all "*contains*" options will always split a value that contains a pipe ("|") in multiple values, make sure to only compare to a value without a pipe or use RegEx options instead.  

### Custom input
Check the box to activate the input field for your custom input value. You can combine several variables with a specific separator or a fixed pattern.

![image](https://github.com/user-attachments/assets/e8f1b140-8f45-45ab-9ff1-741b36af9a2e)

**Note**: If you mix rules for events, URLs, and custom values that compare with click classes, click IDs or similar data in the same *Conversions Manager* tag and fire it with every page view *and* specific events or clicks (or even all events), be aware that every matching rule will lead to a dataLayer push - everytime. If a click trigger fires the tag again on a page where the URL already led to a conversion, the second run will eventually trigger click conversions *and* additionally the already tracked conversion from the matching URL rule (again). It might be neccessary to create different *Conversions Manager* tags for different rule types to avoid that problem.

#### Using multiple values as custom input
When needing several variables like the referrer, page path, click- and form attributes, e-commerce data from the dataLayer or other more complex combinations in order to build all the rules you need, you can use several options for adding multiple GTM variables to your "Custom input". 

One option is to use some kind of list where values can be referenced and used to look for a match. 

```
{{Click ID}}|{{Click Classes}}|{{Click URL}}|{{Click Text}}|{{Referrer}}
```

You can also use either a string with a valid JSON object representation...

```
{"i":"{{Click ID}}","c":"{{Click Classes}}","u":"{{Click URL}}", "t":”{{Click Text}}","r":"{{Referrer}}"}
```

... or a single JavaScript variable that returns a real object with all the keys you want to compare to in your rules. Example code for a JS Variable:

```
function(){
  return {
    pageHostname: "{{Page Hostname}}",
    pageReferrer: "{{Referrer}}",
    
    clickElement: "{{Click Element}}",
    clickId: "{{Click ID}}",
    clickClasses: "{{Click Classes}}",
    clickUrl: "{{Click URL}}",
    clickText: "{{Click Text}}",
    clickTarget: "{{Click Target}}",

    formElement: "{{Form Element}}",
    formId: "{{Form ID}}",
    formClasses: "{{Form Classes}}",
    formUrl: "{{Form URL}}",
    formTarget: "{{Form Text}}",
    
    ecItemString: "{{ecommerce.items}}",
    ecValue: "{{ecommerce.value}}",
    ecTransactionId: "{{ecommerce.transaction_id}}",

    //add whatever variables might be relevant for your trigger rules
   
  }
}
```
#### Building rules for JS objects as custom values
When working with an object like this, using the standard prefixes `cc:`, `ce:`, and `cr:` can lead to false positives easily, because only the complete custom *string* can be used for comparison. 

If you want to access a *single value* from a custom object, you can use a different syntax that needs other prefixes. With a "*p*" for "*path*", you can begin a rule with `pc:`, `pe:`, or `pr:`, followed by the key name, another ":" and then the value or regular expression for matching.   

Example: If a click text should contain the word *cart* in order to trigger a conversion and the example JS variable above is avaiable as "Custom input", the rule would be: `pc:clickText:cart`. For a referrer containing "google.com" or "google.de": `pc:pageReferrer:google.com|google.de` as a simple list comparison or `pr:pageReferrer:.*google\.[com|de].*` using a regular expression.  

#### Adding conversion data
You can define a name, value, label and any other attribute of the current conversion using the table fields. Either enter constant values or use variables to calculate dynamic values or get them from the dataLayer. 

![image](https://github.com/user-attachments/assets/281aec7f-025a-47bc-8bb8-dc8b0d5011fa)

When defining **Custom data**, you can either input a simple string or add multiple parameters as a valid JSON string. The tag will try to parse and add data as an array / object to the dataLayer event if a value is present. If it cannot be parsed as JSON, it will remain a string value. Please make sure that you enter a valid JSON string with all key names as string with " or ' as delimiters. And keep double curly brackets apart by adding whitespace to avoid misinterpretation of JSON code as a variable placeholder. Note that those GTM variable placeholders like `{{Page Path}}` or others can be used here, too. 

## Triggering your conversions
When the tag is fired, it compares the current event name and page URL with all rules that are defined and pushes an event to the dataLayer for every matching rule, along with the data defined. Example: 

```
dataLayer.push({
  event: "managedConversionEvent",
  conversionInfo: {
    name: "generate_lead",
    value: 42,
    ads_label: "ACcDefG2345hIjKL-mN",
    custom: {send_to_pinterest: false, fb_event_name: "Lead", lead_type: "Contact"}
  },
  gtm.uniqueEventId: 295
})
```

You can then use the event as a **firing trigger** for all conversion tags - one for every service you want to inform. Using dataLayer variables (for a path like `conversionInfo.custom.lead_type`), you can access all data from the rule that you need to feed the different conversion tags (like labels, event names and other options that might be present). 

Create **blocking triggers** for missing data like `ads_label is "NONE"` to fire a service only if everything was privided in the rule that created the dataLayer event.  

This way, you can usually use just one trigger to fire all conversions, and one blocking trigger and a tag for every service.  

## Conversions Manager Toolbox
Working with parameter tables in the Google Tag Manager tag UI is not always fun. All additional services have to be added in some format to the "Custom" field, too. JSON is a good for readability and easy access from the dataLayer, but editing longer field lists inside GTM without any help, formatting or validation is hard and risky.   

Also, if you have a bunch of rules and need to add changes or even new services that should have a value in a complex "Custom" JSON structure, the UI limitations will require a lot of clicks and manual work.

For quicker (and more reliable) results, you can use a Google Spreadsheet that can help you...

- to define and maintain conversion rules
- edit all standard "Conversion data" parameters 
- add new fields to your "Custom" structure or edit / delete existing data
- create variables to access all parameters (standard and custom) with a click
- add triggers to the container to fire tags depending on variable values    

![image](https://github.com/mbaersch/conversions-manager/blob/main/_res/toolbox-rules.png)

### Use the template
You can [access the template here](https://docs.google.com/spreadsheets/d/1k1L3CIudh2c8fyX3jnYrGqCrCqCvFmrx7E_bGzPBtts), make a copy in your own drive and use the "Conversions Manager Toolbox" menu in the spreadsheet to read and write rules and add variables and triggers.

Quick instructions can be found in the "Configuration" sheet, where you need to add the path to your existing Conversions Manager tag in the format: https://tagmanager.google.com/container/accounts/xxx/containers/yyy/workspaces/zzz/tags/123 or (short) accounts/xxx/containers/yyy/workspaces/zzz/tags/123. 

A "Browse" button will help you to pick the tag from a list instead, listing all accounts first. After selecting an account, a list of containers will be loaded and then new lists with workspaces and tags after you select an item from the previous list. If a workspace "Default Workspace" is present in the list of workspaces, it will be selected automatically (just like a tag called "Conversions Manager" in the tags list). 

### Definig patterns
Using the prefix syntax to define a rule might seem confusing. For that reason, the template includes a tab called "Pattern Helper" where you can select a source and match type from a list, enter a value and get a pattern as a result. You can use this to populate the "Pattern / Trigger rule" column in the "Rules" sheet by selecting "*Edit - Paste special - Values only*" from the menu or using the hotkey CTRL+SHIFT+V.   