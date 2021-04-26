## WIREMOCK

Local server for testing purpose.

#### Installation

Run the mocked server with `start_server.sh`

Needs java runtime https://www.java.com/en/download/

#### Stubbing

http://wiremock.org/docs/stubbing/

#### Request matching

http://wiremock.org/docs/request-matching/

Query parameters match:
```
"queryParameters" : {
    "search_term" : {
        "equalTo" : "WireMock"
    }
}
```
