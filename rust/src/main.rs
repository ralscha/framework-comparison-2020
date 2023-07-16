use salvo::prelude::*;
use serde::{Serialize};

#[derive(Serialize, Debug)]
struct HelloMessage {
    msg: String,
    ts: u128
}

#[handler]
async fn hello_world(req: &mut Request, res: &mut Response) {
    let name = req.param::<&str>("name").unwrap();
    let ts = std::time::SystemTime::now().duration_since(std::time::UNIX_EPOCH).unwrap().as_millis();
    let msg = HelloMessage{msg: say_hello(name), ts };
    res.render(Json(msg));
}

fn say_hello(name: &str) -> String {
    format!("Hello {}", name)
}


#[tokio::main]
async fn main() {
    let acceptor = TcpListener::new("127.0.0.1:8080").bind().await;
    let router = Router::with_path("helloJSON/<name>").get(hello_world);
    Server::new(acceptor).serve(router).await;
}
