# API endpoints

These endpoints allow you to handle Stripe subscriptions for Publish and Analyze.

## POST
`official client only` [/1/billing/start-trial.json](#post-1billingstart-trialjson) <br/>
`official client only` [/1/billing/cancel-trial.json](#post-1billingcancel-trialjson) <br/>
`official client only` [/1/billing/start-or-update-subscription.json](#post-1billingstart-or-update-subscriptionjson) <br/>
`official client only` [/1/billing/cancel-subscription.json](#post-1billingcancel-subscriptionjson) <br/>
___

### POST /1/billing/start-trial.json
Starts a trial for a user. `official client only`

**Parameters**

|                   Name | Type    | Description                                                                                                                                                         |
| ----------------------:| ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|     `product` required | string  | The product for which to perform the action. <br/><br/> Supported values: `publish` or `analyze`.                                                                   |
|        `plan` required | string  | The plan for which to start the trial period. <br/><br/> Supported values for Publish: `pro`, `small`, `business`, `agency`.  <br/>Supported values for Analyze: TBD. |
| `trialLength` optional | integer | Default is `null`. If no trial length is passed, relies on the product hook logic to define the right trial length for the given plan and product.                  |
<!-- |       `cycle` optional | string  | Default is `null`. If no cycle is passed, relies on the product hook logic to define the right cycle. <br/><br/> Support values: `null`, `month` or `year`          | -->

**Response**

```
{
    "success": true
}
```
___

### POST /1/billing/cancel-trial.json
Cancels a trial for a user. `official client only`

**Parameters**

|                   Name | Type    | Description                                                                                                                                                         |
| ----------------------:| ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|     `product` required | string  | The product for which to perform the action. <br/><br/> Supported values: `publish` or `analyze`.                                                                   |
|        `plan` required | string  | The plan for which to cancel the trial period. <br/><br/> Supported values for Publish: `pro`, `small`, `business`, `agency`.  <br/>Supported values for Analyze: TBD.

**Response**

```
{
    "success": true
}
```
___

### POST /1/billing/start-or-update-subscription.json
Starts a new subscription or updates an existing one. Can (and should) also be used to complete a trial period. `official client only`

**Parameters**

|                   Name | Type    | Description                                                                                                                                                         |
| ----------------------:| ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|     `product` required | string  | The product for which to perform the action. <br/><br/> Supported values: `publish` or `analyze`.                                                                   |
|        `plan` required | string  | The plan for which to start the trial period. <br/><br/> Supported values for Publish: `pro`, `small`, `business`, `agency`.  <br/>Supported values for Analyze: TBD. |
| `stripeToken` optional | string | Is `required` when starting a new subscription for the first time. <br/><br/>*Stripe will error if we start/update a subscription for a customer who has no credit card: only trials can be started without a credit card.*  <br/> *Please use [/1/billing/start-trial.json](#post-1billingstart-trialjson) to start a trial.*|
|       `cycle` optional | string | Default is `null`. If no cycle is passed, relies on the product hook logic to define the right cycle. <br/><br/> Support values: `null`, `month` or `year`          |

**Response**

```
{
    "success": true
}
```
___

### POST /1/billing/cancel-subscription.json
Cancels an existing subscription. Will cancel any existing and trialing subscriptions. `official client only`

**Parameters**

|                   Name | Type    | Description                                                                                                                                                         |
| ----------------------:| ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|     `product` required | string  | The product for which to perform the action. <br/><br/> Supported values: `publish` or `analyze`.                                                                   |
|     `atPeriodEnd` optional | boolean  | Default is `true`. Specifies if the subscription should be deleted now or when the subscription is due to end. <br/><br/> *Common use case is to pass `true` since we want to let the customers use the full period they paid for.* <br/>*Should only pass `false` (i.e. cancel the subscription right now) when a Stripe customer switches to iOS/Android.)*                  |

**Response**

```
{
    "success": true
}
```
