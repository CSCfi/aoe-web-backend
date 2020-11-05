import errorHandler from "errorhandler";

import app from "./app";

/**
 * Error Handler. Provides full stack - remove for production
 */
app.use(errorHandler());

/**
 * Start Express server.
 */
const server = app.listen(process.env.PORT || 3000, () => {
  console.log(
    "  App is running at http://localhost:%d in %s mode",
    app.get("port"),
    app.get("env")
  );
  console.log(" Press CTRL-C to stop\n");
  console.log(server.address());
});

server.on("connection", function (socket) {
  socket.setTimeout(600 * 60 * 1000);
  console.log("SOCKET OPENED" + JSON.stringify(socket.address()));
socket.on("end", function () {
  console.log("SOCKET END: other end of the socket sends a FIN packet");
});

socket.on("timeout", function () {
  console.log("SOCKET TIMEOUT");
});

socket.on("error", function (error) {
  console.log("SOCKET ERROR: " + JSON.stringify(error));
});

socket.on("close", function (had_error) {
  console.log("SOCKET CLOSED. IT WAS ERROR: " + had_error);
});
});
// const server = app.listen(3000, "127.0.0.1");

export default server;
