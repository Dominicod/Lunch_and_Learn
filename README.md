<p align="center">
  <img src="https://blog.dominwrites.com/wp-content/uploads/2022/07/cropped-cropped-cropped-D-1.png" />
</p>
<center><h1>Info</h1></center>
 This app will allow users to search for recipes by country, favorite recipes, and learn more about a particular country.

## About the Project

>[Deployed BE Heroku Site](https://lunch-and-learn-2022.herokuapp.com/api/v1)

###TBD

## Built With
![RoR](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![pgsql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![heroku](https://img.shields.io/badge/heroku-316192?style=for-the-badge&logo=heroku&logoColor=white)
![circleci](https://img.shields.io/badge/circleci-316192?style=for-the-badge&logo=circle&logoColor=white)

## Gems
![rspec-rails](https://img.shields.io/gem/v/rspec-rails?label=rspec-rails&style=flat-square)
![shoulda](https://img.shields.io/gem/v/shoulda-matchers?label=shoulda-matchers&style=flat-square)
![simplecov](https://img.shields.io/gem/v/simplecov?label=simplecov&style=flat-square)
![faker](https://img.shields.io/gem/v/faker?color=blue&label=faker)
![factory bot](https://img.shields.io/gem/v/factory_bot_rails?color=blue&label=factory_bot_rails)
![jsonapi-serializer](https://img.shields.io/gem/v/jsonapi-serializer?color=blue&label=jsonapi-serializer)
![pry](https://img.shields.io/gem/v/pry?color=blue&label=pry)
![bullet](https://img.shields.io/gem/v/bullet?color=blue&label=bullet)
![faraday](https://img.shields.io/gem/v/faraday?color=blue&label=faraday)
![figaro](https://img.shields.io/gem/v/figaro?color=blue&label=figaro)
![rubocop](https://img.shields.io/gem/v/rubocop?color=blue&label=rubocop)
![vcr](https://img.shields.io/gem/v/vcr?color=blue&label=vcr)
![webmock](https://img.shields.io/gem/v/webmock?color=blue&label=webmock)

## Table of Contents

1. [Set Up](#set-up)
2. [Database Creation](#database-creation)
3. [Database Structure](#database-structure)
4. [Deployment](#deployment)
5. [Testing Instructions](#testing-instructions)
6. [Recipes End Points](#recipe-end-points)
   1. [Index](#recipes-index)
7. [Learning Resources End Points](#learning-resources-end-points)
   1. [Index](#learning-resources-index)


## Set Up

#### API Keys:
* https://developer.edamam.com/edamam-docs-recipe-api (`ED_APP_ID`, `ED_APP_KEY`)
* https://unsplash.com/documentation (`UNSPLASH_CLIENT`)
* https://developers.google.com/youtube/v3/docs (`GOOGLE_API_KEY`)

- Clone this repo
- `bundle install`
- `bundle exec figaro install`
- Place required API_KEY's inside of `config/application.yml`
- `rails s`

## Database Creation
- `rails db:{create,migrate,seed}`

## Database Structure

![database](app/assets/images/database.png)

## Deployment
- `rails s`

## Testing Instructions

- Clone this repo
- in terminal (apple or integrated)
    * `bundle install`
    * `bundle exec figaro install`
    * Place required API_KEY's inside of `config/application.yml`
    * `bundle exec rspec`

## Recipe End Points

### Recipes Index
Returns an index of recipes for a randomly selected country

*If a country does not have recipes, an empty array is returned*

`GET https://lunch-and-learn-2022.herokuapp.com/api/v1/recipes`

```json
{
  "data": [
    {
      "id": null,
      "type": "recipe",
      "attributes": {
        "title": "Basic Turkey Gravy Recipe",
        "url": "http://www.seriouseats.com/recipes/2013/11/basic-turkey-gravy-thanksgiving-recipe.html",
        "country": {Random Country},
        "image": "https://edamam-product-images.s3.amazonaws.com/web-img/f0c/f0c28799f982d3feb7cda573a6ae217f.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjELb%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJGMEQCIDb3jX3hQ6lifaBUHE8UAcoqfy4bnOKMkMTd59mldmsEAiB504ly0xv4HGPgKoppP9AhSGVONlLAShCWC3PO2xnrbCrVBAiv%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAAaDDE4NzAxNzE1MDk4NiIM1Q4bEjxTjE4fFPd2KqkEB0nHiGS5YZi2PrvXkfvekIpZqIY21%2BqIVHFStjjEQTVPCLPWz%2Bm2PRD%2FWbnu%2ByRaZq%2FZ6fGXcvey0RqRTX6EP48GRwQFeo4bRENz3hccqh69JC759eHoIQsEzSt10O87MzFiH3JgSTcLekWZcfv0IuyZS8yWzYLS5s4mUq%2Bc%2FfFQSyVvb%2BDX2GejAzmeuPMS6kABk3fSriWiBnS6Lmskv5bwHvGZulL9nPRW7qxYYfdcQX78n59bUmmCPF8ryklkeF%2FQFBZiNOPDJAoZmeDnzTAJ2Z1IZSmQGTHnXGu4ZKFYUJom54Y7%2FbmCDusYmerv2PtS0s6FcEGb570m%2FVaH2eZyrBgQTpIMd36DZglxlmYnrLLO3ElJk6xoPTzhgKWsL8WcLGMXS9RvSyLtbOCxxOQa0OZAXHreyjdQmUlCav1py3q5VxiSvQGaWe4FwOvLgtkPnzBeoEPunVc5XBzivZzdz9StdYpl0oy0XxdmKWhWZ56JKUe%2F3uv6AoOnlGoKW4P0HT%2F9ige9YstgFaDYXAImGnRl%2B1oLbaK4RxJNyVEZMD8Opzx3gSnOhfyvDgELfxKw8VL2JA08HLOwHoBvDTxQrV85n72aDr27sQHcjqX0TZwA9atM2Xdd0tPY%2FFXTGrZASKCaMzxfZI3X56E9fpuuLCvxBAJHA4dSwcZNo7C%2BhKEbySE%2BMozNEsG6VoDRTBi48eqD5DY37exbK5gh%2F937VsnEM2ToYjD6rcCbBjqqAaaHidriType0U7CtbpvD0ggRFzKcCKvYX1E16DOXtmmzXwmetICh4ynuzezgSAcTiqnaDnEtbh8LkM%2BRoKYpNyqewvkNJ1Y6XauKgmbhuN%2BfpQJxVb6lS0r5KZ%2BZW0KDE6ccu%2FvPBfg0pguAH5m317VKcPDHmBusd4BT8FdXJj25DIuloL69Do2gVrrol1Epi1pw%2F8QwRVm2qL2xN122r5QPSxXAp1kqlps&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20221112T222444Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFK3IPR6RH%2F20221112%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=d22d3fc50d11729b26753a9f9188113d35972c5295a740c8953c84bd27470c9a"
      }
    }
  ]
}
{...}
{...}
{...}
```

or returns an index of recipes for given country

*If a country does not have recipes, an empty array is returned*

`GET https://lunch-and-learn-2022.herokuapp.com/api/v1/recipes?country=San+Marino`

```json
{
  "data": [
    {
      "id": null,
      "type": "recipe",
      "attributes": {
        "title": "Chilled Caramelized Oranges with Yogurt",
        "url": "http://www.cookstr.com/recipes/chilled-caramelized-oranges-with-yogurt",
        "country": "San Marino",
        "image": "https://edamam-product-images.s3.amazonaws.com/web-img/348/34807721847d57817a3050bf389d230f.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjELb%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJGMEQCIDb3jX3hQ6lifaBUHE8UAcoqfy4bnOKMkMTd59mldmsEAiB504ly0xv4HGPgKoppP9AhSGVONlLAShCWC3PO2xnrbCrVBAiv%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAAaDDE4NzAxNzE1MDk4NiIM1Q4bEjxTjE4fFPd2KqkEB0nHiGS5YZi2PrvXkfvekIpZqIY21%2BqIVHFStjjEQTVPCLPWz%2Bm2PRD%2FWbnu%2ByRaZq%2FZ6fGXcvey0RqRTX6EP48GRwQFeo4bRENz3hccqh69JC759eHoIQsEzSt10O87MzFiH3JgSTcLekWZcfv0IuyZS8yWzYLS5s4mUq%2Bc%2FfFQSyVvb%2BDX2GejAzmeuPMS6kABk3fSriWiBnS6Lmskv5bwHvGZulL9nPRW7qxYYfdcQX78n59bUmmCPF8ryklkeF%2FQFBZiNOPDJAoZmeDnzTAJ2Z1IZSmQGTHnXGu4ZKFYUJom54Y7%2FbmCDusYmerv2PtS0s6FcEGb570m%2FVaH2eZyrBgQTpIMd36DZglxlmYnrLLO3ElJk6xoPTzhgKWsL8WcLGMXS9RvSyLtbOCxxOQa0OZAXHreyjdQmUlCav1py3q5VxiSvQGaWe4FwOvLgtkPnzBeoEPunVc5XBzivZzdz9StdYpl0oy0XxdmKWhWZ56JKUe%2F3uv6AoOnlGoKW4P0HT%2F9ige9YstgFaDYXAImGnRl%2B1oLbaK4RxJNyVEZMD8Opzx3gSnOhfyvDgELfxKw8VL2JA08HLOwHoBvDTxQrV85n72aDr27sQHcjqX0TZwA9atM2Xdd0tPY%2FFXTGrZASKCaMzxfZI3X56E9fpuuLCvxBAJHA4dSwcZNo7C%2BhKEbySE%2BMozNEsG6VoDRTBi48eqD5DY37exbK5gh%2F937VsnEM2ToYjD6rcCbBjqqAaaHidriType0U7CtbpvD0ggRFzKcCKvYX1E16DOXtmmzXwmetICh4ynuzezgSAcTiqnaDnEtbh8LkM%2BRoKYpNyqewvkNJ1Y6XauKgmbhuN%2BfpQJxVb6lS0r5KZ%2BZW0KDE6ccu%2FvPBfg0pguAH5m317VKcPDHmBusd4BT8FdXJj25DIuloL69Do2gVrrol1Epi1pw%2F8QwRVm2qL2xN122r5QPSxXAp1kqlps&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20221112T222644Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFK3IPR6RH%2F20221112%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=74d5c539bda7e586dbb77a9128dc31baae7addf7575eafd530e384fde6849eb3"
      }
    }
  ]
}
{...}
{...}
{...}
```
## Learning Resources End Points

### Learning Resources Index
Returns a learning resource for a selected country

*If a country does not have images or a video, an empty array is returned in its place*

`GET https://lunch-and-learn-2022.herokuapp.com/api/v1/learning_resources?country=Laos`
```json
{
    "data": {
        "id": null,
        "type": "learning_resource",
        "attributes": {
            "country": "laos",
            "video": {
                "title": "A Super Quick History of Laos",
                "youtube_video_id": "uw8hjVqxMXw"
            },
            "images": [
                {
                    "alt_tag": "time lapse photography of flying hot air balloon",
                    "url": "https://images.unsplash.com/photo-1540611025311-01df3cef54b5?ixid=MnwzODAyMzF8MHwxfHNlYXJjaHwxfHxsYW9zfGVufDB8fHx8MTY2ODMwMzgzMA&ixlib=rb-4.0.3"
                },
                {
                    "alt_tag": "aerial view of city at daytime",
                    "url": "https://images.unsplash.com/photo-1570366583862-f91883984fde?ixid=MnwzODAyMzF8MHwxfHNlYXJjaHwyfHxsYW9zfGVufDB8fHx8MTY2ODMwMzgzMA&ixlib=rb-4.0.3"
                },
                {
                    "alt_tag": "brown and white concrete building under blue sky during daytime",
                    "url": "https://images.unsplash.com/photo-1610426714962-83caa2244105?ixid=MnwzODAyMzF8MHwxfHNlYXJjaHwzfHxsYW9zfGVufDB8fHx8MTY2ODMwMzgzMA&ixlib=rb-4.0.3"
                },
                {
                    "alt_tag": "aerial view of green trees and mountains during daytime",
                    "url": "https://images.unsplash.com/photo-1593994602962-fc4c26fd82e9?ixid=MnwzODAyMzF8MHwxfHNlYXJjaHw0fHxsYW9zfGVufDB8fHx8MTY2ODMwMzgzMA&ixlib=rb-4.0.3"
                },
                {
                    "alt_tag": "waterfalls in the middle of the forest during daytime",
                    "url": "https://images.unsplash.com/photo-1626982024771-282582a4ecac?ixid=MnwzODAyMzF8MHwxfHNlYXJjaHw1fHxsYW9zfGVufDB8fHx8MTY2ODMwMzgzMA&ixlib=rb-4.0.3"
                },
                {
                    "alt_tag": "two boats near body of water",
                    "url": "https://images.unsplash.com/photo-1441632260885-881646a7fd4d?ixid=MnwzODAyMzF8MHwxfHNlYXJjaHw2fHxsYW9zfGVufDB8fHx8MTY2ODMwMzgzMA&ixlib=rb-4.0.3"
                },
                {
                    "alt_tag": "waterfalls on mountain",
                    "url": "https://images.unsplash.com/photo-1565092640981-0081b99f45ba?ixid=MnwzODAyMzF8MHwxfHNlYXJjaHw3fHxsYW9zfGVufDB8fHx8MTY2ODMwMzgzMA&ixlib=rb-4.0.3"
                },
                {
                    "alt_tag": "woman in red and white floral dress smiling",
                    "url": "https://images.unsplash.com/photo-1608000065495-0032a4e54f80?ixid=MnwzODAyMzF8MHwxfHNlYXJjaHw4fHxsYW9zfGVufDB8fHx8MTY2ODMwMzgzMA&ixlib=rb-4.0.3"
                },
                {
                    "alt_tag": "green trees near body of water during daytime",
                    "url": "https://images.unsplash.com/photo-1606064195579-a48c728cec35?ixid=MnwzODAyMzF8MHwxfHNlYXJjaHw5fHxsYW9zfGVufDB8fHx8MTY2ODMwMzgzMA&ixlib=rb-4.0.3"
                },
                {
                    "alt_tag": "body of water during sunset",
                    "url": "https://images.unsplash.com/photo-1553856622-d1b352e9a211?ixid=MnwzODAyMzF8MHwxfHNlYXJjaHwxMHx8bGFvc3xlbnwwfHx8fDE2NjgzMDM4MzA&ixlib=rb-4.0.3"
                }
            ]
        }
    }
}
```

## Contributions
<a href="https://github.com/Dominicod/rails-engine-lite/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Dominicod/rails-engine-lite" />
</a>
<p>🔥 Github: <a href="https://github.com/Dominicod">https://github.com/Dominicod</a> LinkedIn: <a href="https://www.linkedin.com/in/dominic-odonnell/">https://www.linkedin.com/in/dominic-odonnell/</a>  </p>


