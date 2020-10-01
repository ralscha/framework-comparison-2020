package main

import (
	"time"

	"github.com/gofiber/fiber/v2"
)

type HelloMessage struct {
	Msg string `json:"msg"`
	Ts  int64  `json:"ts"`
}

func jsonHandler(c *fiber.Ctx) error {
	helloMessage := HelloMessage{Msg: sayHello(c.Params("name")), Ts: time.Now().Unix()}
	return c.JSON(helloMessage)
}

func sayHello(name string) string {
	return "Hello " + name
}

func main() {
	app := fiber.New()

	app.Get("/helloJSON/:name", jsonHandler)

	app.Listen(":8080")
}
