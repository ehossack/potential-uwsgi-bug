
### Steps to reproduce

1. `poetry install`
2. `poetry run docker-compose up --build`
3. verify it's running by visiting localhost:8088
4. visit `http://localhost:8088/reproduction/`

#### Expected

Wait 120 seconds, get the json response

#### Actual

after 60 seconds, get a 502 response from nginx
"upstream prematurely closed connection while reading response header from upstream"

The response actually does complete after the 120 seconds