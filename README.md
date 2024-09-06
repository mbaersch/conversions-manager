# Conversions Manager

**Create conversion event pushes to dataLayer depending on URLs (Custom Tag Template for Google Tag Manager)**

## Why this template? 
If you only track a single type of conversion like a purchase for a few services, this tag might not be for you. But when there are multiple conversions, depending on different events and / or URLs, and several services like Google Ads, Google Analytics, Meta, Pinterest, Awin and others, you will end up with a lot of different triggers and tags. Additionally, with every change the chance of missing a tag or service rises. Over the years, such a container can easily contain 100+ assets just to inform every service about different conversions. 

The idea behind this tag is to reduce the amount of assets like tags and triggers as well as the risk ofinconsistent tagging by leaving out vendors when implementing new conversions - or change / update existing ones. 

![image](https://github.com/user-attachments/assets/d5a43c5d-52d2-4cef-b318-f34497bc6be1)

In order to create a **centralized management for every conversion** that depends on a URL or event, you can use this tag template. 

**Note:** This might not cover 100% of all conversion events and it can be necessary to keep some conversions and triggers seperate, but the tag should already cover a lot of cases.      

## Usage
After installing the template, create a new tag and trigger it with every page view (or the according event from your CMP) and / or for specific dataLayer events; depending on your conversion set-up. Wnenever the tag gets fired, it will compare the current **URL, event name or custom input value** with a pattern, either using "contains" (default) "equals" to find **matches** or a **regular expression** as operator.

You can define several rules and add properties like a conversion name, value, Google Ads conversion label and any other information that you need to feed yor conversion tags. 

This data will then get pushed to the dataLayer with an event name (default: `managedConversionEvent`) so you can access things like the current Google Ads conversion label as a dataLayer variable for example and use this to fill out your Google Ads Conversion tag, along with the `value` and optionally dynamic Google Ads conversion IDs, if you feed several accounts. Other keys like the `name` can be used in a GA4 tag, a Meta Custom Event and whatever is needed for tracking a conversion in all destination services.

## Options
Enter a **name for the dataLayer event** that will be pushed along with all conversion data in the first field and add a **placeholder** for empty values. It is recommended adding a unique string here that will appear instead of "undefined" for all unset string parameters. This helps to build more robust triggers.

### Conversion rules and data
The main configuration work will be done in this section. Add a new entry to the table for every conversion that you want to track by a common dataLayer event created by this tag.

#### Conversion rules
There are several options for defining a "rule" that will trigger a dataLayer push: 

- **Partial match (default)**: If you want to track a specific page, you can enter a full URL including *https://* and the domain or just a part of the path that the current page URL has to **contain**. If there are several versions for a path that should fire the same conversion, add multiple entries and split them with a "|". Example: `/page1/confirm|page2/confirm`. As the full URL is used, you can react to parameters as well. 

- **RegEx**: To use regular expressions, use `re:` as prefix. Example: `re:something_.*\.html$`.

- **Compare event name instead of URL**: Use prefix `ec:` to compare with the current event name ("event contains"), `ee:` for "event equals" or `er:` for "event matches regex". Example: `ee:purchase`.

- **Compare to custom input value**: When you check the advanced option *Enable custom rule input*, one or multiple variables can be used to access data like `{{Click Classes}}` or others. If a value is present and the option is active, you can use the prefix `cc:` to *compare* with the custom value (partial match), `ce:` for *equals* or `cr:` for regex use. Example: `cc:btn-finish|btn-send`.

### Custom input
Check the box to activate the input field for your custom input value. You can combine several variables with a specific separator or a fixed pattern.

![image](https://github.com/user-attachments/assets/e8f1b140-8f45-45ab-9ff1-741b36af9a2e)

**Note**: If you mix rules for events, URLs, and custom values that compare with click classes, click IDs or similar data in the same *Conversions Manager* tag and fire it with every page view *and* specific events or clicks (or even all events), be aware that every matching rule will lead to a dataLayer push - everytime. If a click trigger fires the tag again on a page where the URL already led to a conversion, the second run will eventually trigger click conversions *and* additionally the already tracked conversion from the matching URL rule (again). It might be neccessary to create different *Conversions Manager* tags for different rule types to avoid that problem.

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
