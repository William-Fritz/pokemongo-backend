# Pokemon Go API Blueprint

## GET /players
+ Requests
  + Authentication
    <!-- bearer token will hold player Id, authentication will not be implemented for simplicity -->
    + bearer.token
+ Response
  + data
    + player_name: "Kevin" (string)
    + pokemon_count: 4 (int)
    + unique_pokemon: 3 (int)
  + meta
    + http_status: 200 (number, required) - status code
 
## GET /pokemons
+ Requests
  + Authentication
    + bearer.token
+ Response
  + data
    + pokemon_name: "Lotad" (string)
    + pokemon_type1: "Water" (string)
    + pokemon_level: 6 (int)
    + pokemon_exp: 40 (int)
    + pokemon_stat: 0 (int)
    + pokemon_item_hold: 0 (int)
    + pokemon_move1: 4 (int)
  + meta
    + http_status: 200 (number, required) - status code
    
## GET /eggs
+ Requests
  + Authentication
    + bearer.token
+ Response
  + data
    + eggs(array):
      + object
        + eggs_type: 1
        + eggs_count: 5
        + eggs_distance_traveled: 2000
      + object
        + eggs_type: 2
        + eggs_count: 3
        + eggs_distance_traveled: 3500
  + meta
    + http_status: 200 (number, required) - status code  

## GET /eggs
+ Requests
  + Authentication
    + bearer.token
+ Response
  + data
    + eggs_type: 2 (int)
    + eggs_distance_needed: 5000 (int)
    + eggs_distance_traveled: 3000 (int)
    + eggs_distance_left: 2000 (int)
  + meta
    + http_status: 200 (number, required) - status code

## GET /inventories
+ Requests
  + Authentication
    + bearer.token
+ Response 
  + data
    + inventory(array):
      + object
        + item_no: 2
        + item_name: "Potion"
        + item_qty: 10
      + object
        + item_no: 4
        + item_name: "Ether"
        + item_qty: 15
  + meta
    + http_status: 200 (number, required) - status code

## PATCH /players
+ Requests
  + Authentication
    + bearer.token
+ Response
  + message: 'Ok'
  + meta
    + http_status: 200 (number, required) - status code

## PATCH /pokemons
+ Requests
  + Authentication
    + bearer.token
+ Response
  + message: 'Ok'
  + meta
    + http_status: 200 (number, required) - status code

## PATCH /inventories
+ Requests
  + Authentication
    + bearer.token
+ Response
  + message: 'Ok'
  + meta
    + http_status: 200 (number, required) - status code
       
## DELETE /pokemons
+ Requests
  + Authentication
    + bearer.token
+ Response
  + message: 'Ok'
  + meta
    + http_status: 200 (number, required) - status code
