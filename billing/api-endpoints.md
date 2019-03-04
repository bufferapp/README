# API endpoints

These endpoints allow you to handle Stripe subscriptions for Publish and Analyze.

## GET
`official client only` [/1/billing/retrieve-billing-data.json](#get-1billingretrieve-billing-datajson) <br/>

## POST
`official client only` [/1/billing/start-trial.json](#post-1billingstart-trialjson) <br/>
`official client only` [/1/billing/cancel-trial.json](#post-1billingcancel-trialjson) <br/>
`official client only` [/1/billing/start-or-update-subscription.json](#post-1billingstart-or-update-subscriptionjson) <br/>
`official client only` [/1/billing/cancel-subscription.json](#post-1billingcancel-subscriptionjson) <br/>
___

### GET /1/billing/retrieve-billing-data.json
Get basics billing data for the current user or for a given organization ID (as long as the current user is part of that organization). (it has been poorly implemented for now to unblock the Analyze team, and should only be used by Analyze) `official client only`

**Parameters**

|          Name | Required |  Type   | Description                                                                                                                                                           |
| -------------:|:--------:|:-------:| --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|     `product` | required | string  | The product for which to perform the action. <br/><br/> Supported values: `publish` or `analyze`.                                                                     |
|     `organization_id` | optional | string  | The organization ID for which to perform the action. <br/><br/> Default is `null`. <br/><br/> If passed, we will check if the user is part of that organization before returning any information.                                                                     |

**Response**

```
// Customer has no subscription
{
    "success": true,
    "data": {
        "subscriptions": []
    }
}

or

// Customer has one paying subscription
{
    "success": true,
    "data": {
        "subscriptions": [
            0 => [
                "plan_name": "early-access-10", //could be any supported plan
                "quantity": 11,
                "cycle": "month|year",
                "current_period_end": 1531897966, //timestamp in seconds
                "cancel_at_period_end": true|false,
                is_paying: true,
                is_trialing: false
            ]
        ]
    }
}

or

// Customer has one trialing subscription
{
    "success": true,
    "data": {
        "subscriptions": [
            0 => [
                "plan_name": "early-access-10", //could be any supported plan
                "quantity": 11,
                "cycle": "month|year",
                "current_period_end": 1531897966, //timestamp in seconds
                "cancel_at_period_end": true|false,
                is_paying: false,
                is_trialing: true
            ]
        ]
    }
}

or

// Customer has two subscriptions
{
    "success": true,
    "data": {
        "subscriptions": [
            0 => [
                "plan_name": "pro", //could be any supported plan
                "quantity": 1,
                "cycle": "month|year",
                "current_period_end": 1531897966, //timestamp in seconds
                "cancel_at_period_end": true|false,
                is_paying: true,
                is_trialing: false
            ],
            1 => [
                "plan_name": "business", //could be any supported plan
                "quantity": 1,
                "cycle": "month|year",
                "current_period_end": 1531897966, //timestamp in seconds
                "cancel_at_period_end": true|false,
                is_paying: false,
                is_trialing: true
            ]
        ]
    }
}


or any implemented error from https://buffer.com/developers/api/errors

{
    "code": 1000,
    "error": "An error message"
}
```
___

### POST /1/billing/start-trial.json
Starts a trial for a user. `official client only`

**Parameters**

|          Name | Required |  Type   | Description                                                                                                                                                           |
| -------------:|:--------:|:-------:| --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|     `product` | required | string  | The product for which to perform the action. <br/><br/> Supported values: `publish` or `analyze`.                                                                     |
|        `plan` | required | string  | The plan for which to start the trial period. <br/><br/> Supported values for Publish: `pro`, `small`, `business`, `agency`.  <br/>Supported values for Analyze: `early-access-10`, `early-access-25`, `early-access-50`, `early-access-100`. |
| `trialLength` | optional | integer | Length of the trial in days. <br/><br/>Default is `null`. <br/><br/>If value is null, relies on the product hook logic to define the trial length for the given plan and product.                    |
|       `cycle` | optional | string  | Default is `null`. <br/><br/>If value is null, relies on the product hook logic to define the cycle. <br/><br/> Supported values: `null`, `month` or `year`          |
|    `quantity` | optional | integer  | Default is `1`. <br/><br/>This value (either default or passed) will always override the current subscription quantity value.          |
|    `cta` | optional | string  | Can be used for tracking purpose - [Read more](https://github.com/bufferapp/README/tree/master/runbooks/data-tracking)          |

**Response**

```
{
    "success": true
}

or any implemented error from https://buffer.com/developers/api/errors

{
    "code": 1000,
    "error": "An error message"
}
```
___

### POST /1/billing/cancel-trial.json
Cancels a trial for a user. `official client only`

**Parameters**

|          Name | Required |  Type   | Description                                                                                                                                                         |
| -------------:|:--------:|:-------:| ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|     `product` | required | string  | The product for which to perform the action. <br/><br/> Supported values: `publish` or `analyze`.                                                                   |
|    `cta` | optional | string  | Can be used for tracking purpose - [Read more](https://github.com/bufferapp/README/tree/master/runbooks/data-tracking)          |

**Response**

```
{
    "success": true
}

or any implemented error from https://buffer.com/developers/api/errors

{
    "code": 1000,
    "error": "An error message"
}
```
___

### POST /1/billing/start-or-update-subscription.json
Starts a new subscription or updates an existing one. Can (and should) also be used to complete a trial period. `official client only`

**Parameters**

|          Name | Required |   Type  | Description                                                                                                                                                         |
| -------------:|:--------:|:-------:| ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|     `product` | required | string  | The product for which to perform the action. <br/><br/> Supported values: `publish` or `analyze`.                                                                   |
|        `plan` | required | string  | The plan for which to start a subscription. <br/><br/> Supported values for Publish: `pro`, `small`, `business`, `agency`.  <br/>Supported values for Analyze: `early-access-10`, `early-access-25`, `early-access-50`, `early-access-100`. |
| `stripeToken` | optional | string | Is `required` only the first time when the Stripe customer has no registered credit card. <br/><br/>Stripe tokens are usually generated on the frontend: see [Stripe doc](https://stripe.com/docs/stripe-js/elements/quickstart#create-token) and as an example [Add credit card form Buffer component](https://github.com/bufferapp/buffer-web/blob/master/app/webroot/js/creditCard/components/addCreditCardForm.jsx).<br/><br/>*Stripe will error if we start/update a subscription for a customer who has no credit card: only trials can be started without a credit card.*  <br/> *Please use [/1/billing/start-trial.json](#post-1billingstart-trialjson) to start a trial.*|
|       `cycle` | optional | string | Default is `null`. <br/><br/>If value is null, relies on the product hook logic to define the cycle. <br/><br/> Support values: `null`, `month` or `year`          |
|    `quantity` | optional | integer  | Default is `1`.  <br/><br/>This value (either default or passed) will always override the current subscription quantity value.         |
|    `cta` | optional | string  | Can be used for tracking purpose - [Read more](https://github.com/bufferapp/README/tree/master/runbooks/data-tracking)          |

**Response**

```
{
    "success": true
}

or any implemented error from https://buffer.com/developers/api/errors

{
    "code": 1000,
    "error": "An error message"
}
```
___

### POST /1/billing/cancel-subscription.json
Cancels an existing subscription. Will cancel any existing and trialing subscriptions. `official client only`

**Parameters**

|          Name | Required |  Type   | Description                                                                                                                                                         |
| -------------:|:--------:|:-------:| ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|     `product` | required | string  | The product for which to perform the action. <br/><br/> Supported values: `publish` or `analyze`.                                                                   |
| `atPeriodEnd` | optional | boolean | Default is `true`. Specifies if the subscription should be deleted now or when the subscription is due to end. <br/><br/> *Common use case is to pass `true` since we want to let the customers use the full period they paid for.* <br/>*Should only pass `false` (i.e. cancel the subscription right now) when a Stripe customer switches to iOS/Android.)* |
|    `cta` | optional | string  | Can be used for tracking purpose - [Read more](https://github.com/bufferapp/README/tree/master/runbooks/data-tracking)          |

**Response**

```
{
    "success": true
}

or any implemented error from https://buffer.com/developers/api/errors

{
    "code": 1000,
    "error": "An error message"
}
```
