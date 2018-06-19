# API endpoints

These endpoints allow you to handle Stripe subscription for Publish and Analyze.

## POST
`official client only` [/1/billing/start-trial.json](#post-1billingstart-trialjson)



## POST /1/billing/start-trial.json

`official client only` - Starts a trial for a user.

**Parameters**

|                   Name | Type    | Description                                                                                                                                                         |
| ----------------------:| ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|     `product` required | string  | The product for which to perform the action. <br/><br/> Supported values: `publish` or `analyze`.                                                                   |
|        `plan` required | string  | The plan for which to start a trial period. <br/><br/> Supported values for Publish: `pro`, `small`, `business`, `agency`.  <br/>Supported values for Analyze: TBD. |
| `trialLength` optional | integer | Default is `null`. If no trial length is passed, relies on the product hook logic to define the right trial length for the given plan and product.                  |
|       `cycle` optional | string  | Default is `null`. If no cycle is passed, relies on the product hook logic to define the right cycle. <br/><br/> Support values: `null`, `month` or `year`          |

**Response**

```
{
    "success": true
}
```
