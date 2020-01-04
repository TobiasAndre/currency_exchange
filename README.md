# Ruby on rails Microservice
This project is a Ruby on rails microservice without database using Redis to cache endpoints. According to the fact that the main features are provided from external 3rd part APIs, the database option was removed. This API gets the user parameters and call another service to process request and return the required information.

### Endpoints

    http://localhost:8081/api/datetime/current

No params.

returns the current datetime
 
    http://localhost:8081/api/currency/convert

gets the current quote for two types of currency and calculate according to the amount passed

Params(url):
1. source_currency Ex: BRL
2. target_currency Ex: USD
3. amount: Ex: 10.00

Final url request example:

http://localhost:8081/api/currency/convert?source_currency=BRL&target_currency=USD&amount=10.00


    http://localhost:8081/api/validators/validate_vat

validates a vat number passed and returns the original country code

Final url request example:

http://localhost:8081/api/validators/validate_vat?vat_code=CZ999999

### Running locally
If you want to run this project locally (A Running [`Redis`](https://redis.io/topics/quickstart) instance are needed)
```
$ bundle install
$ rails s
```

### Running tests
If you want to run tests locally:
```
$ rspec
```

### Running with docker
The project has Docker file and docker-compose file for running easily.
At the project root directory, run:

```
$ docker-compose build
$ docker-compose up
```
