# CTA (Call To Action) Parameters Runbook

This is intended to share how explicit CTA tracking works, for both signups and trial starts.


## What is explicit CTA tracking, and what are these 'parameters' you speak of?

Explicit CTA tracking associates the result of a successful conversions of a given CTA back to the specific CTA.  This does not track clicks of a CTA that never followed through with the intended action, but rather attributes a source CTA to completed actions like a signup or a trial start.

We track the CTA to the eventual successful action by passing a unique parameter for that specific CTA.  For the case of trials, the parameter is then added to the metadata of the trial subscription in Stripe.  On the other hand, for the case of signups, the parameter is added to the BUDA signup event, via the [`buffer-js-buffermetrics` middleware](https://github.com/bufferapp/buffer-js-buffermetrics).  For signups that include a trial, the same parameter string is added to both the BUDA signup event and the Stripe trial subscription metadata.

* This is currently available for tracking:
    * Publish signups from CTAs on a page in the `buffer-marketing` repo (coming soon!)
    * Publish trials, with or without signups
    * Publish trials after signup, both inapp and from marketing pages
    * Analyze trials

## How should I go about implementing tracking on a CTA that does not currently have tracking parameter?

The first step is determining where the CTA is located and what it will trigger.  There are different implementation steps if the CTA is on a marketing page vs being in an app.

* marketing pages in `buffer-marketing` repo
    * utilize the handlebars helper function, adding a string value for the `cta` parameter for the CTA, following the below convention.
* in app
    * The billing controllers accept an optional cta parameter for all the endpoints. If used, the value of this parameter will be added to the Stripe Subscription metadata.

## Is there a convention I should stick to for the parameter value?

* Yes!  Would you be up for using this convention? Sticking to one convention would greatly help for analysis purposes.
    * The intention is to have a human understandable string to uniquely identify the CTA, that will allow us to know where the CTA was located by reading the value (essentially self documenting), and allow us to segment by each step of the taxonomy during analysis
    * The string value of the parameter should be a unique name of the CTA using a naming conventions of:
        * Marketing page:
        [website]-[page path]-[page section]-[unique CTA name]-[version # of CTA, manually incremented each time change made]
        * In app:
        [product]-[general section of app]-[detailed location in app section]-[unique CTA name]-[version # of CTA, manually incremented each time change made]
        * Other specifics for both marketing pages and in app:
            * Use `-` as the delimiter, and no other non-alphanumeric characters
            * No spaces in the string
            * If 2+ words are needed for a step of the taxonomy, use camelCase
            * All lowercase unless using camelCase in a step of the string
            * Version number should be an integer
    * Example, for the CTA in the Buffer homepage hero section above the fold, the parameter could be: `buffercom-home-hero-free-1`
    * Example, for the CTA in the Publish app, in new Publish when trying to add a Pinterest profile as a Free user, the parameter could be: `publish-manageProfiles-connectProfiles-pinterest-1`

## What adjustments need to happen if a change is made to a CTA that has a tracking parameter?

* If something was modified a CTA after we starting tracking it, like the copy on the button was changed, a new color was used, etc, we would want to increment version number at the end of the string.
    * This will allow for analysis that can differentiate between versions of the same CTA
    * Example, sticking with the example above, if we changed the copy on the CTA in the Buffer homepage hero section above the fold after we started tracking with parameter `buffercom-home-hero-free-1`, we would want to increment to `buffercom-home-hero-free-2`
* If we moved a CTA to a new location that has a meaningful change to its location on the page, please change the 3rd step of the string to reflect the name of the new location and set the version number to 1
