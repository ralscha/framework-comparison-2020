package main

import (
	"encoding/json"
	"log"
	"net/http"
	"strings"
	"time"
)

type HelloMessage struct {
	Msg string `json:"msg"`
	Ts  int64  `json:"ts"`
}

func jsonHandler(w http.ResponseWriter, r *http.Request) {
	name := strings.TrimPrefix(r.URL.Path, "/helloJSON/")
	helloMessage := HelloMessage{Msg: sayHello(name), Ts: time.Now().Unix()}
	json.NewEncoder(w).Encode(helloMessage)
}

func sayHello(name string) string {
	return "Hello " + name
}

func main() {
	http.HandleFunc("/helloJSON/", jsonHandler)
	log.Fatal(http.ListenAndServe(":8080", nil))
}
